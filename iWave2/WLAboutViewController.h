//
//  WLAboutViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLAboutIWave.h"


/** The table view controller to display the appllications information.
*/
@interface WLAboutViewController : UITableViewController <WLDesignGuide>

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** The model to be displayed on the WLAboutViewController.
@see WLAboutIWave
*/
@property (strong, nonatomic) WLAboutIWave *about;

/**--------------------------------------------------------------------
*@name Handle the UI-Controls.
*----------------------------------------------------------------------
*/
/** To display models image.
@see WLAboutIWave
*/
@property (weak, nonatomic) IBOutlet UIImageView *aboutImage;

/** To display models name.
@see WLAboutIWave
*/
@property (weak, nonatomic) IBOutlet UILabel *aboutName;

/** To display models version information.
@see WLAboutIWave
*/
@property (weak, nonatomic) IBOutlet UILabel *aboutVersion;

/** To display models copyright information.
@see WLAboutIWave
*/
@property (weak, nonatomic) IBOutlet UILabel *aboutCopyright;

/** To display models description..
@see WLAboutIWave
*/
@property (weak, nonatomic) IBOutlet UILabel *aboutDescription;


/**---------------------------------------------------------------------------------------
 * @name Doing the Tutorial
 *  ---------------------------------------------------------------------------------------
 */
/** The button to start the tutorial with. */
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;

/** This mehtod restarts the tutorial on mainmenu.
 @param sender The tutorial button.
 */
- (IBAction)doTutorial:(id)sender;


@end
