//
//  WLSettingsMasterController.h
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSettingsDetailController.h"
#import "WLSettingsModel.h"



/** Users profile and settings are managed by a split view. The settings master controller manages the different possible selections in a table view. Selection any cell of the table view is displayed in detail view controller. 
 @see WLSettingsDetailController
 */
@interface WLSettingsMasterController : UITableViewController <WLDesignGuide>

/**---------------------------------------------------------------------------------------
 * @name Changing the Detail View
 *  ---------------------------------------------------------------------------------------
 */
/** The detail view controler changed by master view controller */
@property (strong, nonatomic) UIViewController *detailViewController;

/** The model containing the description of all optins to select in master view controller. */
@property (strong, nonatomic) WLSettingsModel *settingsModel;


@end
