//
//  WLLoginViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 24.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLYesNoSwitch.h"
#import "LoginSettings.h"
#import "WLAppDelegate.h"
#import "WLRestCallCompletedProtocol.h"
#import "WLBaseRest.h"

/** This class handles the Login-UI.
 
 On this View the user can put his logindata to login to the wave-intranet.
 
 There are two controls to get the users logininput (userIdInput, passwordInput).
 To save the logininput in core data the rememberMeSwitch can be used. 
 To confirm the login action, loginButton is used. 
 Errors are shown on the errorMsgLabel.
 */
@interface WLLoginViewController : UIViewController <UITextFieldDelegate, WLDesignGuide, WLRestServiceProtocol>

/**--------------------------------------------------------
*@name Handle the UI-Controls
*---------------------------------------------------------
*/
/** The Login View summarizes all LoginView-Controls
 */
@property (weak, nonatomic) IBOutlet UIView *loginView;

/** The error message label shows error messages on error in login action. Is a subview of loginView
 */
@property (weak, nonatomic) IBOutlet UILabel *errorMsgLabel;

/** The RemermberMeSwitch is a switch to set the users autoremember function. Is a subview of roundRectangleView
*/
@property (weak, nonatomic) IBOutlet UISwitch *rememberMeSwitch;

/** The UserIdInput is a Textfield to enter the loginname. Is a subview of roundRectangleView
*/
@property (weak, nonatomic) IBOutlet UITextField *userIdInput;

/** The PasswordInput is a Textfield to enter the loginpassword. Is a subview of roundRectangleView
*/
@property (weak, nonatomic) IBOutlet UITextField *passwordInput;

/** The Login Button initializes the doLogin: Action. Is a subview of roundRectangleView
*/
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

/** The RoundRectangleView summarizes all user controls in one view. Is a subview of loginView
*/
@property (weak, nonatomic) IBOutlet UIView *roundRectangleView;

/** This label shows the text of the autorememberfunction. Is a subview of roundRectangleView
*/
@property (weak, nonatomic) IBOutlet UILabel *rememberMeLabel;

/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */

/** This object handles the communication with the wave-server. Mehtods are declared in WLBaseRest
*/
@property (strong, nonatomic) WLBaseRest *restService;

/**---------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/** This is the managed object context for the current session. 

Is needed to handle the LoginSettings in the controller.
*/
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** The LoginSettings to handle the behaviour of the loginpage, saved in core data.
 */
@property LoginSettings *loginSettings;

/** A bool value to indicate weather user did a successfull login.

The value is set to prevent the system from doing login again after beeing logged out.
*/
@property bool authenticationSuccessfull;

/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** A bool value to shows if loginView is moved up 

The value is set in landscape mode to move the login view up when keyboard appears.
*/
@property bool loginIsUp;


/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction
 *  ---------------------------------------------------------------------------------------
 */

/** This mehtod handles the system on changing the rememberMeSwitch.
 
The property rememberMe of the LoginSettings model ist set in this method.
@param sender The rememberMeSwitch.
*/
- (IBAction)changeAutoLogin:(id)sender;

/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */

/** This mehtod handles the users login.
 
 On clicking the loginButton several operations are done:
 
 - check for correct user input
 - create the parameter to send to the server
 - restcall
 
 @param sender The loginButton.
 */
- (IBAction)doLogin:(id)sender;

@end
