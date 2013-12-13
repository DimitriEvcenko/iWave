//
//  WLSettingsDetailController.h
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

/** Users profile and settings are managed by a split view. The settings detail controller manages the detail views for different selections in master controller. To show different views in detail view a container is used. */
@interface WLSettingsDetailController : UIViewController <UISplitViewControllerDelegate, UITableViewDelegate, WLDesignGuide>

/**---------------------------------------------------------------------------------------
 * @name Managing the different Views
 *  ---------------------------------------------------------------------------------------
 */
/** The container displays the requested view. */
@property (weak, nonatomic) IBOutlet UIView *container;

/** The view to show login settings.
 @see WLLoginSettingsViewController*/
@property (strong,nonatomic) UIViewController *loginSettingsView;

/** The view to show the users profile
 @see WLProfileSettingsViewController*/
@property (strong,nonatomic) UIViewController *profileSettingsView;

/** The view to show the users team. 
 @see WLTeamViewController*/
@property (strong, nonatomic) UIViewController *teamSettingsView;

/** The detail item is set by the master view to change the selected view. */
@property (strong, nonatomic) id detailItem;

/**---------------------------------------------------------------------------------------
 * @name Showing and Hiding the Master View
 *  ---------------------------------------------------------------------------------------
 */
/** In the toolbar a button is set in portrait orientation to show master view.*/
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end
