#import "iWave - LogInView.js"
#import "iWave - MainMenuView.js"
#import "iWave - DeviceOrientation.js"
#import "/Users/dimitrievcenko/.jenkins/jobs/iWave/workspace/Pods/tuneup_js/tuneup.js"

// -- performs a log-in-test without entering any values

test("log-in-test without entering any values", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();
	   
logInView = new LogInView();

logInView.loginNoValues();					  	

logInView.setLoginToDefault();
});

// -- performs a log-in-test with invalid values and without remembering data

test("log-in-test with invalid values and without remembering data", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();
	   
logInView = new LogInView();

logInView.loginFalseNoRemembering();					  	

logInView.setLoginToDefault();
});

// -- performs a log-in-test with invalid values and with remembering data

test("log-in-test with invalid values and with remembering data", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();
	  
logInView = new LogInView();
	 
logInView.loginFalseRemembering();
	 
logInView.setLoginToDefault();
	 
});

// -- performs a log-in-test with valid values and without remembering data

test("log-in-test with valid values and without remembering data", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();	 
 
logInView = new LogInView();

logInView.loginCorrectNoRemembering();	  
UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
logInView.setLoginToDefault();
	 
});

// -- performs a log-in-test with valid values and without remembering data in both landscapemodes, confirmes login by pressing the return button on the keyboard 

test("log-in-test with valid values and without remembering data in both landscapemodes, confirmes login by pressing the return button on the keyboard", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();	 
	 
logInView = new LogInView();

logInView.loginCorrectNoRememberingLandscape();

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();	
	 
logInView.setLoginToDefault();
	 
deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();	 
	 
});

// -- performs a log-in-test with valid values and with remembering data

test("log-in-test with valid values and with remembering data", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogOut();	 
 
logInView = new LogInView();

logInView.loginCorrectRemembering();	 
logInView.setLoginToDefault();

UIATarget.localTarget().deactivateAppForDuration(2); 
});
