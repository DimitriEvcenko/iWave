//
//  WLNavigationBaseController.m
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLNavigationBaseController.h"
#import "WLNewsViewController.h"
#import "CommonSettings.h"
#import "User.h"
#import "WLAppDelegate.h"
#import "NewsMessages.h"
#import "WLNewsHelper.h"
#import "FirstLaunch.h"
#import "WLTutorial.h"
#import "WLAboutViewController.h"

@interface WLNavigationBaseController ()

@end

@implementation WLNavigationBaseController

/**-------------------------------------------------------------------------------------
 * @name Prepare for Base Navigation
 *---------------------------------------------------------------------------------------
 */
/** The basic navigation buttons are added to the navigation bar. */
-(void)initButtons{
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc]initWithTitle: NSLocalizedString(@"Logout",@"") style:UIBarButtonItemStyleBordered target:self action:@selector(doLogout:)];
    UIBarButtonItem *aboutButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"About",@"") style:UIBarButtonItemStyleBordered target:self action:@selector(showAbout:)];
    NSString *newsString = NSLocalizedString(@"News",@"");
    
    newsString = [NSString stringWithFormat:@"%@ (%i/%i)",newsString,[WLNewsHelper getUreadNews],[WLNewsHelper getAllNews]];
    
    UIBarButtonItem *newsButton = [[UIBarButtonItem alloc]initWithTitle:newsString style:UIBarButtonItemStyleBordered target:self action:@selector(showNews:)];
    
    self.navigationItem.rightBarButtonItems = [[NSArray alloc]initWithObjects:logoutButton, aboutButton, newsButton, nil];
}

/**-------------------------------------------------------------------------------------
 * @name Responding to View Events
 *---------------------------------------------------------------------------------------
 */
/** Dismiss popover when view disappears.
 @param animated If YES, the view is being removed from the window using an animation.
 */
-(void)viewWillDisappear:(BOOL)animated{
    if([self.myPopOver isPopoverVisible]){
        [self.myPopOver dismissPopoverAnimated:YES];
    }
}

/**-------------------------------------------------------------------------------------
 * @name Managing the View
 *---------------------------------------------------------------------------------------
 */
/** Doing some basic configuration on the controller after loding. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initButtons];
    [self adaptStyle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doTutorialFromBeginning) name:TUTORIAL_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(forceLogout) name:NO_TOKEN_NOTIFICATION object:nil];
}


#pragma mark - Nagigation Protocol
/**--------------------------------------------------------
 * @name Save on Logout
 *  --------------------------------------------------------
 */
/** Processing the core data before logout.
 
 Data is saved and tempory data is deleted.
 @see WLAppDelegate
 */
- (void)saveContext {
    
    WLAppDelegate *appDelegate = [[WLAppDelegate alloc]init];
    [appDelegate saveContext];
    [appDelegate deleteTemporaryData];
}

/**--------------------------------------------------------
 * @name Doing Base Navigation
 *  --------------------------------------------------------
 */
/** Doing the logout and moving to login view controller.
 @param sender The logout bar button item.
 */
-(void)doLogout:(id)sender{
    [self saveContext];
    session = [[WLSession alloc] init];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/** Showing the about view controller as popover.
 @param sender The show about bar button item.
 @see WLAboutViewController
 */
-(void)showAbout:(id)sender{
    WLAboutViewController* aboutView = [[self storyboard] instantiateViewControllerWithIdentifier:@"aboutView"];
    
    if([self.myPopOver isPopoverVisible]){
        [self.myPopOver dismissPopoverAnimated:YES];
    }
    
    self.myPopOver = [[UIPopoverController alloc] initWithContentViewController:aboutView];
    self.myPopOver.delegate = self;
    
    [self.myPopOver presentPopoverFromBarButtonItem:(UIBarButtonItem*)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

/** Showing the news view controller as popover.
 @param sender The news messages bar button item.
 @see WLNewsViewController
 */
-(void)showNews:(id)sender{
    
    if(![NewsMessages MR_findFirst])
        return;
    
    WLNewsViewController* newsView = [[self storyboard] instantiateViewControllerWithIdentifier:@"newsView"];
    
    if([self.myPopOver isPopoverVisible]){
        [self.myPopOver dismissPopoverAnimated:YES];
    }
    
    self.myPopOver = [[UIPopoverController alloc] initWithContentViewController:newsView];
    self.myPopOver.delegate = self;
    
    [self.myPopOver presentPopoverFromBarButtonItem:(UIBarButtonItem*)sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}



#pragma mark - Design Protocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designs the navigation bar.
 */
-(void)adaptStyle{
    
    CommonSettings *commonSettings = [CommonSettings MR_findFirst];
    
    int design = [commonSettings.design intValue];
    
    self.view.backgroundColor = [WLColorDesign getMainBackgroundColor: design];
    [self.navigationController.navigationBar setTintColor:[WLColorDesign getNavigationColor:design]];
        
}

/** This Method handles the design of the navigation bars title.
 @param title The title of the navigation bar.
 @param design The selected color design.
 */
-(void)setTitel: (NSString*) title withDesign: (int) design{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame: CGRectMake(1, 1, 1, 100)];
    titleLabel.textColor = [WLColorDesign getNavigationTitleColor:design];
    titleLabel.font = [WLColorDesign getFontNormal:design withSize:20];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    
    [self.navigationItem setTitleView:titleLabel];
}

/**---------------------------------------------------------------------------------------
 * @name Start the Tutorial
 *  ---------------------------------------------------------------------------------------
 */
/** Pops the view controler and starts the tutorial */
-(void)doTutorialFromBeginning{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self.navigationController popViewControllerAnimated:YES];
}

/**---------------------------------------------------------------------------------------
 * @name Handling Session Errors
 *  ---------------------------------------------------------------------------------------
 */
/** Forcing the logout if session has timeout. */
-(void)forceLogout{
    [self doLogout:self];
}


@end
