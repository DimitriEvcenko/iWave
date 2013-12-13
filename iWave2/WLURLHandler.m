//
//  WLURLHandler.m
//  iWave2
//
//  Created by Alexander Eiselt on 21.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLURLHandler.h"

@implementation WLURLHandler

/**------------------------------------------------------------------------
 * @name Configure the Shared URLHandler Instance
 *-------------------------------------------------------------------------
 */
/** Return the shared instance of the url handler object
 @return The shared url handler instance*/
+ (id)sharedHandler {
    static WLURLHandler *myHandler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        myHandler = [[self alloc] init];
    });
    return myHandler;
}

/** Instantiates an URLHandler object
 @return An url handler object.
 */
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/**-----------------------------------------------------------
 *@name Starting by URL
 *------------------------------------------------------------
 */
/** Mapping the parameter from url into a dictionary
 @param url The url with the parameters
 @return A dicitonary with the parameter from url.
 */
-(NSDictionary*)dictionartyFromUrlRequest:(NSURL*)url
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    for (NSString *param in [url.query componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    
    return params;
}

/** Doing all that is needed on starting from url, like rest calls or naviagte user to the correct view.
 @param url The url the application is started with.
 @param navigationController The navigation controller where user should be navigatet through the app.
 */
-(void)handleURL:(NSURL *)url withNavigationController:(UINavigationController *)navigationController
{
    self.navController = navigationController;
    self.url = url;
    
    NSDictionary *params = [self dictionartyFromUrlRequest:url];
    NSNumberFormatter  * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    NSNumber * userId = [f numberFromString:[params valueForKey:USERID]];
    
    if([self.url.host isEqualToString:@"karibik"])
    {
        if([self.url.lastPathComponent isEqualToString:@"antrag"])
        {
            
            if([params objectForKey:USERID] && [params objectForKey:VACATIONID] && [params objectForKey:TOKEN])
            {                
                session.sessionUserId = userId;
                session.token = [params valueForKey:TOKEN];
                self.restService = [[WLBaseRest alloc]init];
                self.restService.delegate = self;
                [self.restService saveOrUpdateUserFromUrl];
            }
        }
    }
}

/** Navigates programmaticaly to the vacation demand detail view controller and displays the vacation demand from parameter.
 @param demand The vacation demand that should be displayed.
 */
-(void)navigateToVacationDemand:(VacationDemand*)demand{
    
    // do the navigation from the first controller
    [self.navController popToRootViewControllerAnimated:NO];
    
    WLMainCollectionViewController *mainMenu = [[UIStoryboard storyboardWithName:@"MainStoryboard_iPad" bundle:nil] instantiateViewControllerWithIdentifier:@"mainCollectionView"];
    [self.navController pushViewController:mainMenu animated:NO];
    [mainMenu performSegueWithIdentifier:@"showVacation" sender:mainMenu];
    
    
    NSLog(@"%@",[[self.navController.viewControllers objectAtIndex:2] class]);
    WLVacationNavigationViewController *vacationNavigationView = (WLVacationNavigationViewController*)[self.navController.viewControllers objectAtIndex:2];
    [vacationNavigationView setSelectedIndex:1];
    
    WLVacationDetailEditViewController *editView = (WLVacationDetailEditViewController*)[vacationNavigationView.viewControllers objectAtIndex:1];
    
    WLVacationDetailViewController *detailView = (WLVacationDetailViewController*)[editView.splittViewEmbedded.viewControllers objectAtIndex:1];
    
    
    [detailView initForView:demand];
    [detailView.tableView reloadData];
}

/**---------------------------------------------------------------------------------------
 * @name Managing the Restcalls
 *  ---------------------------------------------------------------------------------------
 */
/** Handles finishing the vacation information rest call on url-starting the application.
 
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 @see WLRestServiceProtocol.
 */
-(void)restService:(id)restService didFinishRestCallWithResponse:(id)response andDescription:(NSString *)description
{
    if([description isEqualToString:VACATION_INFORMATION_DESCRIPTION]){
    
        NSDictionary *params = [self dictionartyFromUrlRequest:self.url];
    
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        self.myDemand = [VacationDemand MR_findFirstByAttribute:@"id" withValue:[params valueForKey:VACATIONID]];
    
        [self navigateToVacationDemand:self.myDemand];
    }
    
}

/** Shows an error message when rest call finished with error.
 @param restService The rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description. call.
 @see WLRestServiceProtocol.
 */
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString *)errorMessage andDescription:(NSString *)description
{
    UIAlertView *aView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", @"") message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [aView show];
}
@end
