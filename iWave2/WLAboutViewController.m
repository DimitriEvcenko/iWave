//
//  WLAboutViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLAboutViewController.h"
#import "CommonSettings.h"
#import "FirstLaunch.h"
#import "WLNavigationViewController.h"

@interface WLAboutViewController ()

@end

@implementation WLAboutViewController

/**--------------------------------------------------------------------
*@name Managing the View
*----------------------------------------------------------------------
*/
/** Called after the controller’s view is loaded into memory.
This method is doing the initial configuration of the WLAboutViewController.
*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adaptStyle];
    self.about = [[WLAboutIWave alloc]init];
    [self setTheAboutInfo];
	// Do any additional setup after loading the view.
}

/** Display the model on the view.
*/
-(void)setTheAboutInfo{
    
    [self.aboutImage setImage:self.about.image];
    self.aboutCopyright.text = self.about.copyrigth;
    self.aboutDescription.text = self.about.description;
    self.aboutName.text = self.about.name;
    self.aboutVersion.text = self.about.version;
}

#pragma mark - Design Protocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */ 
/** This Method sets the tableViews background color.
@see WLDesignProtocol
*/
-(void) adaptStyle{
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:[cSettings.design intValue]];
    
    [self.tutorialButton setTitleColor:[WLColorDesign getSecondFontColor:SIDION_LIGHT] forState:UIControlStateNormal];
    [self.tutorialButton.titleLabel setFont:[WLColorDesign getFontNormal:SIDION_LIGHT withSize:18.]];
}

/**---------------------------------------------------------------------------------------
 * @name Doing the Tutorial
 *  ---------------------------------------------------------------------------------------
 */
/** This mehtod restarts the tutorial on mainmenu.
 @param sender The tutorial button.
 */
- (IBAction)doTutorial:(id)sender {
    
    FirstLaunch *fL = [FirstLaunch MR_findFirst];
    fL.isFirstLaunch = [NSNumber numberWithBool: YES];
    
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:TUTORIAL_NOTIFICATION object:self];
    
}
@end
