//
//  WLBaseRest.m
//  iWave2
//
//  Created by Marco Lorenz on 11.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRest.h"

#import "WLLoginResponse.h"
#import "User.h"
#import "WLAppDelegate.h"
#import "WLUserProfileResponse.h"
#import "Teammate.h"
#import "NewsMessages.h"
#import "WLVacationRest.h"
#import "WLBaseResponse.h"
#import "WLUserProfileRequest.h"
#import "WLMappingHelper.h"

@interface WLBaseRest()

/**---------------------------------------------------------------------------------------
 * @name Handling Vacation Rest-Service
 *  ---------------------------------------------------------------------------------------
 */
/** Managing the server communication concerning vacation.
@see WLVacationRest
*/
@property (nonatomic,strong) WLVacationRest *vacationRestService;

@end

@implementation WLBaseRest

/**---------------------------------------------------------------------------------------
 * @name Calling Rest-Service
 *  ---------------------------------------------------------------------------------------
 */
/** Doing a rest call to manage the login communication.
 On Login user profile request and user vacation information request are executed too.
@param postParameters Is a NSDictionary that contents login parameters.
*/
-(void)doLoginWithParameters:(NSDictionary *)postParameters{
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    //do Login
    [[RKObjectManager sharedManager] postObject:nil path:LOGIN_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *result) {
        NSLog(@"Login-Response received: %@", operation.description);
        
        WLLoginResponse *response = (WLLoginResponse *) result.firstObject;
        
        NSSet *errMsgs=   response.errMsgs;
        
        if (![response hasErrors]) {
            
            NSLog(@"Login user %@.", response.loginName);
            session.sessionUserId = response.userId;
            session.displayName = response.displayName;
            
            //User authentification has finished successfull.
            [self.delegate restService:self didFinishRestCallWithResponse:response andDescription:LOGIN_DESCRIPTION];
            
            [self saveOrUpdateUserFromWLLoginResponse:response];
            [self saveNewsMessagesFromWLLoginResponse:response];
            
            //save Settings, Userdata and News
            NSLog(@"Saving UserDefaults");
            [managedObjectContext MR_saveToPersistentStoreAndWait];
            
        }        
        else
        {
            NSLog(@"There were %d Error-Messages!", errMsgs.count);
            
            NSEnumerator *enumerator = [errMsgs objectEnumerator];
            id value;
            
            NSString *errorFinal = @"";
            
            while ((value = [enumerator nextObject])) {
                NSLog(@"Error: %@", (NSString *) value);
                NSString *errString = [@"\n" stringByAppendingString:(NSString *) value];
                errorFinal = [errorFinal stringByAppendingString:errString];
            }
            
            [self.delegate restService:self didFinishRestCallWithErrors:errorFinal andDescription:LOGIN_DESCRIPTION];
        }
    }    failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Login-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        
        [self.delegate restService:self didFinishRestCallWithErrors:error.localizedDescription andDescription:LOGIN_DESCRIPTION];
    }];

}

/** Called to get users vacation information from server and to write it in core data. */
-(void)doVacationInformationRequest{
    
    //preparing for UserProfileRequest
    WLUserProfileRequest *userProfileRequest = [[WLUserProfileRequest alloc]init];
    userProfileRequest.userId = session.sessionUserId;
    
    NSDictionary *postParameters = [WLMappingHelper postParameterFromUserProfileRequest:userProfileRequest];
    
    
    //get Vacation DemandList
    self.vacationRestService = [[WLVacationRest alloc]init];
    self.vacationRestService.delegate = self;
    [self.vacationRestService postUserVacationInformation:postParameters];
}

/** Doing the user profile Request and updating all relationships to other users.
 @param managedObjectContext The context the core data is saved
 @param aUser The logged in userdata.
 */
