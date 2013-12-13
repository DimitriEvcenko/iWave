//
//  WLURLHandler.h
//  iWave2
//
//  Created by Alexander Eiselt on 21.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRest.h"
#import "VacationDemand.h"
#import "WLAppDelegate.h"
#import "WLRestCallCompletedProtocol.h"
#import "WLLoginViewController.h"
#import "WLMainCollectionViewController.h"
#import "WLVacationNavigationViewController.h"
#import "WLVacationDetailViewController.h"
#import "WLVacationDetailEditViewController.h"

/** This class handles starting the app by url.
 The class is created as singleton an no login is done in the url-start case.
 */
@interface WLURLHandler : NSObject <WLRestServiceProtocol>

/**-----------------------------------------------------------
 *@name Starting by URL
 *------------------------------------------------------------
 */
/** The url that is handled by the class. */
@property(strong, nonatomic) NSURL *url;

/** This vacation demand property is used to display a demand on specified url-start. */
@property (strong, nonatomic)VacationDemand *myDemand;

/** The navigation controller to navigate through the view controller. */
@property (strong, nonatomic)UINavigationController *navController;

/** Get user information from server wihtout doing login. */
@property (strong, nonatomic)WLBaseRest *restService;


/** Doing all that is needed on starting from url, like rest calls or naviagte user to the correct view.
 @param url The url the application is started with.
 @param navigationController The navigation controller where user should be navigatet through the app.
 */
-(void)handleURL:(NSURL*)url withNavigationController:(UINavigationController*)navigationController;

/**------------------------------------------------------------------------
 * @name Configure the Shared URLHandler Instance
 *-------------------------------------------------------------------------
 */
/** Return the shared instance of the url handler object
 @return The shared url handler instance*/
+(WLURLHandler*)sharedHandler;
@end
