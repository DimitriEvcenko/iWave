//
//  WLVacationRest.m
//  iWave2
//
//  Created by Marco Lorenz on 12.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationRest.h"

#import "WLVacationDemandListResponse.h"
#import "WLVacationDemandListItem.h"
#import "VacationDemandStatus.h"
#import "VacationDemandType.h"
#import "WLMappingHelper.h"
#import "WLAppDelegate.h"
#import "Teammate.h"
#import "VacationDemandLocal.h"
#import "WLVacationDecisionResponse.h"
#import "WLVacationDeleteResponse.h"
#import "WLVacationDemandResponse.h"

@implementation WLVacationRest

/**---------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/**
 Creating a vacation demand in core data from a vacation demand list item.
 @param item A item that contains all information of a vacation demand.
 @return The created vacation demand.
 */
-(VacationDemand*)createVacationDemand:(WLVacationDemandListItem*)item{
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    VacationDemand *demand = [VacationDemand MR_createInContext: managedObjectContext];
    NSLog(@"Creating new VacationDemand with ID:%@",item.id);
    demand.id = item.id;
    
    demand.startDate = [[NSDate alloc] initWithTimeIntervalSince1970:item.startDate/1000];
    demand.endDate = [[NSDate alloc] initWithTimeIntervalSince1970:item.endDate/1000];
    demand.demandStatus = [VacationDemandStatus MR_createInContext:managedObjectContext];
    demand.demandType = [VacationDemandType MR_createInContext:managedObjectContext];
    demand.demandType.name = item.demandType;
    demand.comment = item.comment;
    demand.userDisplayName = item.userDisplayName;
    
    if([item.userDisplayName isEqualToString:session.displayName]){
        demand.userId = session.sessionUserId;
        demand.demandStatus.name = item.status;
    }
    else{
        //userID is not needed
        demand.userId = nil;
        demand.demandStatus.name = [self demandStatusFromDisplayName:demand.userDisplayName];
    }
    
    return demand;
}

/** Returns a special vacation demand type for reports, if user is manager.
 
 Managers reports vacation demands that server asks for are normaly pending.
 To seperate them from the logged in users pending request, this method generates demand types for:
 
    diectReports "TEAMVACATION";
    othrReports = "OTHERREPORTSVACATION";
 
 @param displayName Displayed name of the report.
 @return The string to display reports vacation.
 @warning Userid cannot be used as primary key here, because vacation demand list does not return reports userIds.
 */
-(NSString*)demandStatusFromDisplayName:(NSString*)displayName{
    
    NSArray *teamMatesWithId = [Teammate MR_findByAttribute:@"displayName" withValue:displayName];
    
    for(Teammate *mate in teamMatesWithId){

        if([mate.relationToUser isEqualToNumber: [[NSNumber alloc] initWithInt:TEAMMATE]])
            continue;
        
        switch ([mate.relationToUser intValue]) {
            case DIRECTREPORT:
                return VS_TEAM;
            case OTHERUSERREPORT:
                return VS_TEAM_INDIRECT;
            default:
                break;
        }
        
    }
    
    return @"";
}

/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */
/**
 Sending a single VacationDemand to the Server getting a Response
 @param postParameters is a Dictionary from a VacationDemandRequest
 @see WLVacationDemandRequest
 */
-(void)sendVacationDemandRequest:(NSDictionary *)postParameters{
    
    [[RKObjectManager sharedManager] postObject:nil path:REQUEST_VACATION_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"VacationDemand successfull requested, %@", operation.description);
        
        WLVacationDemandResponse *result = (WLVacationDemandResponse*)[mappingResult firstObject];
        
        if([result hasErrors]){
            NSString *errorMessage = @"";
            for(NSString *error in [result.errMsgs allObjects])
                errorMessage = [NSString stringWithFormat:@"%@ %@",errorMessage,error];
            
            
            [self delegateRestError:errorMessage withDescription:REQUEST_VACATION_DESCRIPTION];
        }
        else if(![result hasValidToken]){
            NSLog(@"Invalid Token Error");
            [self delegateRestError:NSLocalizedString(@"InvalidTokenError", @"invalide token message") withDescription:REQUEST_VACATION_DESCRIPTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:NO_TOKEN_NOTIFICATION object:self];
        }
        else{
            
            [self delegateRestCallFinishedWithResponse:result andDescription:REQUEST_VACATION_DESCRIPTION];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Vacation-Demand-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        
        [self delegateRestError:error.localizedDescription withDescription:REQUEST_VACATION_DESCRIPTION];
    }];
}

