//
//  WLSettingsDetailController.m
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSettingsDetailController.h"

#import "CommonSettings.h"
#import "LoginSettings.h"
#import "User.h"
#import "WLLoginSettingsViewController.h"

@interface WLSettingsDetailController ()

/**---------------------------------------------------------------------------------------
 * @name Showing and Hiding the Master View
 *  ---------------------------------------------------------------------------------------
 */
/** The master popover view controller. */
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

/**---------------------------------------------------------------------------------------
 * @name Managing the different Views
 *  ---------------------------------------------------------------------------------------
 */
/** The common settings that are displayed in settings view controller.
  @see WLProfileSettingsViewController */
@property CommonSettings *commonSettings;

/** The login settings shown in login settings view controller.
 @see WLLoginSettingsViewController */
@property LoginSettings *loginSettings;

/** The user Profile containing the teammates information that are deisplayed in team view controller.
 @see WLTeamViewController */
@property User *userProfile;

@end

@implementation WLSettingsDetailController

#pragma mark - Managing the detail item
/**---------------------------------------------------------------------------------------
 * @name Managing the different Views
 *  ---------------------------------------------------------------------------------------
 */
/** The setter of the detail item. Selected view is shown in container.
 @param newDetailItem The new value of the detail item.*/
- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

/** Selecting which view to show. */
- (void)configureView
{
    if (self.detailItem) {
        
        switch ([self.detailItem intValue]) {
            case LOGIN_SETTINGS:
                [self showLoginSettings];
                break;
            case PROFILE_SETTINGS:
                [self showProfileSettings];
                break;
            case TEAM_SETTINGS:
                [self showTeamSettings];
                break;
            default:
                break;
        }
    }
    else{
        [self showLoginSettings];
    }
}

/** Showing the lofin settings view in container. */
-(void)showLoginSettings{
    [self.container bringSubviewToFront:self.loginSettingsView.view];    
}

/** Showing the profile settings view in container. */
-(void)showProfileSettings{    
    [self.container bringSubviewToFront:self.profileSettingsView.view];
}

/** Showing the team view in container. */
-(void)showTeamSettings{
    [self.container bringSubviewToFront:self.teamSettingsView.view];
}

/**---------------------------------------------------------------------------------------
 * @name Configure the View
 *  ---------------------------------------------------------------------------------------
 */
/** This method adds the required view controllers to the container. */
-(void)configureSubViews{
    self.loginSettingsView = [[self storyboard]instantiateViewControllerWithIdentifier:@"LoginSettingsView"];
    self.profileSettingsView = [[self storyboard] instantiateViewControllerWithIdentifier:@"ProfileSettingsView"];
    self.teamSettingsView =[[self storyboard] instantiateViewControllerWithIdentifier:@"TeamView"];
    
    [self.container addSubview:self.loginSettingsView.view];
    [self.container addSubview:self.profileSettingsView.view];
    [self.container addSubview:self.teamSettingsView.view];
    //self.currentView = self.loginSettingsView;
    
    [self sizeSubviews];
}

/** This method changes the size of views added to container to match to its size. 
 @see configureSubViews
 */
-(void)sizeSubviews{
    
    CGFloat width = self.container.frame.size.width;
    CGFloat height = self.container.frame.size.height;
    
    self.profileSettingsView.view.frame = CGRectMake(0, 0, width, height);
    self.loginSettingsView.view.frame = CGRectMake(0, 0, width, height);
    self.teamSettingsView.view.frame = CGRectMake(0, 0, width, height);
    
    self.profileSettingsView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.loginSettingsView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.teamSettingsView.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some additional configuration on viewDidLoad.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSubViews];    
    [self configureView];
    
    self.splitViewController.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDesign) name:DESIGN_NOTIFICATION object:nil];
}

#pragma mark - Split view
/**---------------------------------------------------------------------------------------
 * @name Showing and Hiding the Master View
 *  ---------------------------------------------------------------------------------------
 */
/** On hiding the master view controller the show master button in toolbar is shown in toolbar.
 @param splitController The split view controller that owns the specified controller.
 @param viewController The view controller being hidden (The master).
 @param barButtonItem The button added to the toolbar.
 @param popoverController The popover controller that uses taps in barButtonItem to display the specified view controller.
 */
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{    
    barButtonItem.title = NSLocalizedString(@"ShowSettings", @"Open Settings");
    [self setButton:barButtonItem visible:YES];
    self.masterPopoverController = popoverController;
}

/** On showing the master view controller the show master button in toolbar is removed from toolbar.
 @param splitController The split view controller that owns the specified controller.
 @param viewController The view controller being shown (The master).
 @param barButtonItem The button used to display the view controller while it was hidden.
 */
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{ 
    [self setButton:barButtonItem visible:NO];
    self.masterPopoverController = nil;
}

/** Setting or removing a button to/from the toolbar.
 @param barButtonItem The button to set or remove to/from toolbar.
 @param visible If Yes the button is set, otherwise it is removed.
 */
-(void)setButton:(UIBarButtonItem*)barButtonItem visible:(BOOL)visible{
    
    NSMutableArray *items = [[self.toolbar items] mutableCopy];
    
    if(visible)
        [items insertObject: barButtonItem atIndex: 0];
    else
        [items removeObject:barButtonItem];    
    
    [self.toolbar setItems:items animated:YES];    
}

#pragma mark - Design Guide
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** On changes in common design settings this method is called by delegate of profile settings view controller.
 The method delegates the changes down the line.
 @see WLProfileSettingsViewController*/
-(void)didChangeDesign{
    [self configureSubViews];
    [self configureView];
    [self adaptStyle];
    [self.navigationController popViewControllerAnimated:YES];
}

/** The toolbar style is changed here. */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    [self.toolbar setTintColor:[WLColorDesign getMainBackgroundColor:design]];
}


@end
