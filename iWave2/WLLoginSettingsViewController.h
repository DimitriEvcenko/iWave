//
//  WLLoginSettingsViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 10.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLYesNoSwitch.h"
#import "LoginSettings.h"
#import "CommonSettings.h"

/** The login settings view controller shows information about users login data. 
 Only autologin can be changed here. Maybe on extending iWave changes in username and password can be done here.
 The possibility to change the design is implemented but not shown in the table yet.
 */
@interface WLLoginSettingsViewController : UITableViewController <WLDesignGuide>

/**---------------------------------------------------------------------------------------
 * @name Show and Change Settings
 *  ---------------------------------------------------------------------------------------
 */
/** The login settings to show or to change*/
@property LoginSettings *loginSettings;

/** The common settings to show or to change. */
@property CommonSettings *commonSettings;

/** On pressing the remember me change cell the value in login settings is changed.
 @param sender The autoremember cell.
 */
- (IBAction)rememberMeChanged:(id)sender;

@end