/** Get all the information about users vacation.
 
 A Manager also gets the information about pending vacation of theire reports.
 @param postParameters A user profile request.
 @see WLUserProfileRequest
 */
-(void)postUserVacationInformation:(NSDictionary*)postParameters{
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    [[RKObjectManager sharedManager] postObject:nil path:USER_VACATION_INFORMATION_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        WLVacationDemandListResponse *response = (WLVacationDemandListResponse*)[mappingResult firstObject];
        
        if([response hasErrors]){
            NSString *errorMessage = (NSString *)[response.errMsgs anyObject];
            NSLog(@"Error: %@",errorMessage);
            [self delegateRestError:errorMessage withDescription:VACATION_INFORMATION_DESCRIPTION];
            
        }
        else if(![response hasValidToken]){
            NSLog(@"Invalid Token Error");
            [self delegateRestError:NSLocalizedString(@"InvalidTokenError", @"invalide token message") withDescription:VACATION_INFORMATION_DESCRIPTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:NO_TOKEN_NOTIFICATION object:self];
        }
        else{
            
            //check for no VacartionDemands
            if([mappingResult.array count]>0){
                
                for(NSDictionary *itemDict in response.vacationDemands){
                    
                    WLVacationDemandListItem *item = [WLMappingHelper vacationDemandListItemFromDictionary:itemDict];
                    
                    VacationDemand *demand = [VacationDemand MR_findFirstByAttribute:@"id" withValue:item.id];
                    
                    if(!demand){
                        
                        demand = [self createVacationDemand:item];
                    }
                    else{
                        NSLog(@"Update VacationDemand Status with ID:%@",item.id);
                        
                        demand.demandStatus = [VacationDemandStatus MR_createInContext:managedObjectContext];
                        demand.demandStatus.name = item.status;
                    }
                }
            }
            else{
                NSLog(@"No VacationDemandItem existing");
            }
        }
        
        [self delegateRestCallFinishedWithResponse:response andDescription:VACATION_INFORMATION_DESCRIPTION];
        
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        
        NSLog(@"Vacation-Information-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        
        [self delegateRestError:error.localizedDescription withDescription:VACATION_INFORMATION_DESCRIPTION];
        
    }];
    
    //add the unrequested Demands from the local Store
    NSArray *localDemands = [VacationDemandLocal MR_findByAttribute:USERID withValue:session.sessionUserId];
    
    for(VacationDemandLocal *localDemand in localDemands){
        
        VacationDemand *demand = [VacationDemand MR_createInContext:managedObjectContext];
        
        demand.demandStatus = [VacationDemandStatus MR_createInContext:managedObjectContext];
        demand.demandType = [VacationDemandType MR_createInContext:managedObjectContext];
        
        demand.id = localDemand.id;
        demand.startDate = localDemand.startDate;
        demand.endDate = localDemand.endDate;
        demand.comment = localDemand.comment;
        demand.demandType = localDemand.demandType;
        demand.demandStatus = localDemand.demandStatus;
        demand.createdOn = localDemand.createdOn;
        demand.userDisplayName = localDemand.userDisplayName;
        demand.userId = localDemand.userId;
        
    }
}

/** Sending reports vacation decision as request to server.
 @param postParameters An vacation decision request.
 @param sender The control that caused the action.
 @see WLVacationDecisionRequest
 */
