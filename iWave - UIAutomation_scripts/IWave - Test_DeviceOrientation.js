#import "iWave - DeviceOrientation.js"
#import "iWave - MainMenuView.js"
#import "iWave - LogInView.js"
#import "/Users/dimitrievcenko/.jenkins/jobs/iWave/workspace/Pods/tuneup_js/tuneup.js"

// -- performs an orientation test within the log-in view

test("orientation test within the log-in view", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
deviceOrientation.orientation();
	 
loginView = new LogInView();	 
loginView.loginCorrectNoRemembering();

});

// -- performs an orientation test within the main-menu view

test("orientation test within the main-menu view", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
deviceOrientation.orientation(); 

});

// -- performs an orientation test within the main-menu-view with about view open

test("orientation test within the main-menu view with about view open", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
 	 
deviceOrientation.aboutOrientation();	 
	 	 
})
 
// -- performs an orientation test within the profile & settings view

test("orientation test within the profile & settings view", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
 	 
deviceOrientation.profileAndSettingsOrientation();	 
deviceOrientation.setDefaultOrientation();
	 	 
});

 
// -- performs an orientation test within the calendar view and goes through the calendar

test("orientation test within the calendar view with scrolling through the calendar", function(target, app) {

deviceOrientation = new DeviceOrientation();
 	 
deviceOrientation.calendarOrientationGoThroughCalendar();	 
	 	 
});

// -- performs an orientation test within the demands view

test("orientation test within the demands view", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
 	 
deviceOrientation.demandsOrientation();	 
	 	 
});

// -- performs a popover swipe test in the demands and the profile & settigns view

test("popover swipe test", function(target, app) {

deviceOrientation = new DeviceOrientation();
deviceOrientation.setDefaultOrientation();
 	 
deviceOrientation.profileSettingsPopoverSwipeOut();	 
	 
mainMenuView = new MainMenuView();	 
mainMenuView.checkIfLoggedInLogOut();
	 
loginView = new LogInView();
loginView.setLoginToDefault();	 	 
});