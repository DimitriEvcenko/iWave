//
//  WLAppDelegate.m
//  iWave2
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLAppDelegate.h"
#import "LoginSettings.h"
#import "CommonSettings.h"
#import "WLAppStyle.h"
#import "VacationDemand.h"
#import "VacationDemandType.h"
#import "VacationDemandStatus.h"
#import "User.h"
#import "WLTutorial.h"
#import "VacationDemandLocal.h"
#import "Teammate.h"


@implementation WLAppDelegate

/**------------------------------------------------------------------------------------
*@name Monitoring App State Changes
*--------------------------------------------------------------------------------------
*/
/** Tells the delegate that the launch process is almost done and the app is almost ready to run.

Setup of SQLite, applications style and session information is done.
@param application The delegating application object.
@param launchOptions A dictionary indicating the reason the application was launched.
*/
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [DDLog addLogger:[DDASLLogger sharedInstance]];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [MagicalRecord setupCoreDataStackWithStoreNamed:@"MyDatabase.sqlite"];
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [WLAppStyle applyStyle];
    
    session = [[WLSession alloc]init];
    
    return YES;
}

/** Tells the delegate that the application is about to become inactive.
@param application The singleton application instance.
*/
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

/** Tells the delegate that the application is now in the background.
@param application The singleton application instance.
*/
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

/** Tells the delegate that the application is about to enter the foreground.
@param application The singleton application instance.
*/
- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

/** Tells the delegate that the application has become active.
@param application The singleton application instance.
*/
- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

/** Tells the delegate when the application is about to terminate.

On Termination core data is handled.
@param application The singleton application instance.
*/
- (void)applicationWillTerminate:(UIApplication *)application
{
    [self deleteTemporaryData];
    [self saveContext];
}
/**---------------------------------------------------------------------
*@name Responding to System Notifications
*-----------------------------------------------------------------------
*/
/** Tells the delegate when there is a significant change in the time.

Is used to autosave the context.
@param application The instance of the application that has the time change.
*/
-(void)applicationSignificantTimeChange:(UIApplication *)application{
    [self saveContext];
}

/**---------------------------------------------------------------------
*@name Handling Core Data
*-----------------------------------------------------------------------
*/
/** Saving applications data to persistance store.
*/
- (void)saveContext {
    //save lastLoginDate
    User *user = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId ];
    user.lastLogin = [[NSDate alloc] init];
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    
    [context MR_saveToPersistentStoreAndWait];
}

/** Deleting session NSManagedObjects. */
-(void)deleteTemporaryData{
    
    //Delete VacationDemands
    NSArray *demands = [VacationDemand MR_findAll];
    
    NSManagedObjectContext *context = [NSManagedObjectContext MR_contextForCurrentThread];
    
    //remove the users locale demands
    NSArray *locals = [VacationDemandLocal MR_findByAttribute:USERID withValue:session.sessionUserId];
    
    for(VacationDemandLocal *local in locals)
            [local MR_deleteEntity];
    
    for(VacationDemand *demand in demands){
        
        NSLog(@"Status: %@",demand.demandStatus.name);
        
        if([demand.demandStatus.name isEqualToString:VS_NOTSEND]&& [demand.userId isEqualToNumber: session.sessionUserId]){
            //Copy to local Demands
            VacationDemandLocal *localDemand = [VacationDemandLocal MR_createInContext:context];
            localDemand.demandStatus = [VacationDemandStatus MR_createInContext:context];
            localDemand.demandType = [VacationDemandType MR_createInContext:context];

            localDemand.id = demand.id;
            localDemand.startDate = demand.startDate;
            localDemand.endDate = demand.endDate;
            localDemand.comment = demand.comment;
            localDemand.demandType = demand.demandType;
            localDemand.demandStatus = demand.demandStatus;
            localDemand.createdOn = demand.createdOn;
            localDemand.userDisplayName = demand.userDisplayName;
            localDemand.userId = demand.userId;
        }
        
        [demand MR_deleteEntity];
    }
    
    //Delete Teammates
    NSArray *teamMates = [Teammate MR_findAll];
    
    for(Teammate *mate in teamMates)
        [mate MR_deleteEntity];
    
    
    [context MR_saveToPersistentStoreAndWait];
}


/** Returns the URL to the application's Documents directory.
@return Returns the URL to the application's Documents directory.
*/
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

/** Asks the delegate to open a resource identified by URL.
 @param application The application object.
 @param url A object representing a URL (Universal Resource Locator). See Apple URL Scheme Reference for Apple-registered schemes for URLs.
 @param sourceApplication The bundle ID of the application that is requesting your application to open the URL (url).
 @param annotation A property-list object supplied by the source application to communicate information to the receiving application.
 @return YES if the delegate successfully handled the request; NO if the attempt to open the URL resource failed.
 */
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if(!url){
        return NO;
    }
    //Reset the data and the sessionon url start
    session = [[WLSession alloc]init];
    [self saveContext];
    [self deleteTemporaryData];
    [[WLTutorial sharedTutorial]abortTutorial];
    
    //now do the handling of the url
    [[WLURLHandler sharedHandler] handleURL:url withNavigationController:(UINavigationController*)self.window.rootViewController];
    return YES;
}

@end