-(void)sendVacationDecisionRequest:(NSDictionary*)postParameters{
    
    [[RKObjectManager sharedManager] postObject:nil path:DECIDE_VACATION_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        WLVacationDecisionResponse *response = (WLVacationDecisionResponse *)mappingResult.firstObject;
        
        if([response hasErrors]){
            
            NSString *errorMessage = @"";
            
            for(NSString *err in response.errMsgs){
                errorMessage = [NSString stringWithFormat:@"%@ %@", errorMessage, err];
            }
            NSLog(@"Error: %@",errorMessage);
            [self delegateRestError:errorMessage withDescription:DECIDE_VACATION_DESCRIPTION];
            }
        else if(![response hasValidToken]){
            NSLog(@"Invalid Token Error");
            [self delegateRestError:NSLocalizedString(@"InvalidTokenError", @"invalide token message") withDescription:DECIDE_VACATION_DESCRIPTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:NO_TOKEN_NOTIFICATION object:self];
        }
        else{
            
            [self delegateRestCallFinishedWithResponse:response andDescription:DECIDE_VACATION_DESCRIPTION];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Vacation-Decision-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        
        [self delegateRestError:error.localizedDescription withDescription:DECIDE_VACATION_DESCRIPTION];
    }];
    
}

/** Sending vacation delete request to server.
 @param postParameters An vacation delete request.
 @param sender The control that caused the action.
 @see WLVacationDeleteRequest
 */
-(void)sendVacationDeleteRequest:(NSDictionary*)postParameters{
    
    [[RKObjectManager sharedManager] postObject:nil path:DELETE_VACATION_URL parameters:postParameters success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        
        WLVacationDeleteResponse *response = (WLVacationDeleteResponse *)mappingResult.firstObject;
        
        if([response hasErrors]){
            
            NSString *errorMessage = @"";
            
            for(NSString *err in response.errMsgs){
                errorMessage = [NSString stringWithFormat:@"%@ %@", errorMessage, err];
            }
            NSLog(@"Error: %@",errorMessage);
            [self delegateRestError:errorMessage withDescription:DELETE_VACATION_DESCRIPTION];
        }
        else if(![response hasValidToken]){
            NSLog(@"Invalid Token Error");
            [self delegateRestError:NSLocalizedString(@"InvalidTokenError", @"invalide token message") withDescription:DELETE_VACATION_DESCRIPTION];
            [[NSNotificationCenter defaultCenter] postNotificationName:NO_TOKEN_NOTIFICATION object:self];
        }
        else{         
            
            [self delegateRestCallFinishedWithResponse:response andDescription:DELETE_VACATION_DESCRIPTION];
        }
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"Vacation-Delete-Request und Mapping nicht erfolgreich! %@ -> %@", error.description, operation.description);
        [self delegateRestError:error.localizedDescription withDescription:DELETE_VACATION_DESCRIPTION];
    }];
}
/**---------------------------------------------------------------------------------------
 * @name Delegate Rest Events
 *  ---------------------------------------------------------------------------------------
 */
/** Telling the delegate to call restService:didFinishRestCallWithErrors:andDescription:, when there is a responder.
 @param errorMessage The error message caused the error in rest call.
 @param description The containing errors rest calls description.
 */
-(void)delegateRestError:(NSString*)errorMessage withDescription:(NSString*)description{
    if([self.delegate respondsToSelector:@selector(restService:didFinishRestCallWithErrors:andDescription:)])
        [self.delegate restService:self didFinishRestCallWithErrors:errorMessage andDescription:description];
}

/** Telling the delegate to call restService:didFinishRestCallWithResponse:andDescription:, when there is a responder.
 @param response The rest calls response.
 @param description The rest call description string.
 @see WLBaseResponse
 */
-(void)delegateRestCallFinishedWithResponse:(id)response andDescription: (NSString*)description{
    if([self.delegate respondsToSelector:@selector(restService:didFinishRestCallWithResponse:andDescription:)])
        [self.delegate restService:self didFinishRestCallWithResponse:response andDescription:description];
}

@end