- (void)doUserProfileRequest:(NSManagedObjectContext *)managedObjectContext aUser:(User *)aUser {
    
    //preparing for UserProfileRequest
    WLUserProfileRequest *userProfileRequest = [[WLUserProfileRequest alloc]init];
    userProfileRequest.userId = session.sessionUserId;
    
    NSDictionary *postParameters = [WLMappingHelper postParameterFromUserProfileRequest:userProfileRequest];
    
    [[RKObjectManager sharedManager] postObject:nil path:REQUEST_USER_PROFILE_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        NSLog(@"User-Profile-Response received: %@", operation.description);
        WLUserProfileResponse *response = (WLUserProfileResponse *)mappingResult.firstObject;
        
        if([response hasErrors]){
            NSLog(@"Error: %@",(NSString *)[response.errMsgs anyObject]);
            NSLog(@"Create User from LoginResponse");
        }
        else if(![response hasValidToken]){
            NSLog(@"Invalid Token Error");
        }
        else
        {
            
            NSLog(@"Map user %@.", response.displayName);
            
            aUser.department = response.department;
            aUser.shortName = response.shortName;
            aUser.email = response.email;
            aUser.firstName = response.firstName;
            aUser.lastName = response.lastName;
            aUser.telephoneNumber = response.phoneNumber;
            
            //is Manager if has directReports
            if([response.directReports count]>0)
                session.isManager = true;
            
            
            id nul = [NSNull null];
            
            //create Manager from Response if unknown
            for(NSDictionary *managerDic in response.manager){
                
                if(managerDic == nul){
                    session.hasManager = NO;
                    continue;
                }
                
                if(![Teammate MR_findFirstByAttribute:@"waveUserId" withValue:(NSNumber*)[managerDic objectForKey:@"waveUserId"]]){
                    [self relationshipFromDictionary:managerDic andManagedObjectContext:managedObjectContext andRelation:[[NSNumber alloc] initWithInt: MANAGER]];
                }
            }
            
            //create Teammates from Response if unknown
            for(NSDictionary *teamMates in response.teamMates){
                
                if(teamMates == nul)
                    continue;
                
                [self relationshipFromDictionary:teamMates andManagedObjectContext:managedObjectContext andRelation:[[NSNumber alloc] initWithInt: TEAMMATE]];
                
            }
            
            //create directReports from Response if unknown
            for(NSDictionary *directReports in response.directReports){
                
                if(directReports == nul)
                    continue;
                
                [self relationshipFromDictionary:directReports andManagedObjectContext:managedObjectContext andRelation:[[NSNumber alloc] initWithInt: DIRECTREPORT]];
                
            }
            
            //create otherReports from Response if unknown
            for(NSDictionary *otherReports in response.otherUserReports){
                
                if(otherReports == nul)
                    continue;
                
                [self relationshipFromDictionary:otherReports andManagedObjectContext:managedObjectContext andRelation:[[NSNumber alloc] initWithInt: OTHERUSERREPORT]];
            }
            
            
            //remove empty Teammtes
            NSArray *allTeamMates = [Teammate MR_findAll];
            for(Teammate *mate in allTeamMates){
                if(!mate.displayName)
                    [mate MR_deleteEntity];
            }
            
        }
        
        //getting vacation information on finishing user profile
        [self doVacationInformationRequest];
        [self.delegate restService:self didFinishRestCallWithResponse:response andDescription:USER_PROFILE_DESCRIPTION];
        //save Settings
        NSLog(@"Saving Users");
        [managedObjectContext MR_saveToPersistentStoreAndWait];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"User-Profile-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        NSLog(@"Create User from LoginResponse");
        
        //getting vacation information on finishing user profile even, when user profile respose finished with errors.
        [self doVacationInformationRequest];
        [self.delegate restService:self didFinishRestCallWithErrors:error.description andDescription:USER_PROFILE_DESCRIPTION];
        
        //save Settings
        NSLog(@"Saving User");
        [managedObjectContext MR_saveToPersistentStoreAndWait];
    }];
}


#pragma mark - private, additional Methods
/**---------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/** Creating relationship to users from dictionay got from userProfileResponse.
 @param dictionary The dictionary containing the data for teammates.
 @param managedObjectContext The context the core data is saved
 @param relation The defined relation to the usergroup in dictionary.
 @see Teammate
 */
