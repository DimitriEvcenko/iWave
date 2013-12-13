//
//  WLSettingsChoiseController.h
//  iWave2
//
//  Created by Marco Lorenz on 13.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLSettingsModel.h"
#import "CommonSettings.h"

/** The settings choise controller should give the user a range of settings to make a selection.
 The view controller has two modes defined by choise property: 
 
    - design
    - usability
 
 */
@interface WLSettingsChoiseController : UIViewController <UITableViewDelegate, UITableViewDataSource, WLDesignGuide>

/**---------------------------------------------------------------------------------------
 * @name Show and change Common Settings
 *  ---------------------------------------------------------------------------------------
 */
/** The table view the range of different settings is shown. */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** The choise that sets the mode of the view controller. */
@property (nonatomic) int choise;

/** The settings object that could be changed.*/
@property CommonSettings *settings;


/**---------------------------------------------------------------------------------------
 * @name Leaving the View
 *  ---------------------------------------------------------------------------------------
 */
/** On cancel the view is dismissed whitout doing any changes.
 @param sender The button that is pressed to leave the view.
 */
- (IBAction)cancel:(id)sender;

/** Changes in common settings are changed in this method. Changes in design are delegated.
 @param sender The button that is pressed to leave the view.
 */
- (IBAction)saveChanges:(id)sender;
@end
