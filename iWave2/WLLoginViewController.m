//
//  WLLoginViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 24.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLLoginViewController.h"

#import "WLMappingHelper.h"
#import "VacationDemand.h"
#import "WLUserProfileResponse.h"
#import "WLResponseDescriptor.h"
#import "Teammate.h"
#import "WLTutorial.h"

@interface WLLoginViewController ()


@end

@implementation WLLoginViewController


/**---------------------------------------------------------------------------------------
 * @name Responding to View Events
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some configuration on appearance to see in configureControllerOnAppearance
@param animated True when view appears animated.
 */
-(void)viewWillAppear:(BOOL)animated{
    
    [self configureControllerOnAppearance];
}

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some additional configuration on viewDidLoad to see in configureControllerInitial
  */
- (void)viewDidLoad
{
    [super viewDidLoad];

    [self configureControllerInitial];
}

/**---------------------------------------------------------------------------------------
 * @name Using a Storyboard
 *  ---------------------------------------------------------------------------------------
 */
 /** performing the "showAfterLogin" segue to get to the mainmenu
 */
- (void)performSuccessfulLogin {
    [self performSegueWithIdentifier:@"showAfterLogin" sender:self];
}


/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */

/** This mehtod handles the users login.
 
 On clicking the loginButton several operations are done:
 
 - check for correct user input
 - create the parameter to send to the server
 - restcall
 */
- (IBAction)doLogin:(id)sender {
    
    [self setErrorMessage:nil];
    
    NSLog(@"sending LoginRequest");
      
    [self.view endEditing:TRUE];
    [self moveLoginStuffDown];
    
    //check for correct Input
    if([self.userIdInput.text length]==0 || [self.passwordInput.text length]==0)
    {
        [self setErrorMessage:NSLocalizedString (@"NoUsernameOrPassword", @"Login Errors")];
        return;
    }
       
    //create postparameters
    NSDictionary *postParameters = @{USERNAME : self.loginSettings.userId, PASSWORD : self.loginSettings.password};
    
    //do Login
    [self.restService doLoginWithParameters:postParameters];
}


#pragma mark - Configuration
/**---------------------------------------------------------------------------------------
 * @name Configuration
 *  ---------------------------------------------------------------------------------------
 */
/** This mehtod configures the response descriptor for the application.

The configuration uses RKObjectManager out of RestKit framework and Methods from WLResponseDescriptor.
Response descriptor is required to configure the rest responses.
*/
- (void)configureResponseDescriptor {    
    [[RKObjectManager sharedManager] addResponseDescriptorsFromArray:[WLResponseDescriptor responseDescritorsAsArray]];    
}

/** The controller configuration method on appearance.
	
View appears on first launch an on login. Because of that on appearance there is a reset to the view. 
The restService is initialized and the LoginSettings may be displayed on the view. On first launch autologin is possible.
*/
-(void)configureControllerOnAppearance{
    [self.navigationController setNavigationBarHidden:YES];
    [self.rememberMeSwitch setOn: NO animated:NO];
    
    self.restService = [[WLBaseRest alloc]init];
    self.restService.delegate = self;
    
    if([self.loginSettings.rememberMe boolValue]){
        //Enter Login-Data in View
        [self.userIdInput setText:self.loginSettings.userId];
        [self.passwordInput setText:self.loginSettings.password];
        [self.rememberMeSwitch setOn: [self.loginSettings.rememberMe boolValue] animated:NO];
        
        //do AutoLogin
        if(!self.authenticationSuccessfull){
            [self doLogin: self];
        }
    }

}

/** The initial controller configuration method.
	
On viewDidLoad there are many initial steps configuring the view an the application:
	
- design is set
- managedObjectContext and RKObjectManager are instantiated
- response descriptor is configured
- delegates of controls are set
- loginSettings are read from core date	
*/
-(void)configureControllerInitial{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    //do the Design
    [self adaptStyle];
    
    // set on the managed Context
    self.managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    
    if (![RKObjectManager sharedManager]) {
        [RKObjectManager managerWithBaseURL:[NSURL URLWithString:BASE_URL]];
    }
    
    [self configureResponseDescriptor];
    
    self.userIdInput.delegate = self;
    self.passwordInput.delegate = self;
    
    //Settingshandling mit MagicalRecords
    if(!(self.loginSettings = [LoginSettings MR_findFirst]))
        self.loginSettings = [LoginSettings MR_createInContext:self.managedObjectContext];
}