- (void)relationshipFromDictionary:(NSDictionary *)dictionary andManagedObjectContext:(NSManagedObjectContext *)managedObjectContext andRelation:(NSNumber*)relation  {
    id nul = [NSNull null];
    
    @try{
        //[managerDic count];
        Teammate *mate = [Teammate MR_createInContext:managedObjectContext];
        mate.displayName = (NSString*)[dictionary objectForKey:@"displayName"];
        
        NSNumber *uId = (NSNumber*)[dictionary objectForKey:@"waveUserId"];
        if(uId != nul)
            mate.waveUserId = (NSNumber*)[dictionary objectForKey:@"waveUserId"];
        mate.relationToUser = relation;
    }
    @catch (NSException *e) {
        NSLog(@"Exception: %@",e);
    }
}


 /** Doing a rest call to get user data from wave intranet.
 
 Existing User entities will be updated and others are created.
 Additional the method creates all Teammate objects having a relation to the logged in user.
@param loginResponse The response from server mapped in an object.
@see WLLoginResponse
@see Teammate
 */
- (void)saveOrUpdateUserFromWLLoginResponse:(WLLoginResponse *)loginResponse {
    
    User *aUser = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    if (!aUser) {
        NSLog(@"User will be created in CoreData.");
        //create
        aUser = [User MR_createInContext:managedObjectContext];
        aUser.loginName = loginResponse.loginName;
        aUser.email = loginResponse.email;
    } else {
        NSLog(@"User found, will be updated in CoreData.");
    }
    
    [self doUserProfileRequest:managedObjectContext aUser:aUser];
    
    aUser.userId = session.sessionUserId;
}

/** Doing a rest call to get user data from wave intranet. This is only called on URL-Start.
 
 Existing User entities will be updated and others are created.
 Additional the method creates all Teammate objects having a relation to the logged in user.
 @see Teammate
 */
- (void)saveOrUpdateUserFromUrl{
    
    User *aUser = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    if (!aUser) {
        NSLog(@"User will be created in CoreData.");
        //create
        aUser = [User MR_createInContext:managedObjectContext];
        aUser.loginName = @"";
        aUser.email = @"";
    } else {
        NSLog(@"User found, will be updated in CoreData.");
    }
    
    [self doUserProfileRequest:managedObjectContext aUser:aUser];
    
    aUser.userId = session.sessionUserId;
}

/** Saves or updates the NewsMessages in core data.
@param loginResponse The response from server mapped to an object.
@see WLLoginResponse
@see NewsMessages
*/
- (void)saveNewsMessagesFromWLLoginResponse:(WLLoginResponse *)loginResponse {
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    NSEnumerator *enumerator = [loginResponse.newsMsgs objectEnumerator];
    id value;
    
    while (value = [enumerator nextObject] ) {
        
        NewsMessages *aMessage = [NewsMessages MR_findFirstByAttribute:@"msgText" withValue:(NSString *)value];
        
        if (!aMessage) {
            NSLog(@"Message will be created in CoreData.");
            //create
            aMessage = [NSEntityDescription insertNewObjectForEntityForName:@"NewsMessages" inManagedObjectContext:managedObjectContext];
            aMessage.msgText = (NSString *)value;
            aMessage.receivedDate = [NSDate date];
            aMessage.alreadyRead = @0;
            aMessage.userId = session.sessionUserId;
            
        } else {
            NSLog(@"Message already exists.");
        }
        
        [managedObjectContext MR_saveToPersistentStoreAndWait];
    }
}



#pragma mark - Rest Delegate
/**---------------------------------------------------------------------------------------
 * @name Respond to Rest Service Protocol
 *  ---------------------------------------------------------------------------------------
 */
/** Called when vacation information request finished successfull.
 
 Handling on success is delegated.
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 */
-(void)restService:(id)restService didFinishRestCallWithResponse:(id)response andDescription:(NSString *)description{
    
    [self.delegate restService:restService didFinishRestCallWithResponse:response andDescription:description];
}

/** Called when vacation information request finished with errors.
 
 Showing error message is delegated.
 @param restService The vacation rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description.
 */
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString *)errorMessage andDescription:(NSString *)description{
    
    [self.delegate restService:restService didFinishRestCallWithErrors:errorMessage andDescription:description];
}

@end
