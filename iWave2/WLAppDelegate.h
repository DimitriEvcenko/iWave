//
//  WLAppDelegate.h
//  iWave2
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSession.h"
#import "WLURLHandler.h"


WLSession *session;

/** The central class of the application.

The class manages the lifecycle of the application. */
@interface WLAppDelegate : UIResponder <UIApplicationDelegate>

/**---------------------------------------------------------------------
*@name Providing a Window for Storyboarding
*-----------------------------------------------------------------------
*/
/** In the window property iWave is displayed. */
@property (strong, nonatomic) UIWindow *window;

/**---------------------------------------------------------------------
*@name Handling Core Data
*-----------------------------------------------------------------------
*/
/** Saving applications data to persistance store.
*/
- (void)saveContext;

/** Deleting session NSManagedObjects.
*/
-(void)deleteTemporaryData;

/** Returns the URL to the application's Documents directory.
@return Returns the URL to the application's Documents directory.
*/
- (NSURL *)applicationDocumentsDirectory;

@end