#pragma mark - WLDesignProtocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */ 
/** This Method handles special designed controls on login view controller
	
On this view style is always the same and independent from CommonSettings.
*/
-(void)adaptStyle{
    
    //Style for Loginpage is always Sidion-Light
    
    UIColor *background = [UIColor whiteColor];
    
    //set Colors
    [self.view setBackgroundColor:background];
    [self.loginView setBackgroundColor:[UIColor clearColor]];
    [self.roundRectangleView setBackgroundColor:[WLColorDesign getThirdBackgroundColor:SIDION_LIGHT]];
    self.errorMsgLabel.textColor = [UIColor redColor];
    [self.loginButton setTitleColor:[WLColorDesign getSecondFontColor:SIDION_LIGHT] forState:UIControlStateNormal];
    
    //set Fonts
    [self.userIdInput setFont:[WLColorDesign getFontNormal:SIDION_LIGHT withSize:16.]];
    [self.passwordInput setFont:[WLColorDesign getFontNormal:SIDION_LIGHT withSize:16.]];
    [self.loginButton.titleLabel setFont:[WLColorDesign getFontBold:SIDION_LIGHT withSize:18.]];
    [self.rememberMeLabel setFont:[WLColorDesign getFontNormal:SIDION_LIGHT withSize:16.]];
    [self.rememberMeLabel setTextColor: [UIColor whiteColor]];
    [self.errorMsgLabel setFont:[WLColorDesign getFontNormal:SIDION_LIGHT withSize:16.]];
}


#pragma mark - screen stuff
/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction
 *  ---------------------------------------------------------------------------------------
 */

/** This mehtod handles the system on changing the rememberMeSwitch.
 
The property rememberMe of the LoginSettings model ist set in this method.
*/
- (IBAction)changeAutoLogin:(id)sender {
    if(self.rememberMeSwitch.on){
        self.loginSettings.rememberMe = @1;
    }
    else{
        self.loginSettings.rememberMe = @0;
    }
}

/** On touchesBegan keyboard is dismissed and loginView moved down when up.

touchesBegan is an ihnherited method from UIResponder:
"Tells the receiver when one or more fingers touch down in a view or window."
@param touches A set of UITouch instances that represent the touches for the starting phase of the event represented by event.
@param event An object representing the event to which the touches belong.
*/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(UIDeviceOrientationIsLandscape(self.interfaceOrientation)){
        [self moveLoginStuffDown];
    }
    [self.view endEditing:YES];
}

/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** Sent to the view controller after the user interface rotates.

didRotateFromInterfaceOrientation is an ihnherited method from UIViewController.
@param fromInterfaceOrientation The old orientation of the user interface. For possible values, see UIInterfaceOrientation.
*/
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    if(self.loginIsUp){
        if(UIInterfaceOrientationIsLandscape(fromInterfaceOrientation))
            [self moveLoginStuffDown];
        else
            [self moveLoginStuffUp];
        }
}

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Called, when keyboard appears in landscape orientation.

This method moves the loginView up to be seen when keyboard is up.
*/
-(void)moveLoginStuffUp{
    if(!self.loginIsUp){
        [UIView animateWithDuration:0.5 animations:^{
            float oldX = self.loginView.center.x;
            float oldY = self.loginView.center.y;
            
            self.loginView.center = CGPointMake(oldX, oldY-70);
            self.loginIsUp = YES;
        }];
    }
}

/** Called, when keyboard disappears in landscape orientation.

This method moves the loginView down to be on default position.
*/
-(void)moveLoginStuffDown{
    if(self.loginIsUp){
        [UIView animateWithDuration:0.5 animations:^{
            float oldX = self.loginView.center.x;
            float oldY = self.loginView.center.y;
            
            self.loginView.center = CGPointMake(oldX, oldY+70);
            self.loginIsUp = NO;
        }];
    }
}

