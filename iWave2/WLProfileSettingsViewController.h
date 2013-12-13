//
//  WLProfileSettingsViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 10.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

/** The profile setting view controller only shows the users profile data. */
@interface WLProfileSettingsViewController : UITableViewController <WLDesignGuide>

/**--------------------------------------------------------
 *@name Showing User Data
 *---------------------------------------------------------
 */
/** The user object to display. */
@property User *user;

@end
