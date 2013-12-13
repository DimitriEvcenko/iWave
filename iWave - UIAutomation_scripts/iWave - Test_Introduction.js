
#import "iWave - MainMenuView.js"
#import "iWave - DeviceOrientation.js"
#import "/Users/dimitrievcenko/.jenkins/jobs/iWave/workspace/Pods/tuneup_js/tuneup.js"

// -- performs an introduction-test

test("introduction test", function(target, app) { 
	 
mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
mainMenuView.introduction();
	 
});

// -- performs an introduction-test in landscape mode

test("introduction test in landscape mode", function(target, app) { 	 
	 
mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
mainMenuView.introductionLandscape();
	 
deviceOrientation = new DeviceOrientation(); 
	 
});

// -- performs a test where the news/about/logout buttons are being tapped in every view

test("news/about/logout test", function(target, app) { 
	 
mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
mainMenuView.newsAboutLogOut();

logInView = new LogInView;
logInView.setLoginToDefault 
UIATarget.localTarget().deactivateAppForDuration(2); 
});