/** Called to show an errormessage.

This method is called to display a red text in the errorMsgLabel.
@param message The message displayed on the view. A null message resets the displayed message.
*/
-(void)setErrorMessage:(NSString *)message{
    
    self.errorMsgLabel.alpha = 0.0;
    self.errorMsgLabel.text=@"";
    
    if(message != nil){
        [self.errorMsgLabel setText:message];
    
        [UIView animateWithDuration:1.0 animations:^{
            self.errorMsgLabel.alpha = 1.0;
        }];
    }
}


#pragma mark - TextFieldDelegate
/**---------------------------------------------------------------------------------------
 * @name Managing Textfield Editing
 *  ---------------------------------------------------------------------------------------
 */
/** Asks the delegate if the text field should process the pressing of the return button.
	
Calls doLogin: on pressing the return button. This mehtod is described in the UITextFieldDelegate Protocol.
@param textField The text field whose return button was pressed.
@return YES if an editing session should be initiated; otherwise, NO to disallow editing.
*/
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doLogin:self];
    return YES;
}

/** Asks the delegate if editing should begin in the specified text field.
	
When user starts to edit a textfield keyboard appears and loginView is moved up, when interface orientation is landscape.
This mehtod is described in the UITextFieldDelegate Protocol.
@param textField The text field for which editing is about to begin.
@return YES if an editing session should be initiated; otherwise, NO to disallow editing.
*/
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if(UIDeviceOrientationIsLandscape(self.interfaceOrientation)){
    [self moveLoginStuffUp];
    }
    return YES;
}

/** Tells the delegate that editing stopped for the specified text field.

When user ends to edit a textfield keyboard disappears and loginView is moved down, when interface orientation is landscape.
This mehtod is described in the UITextFieldDelegate Protocol.
@param textField The text field for which editing ended.
*/
-(void) textFieldDidEndEditing:(UITextField *)textField{
    self.loginSettings.userId = self.userIdInput.text;
    self.loginSettings.password = self.passwordInput.text;
}



#pragma mark - RestCall Delegate
/**---------------------------------------------------------------------------------------
 * @name Managing the Restcalls
 *  ---------------------------------------------------------------------------------------
 */
/** Shows an error message when rest call finished with error.
 @param restService The rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description. call.
 @see WLRestServiceProtocol.
*/
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString *)errorMessage andDescription:(NSString *)description{
    
    if ([description isEqualToString:LOGIN_DESCRIPTION]) {
        //on error in login service abort authentification
        self.authenticationSuccessfull = NO;
        
        //clean Textfields
        self.userIdInput.text = @"";
        self.passwordInput.text = @"";
        
        [self setErrorMessage:errorMessage];

    } else if([description isEqualToString:USER_PROFILE_DESCRIPTION]){
        [self setErrorMessage:errorMessage];
    }
    else{
        //else show error message
        UIAlertView *aView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", @"") message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [aView show];
    }
}

/** Handling finishing different rest calls on starting the application.
 
 Sets the authenticationSuccessfull to true, when login rest call finished successfull.
 Leave login view on finishing the user profile request.
 Do nothing on finishing the user vacation information request.
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 @see WLRestServiceProtocol.
*/
-(void)restService:(id)restService didFinishRestCallWithResponse:(id)response andDescription:(NSString *)description{
    
    if([description isEqualToString:LOGIN_DESCRIPTION]){
        [self setErrorMessage:nil];
    
        self.authenticationSuccessfull = YES;
    }
    else if ([description isEqualToString:USER_PROFILE_DESCRIPTION]){
        User *aUser = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
        
        aUser.loginName = self.loginSettings.userId;
        aUser.loginPassword = self.loginSettings.password;
        
        [self.managedObjectContext MR_saveToPersistentStoreAndWait];
        
    }
    else if ([description isEqualToString:VACATION_INFORMATION_DESCRIPTION]){
        [[WLTutorial sharedTutorial]sayHelloToUserWith:self.interfaceOrientation];
        [self performSuccessfulLogin];
    }

}

@end
