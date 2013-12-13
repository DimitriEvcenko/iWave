#import "iWave - LogInView.js"
#import "iWave - MainMenuView.js"
#import "iWave - ProfileAndSettings.js"
#import "iWave - CalendarEntry.js"
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
	 
});

// -- performs a profile & settings test, goes through the different views in "Profile & Settings" and checks whether everything is being displayed correctly or not

test("profile & settings test 1", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
profileAndSettings = new ProfileAndSettings();
profileAndSettings.enterProfileAndSettingsView();

mainMenuView.checkIfLoggedInLogOut();
});

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

// -- performs a calendar entry test with the given values and deletes it at the end

test("calendar entry test followed by deleting the entry at the end", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createRandomCalendarEntry(0, 26, 30);
	 
});

// -- creates a calendar entry test with the given values and deletes it immediately

test("calendar entry test followed by deleting the entry immediately", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.saveAndDeleteRandomCalendarEntry(0, 26, 30);
	 
});

// -- creates a new calendar entry on a weekend day with causing an error in the calendar view

test("calendar entry test with an error in the calendar view 1", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createCalendarEntryWeekendError(3, 4);
	 
});

// -- creates a new calendar entry on a already existing vacation entry with causing an error in the calendar view

test("calendar entry test with an error in the calendar view 2", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createCalendarEntryVacationError(0, 1);
	 
});

// -- creates a new calendar entry with missing details and causes an error in the calendar view

test("calendar entry test with an error in the calendar view 3", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createCalendarEntryMissingDetailsErrorCalendarView(19, 23);
	 
});

// -- creates a new calendar entry with missing details and causes an error in the calendar view

test("calendar entry test with an error in the demands view", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createCalendarEntryMissingDetailsErrorDemandsView(19, 23);

});

// -- creates a random calendar entry within the demands view, saves and deletes it

test("creates a random calendar entry within the demands view, saves and deletes it", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createRandomCalendarEntryWithinDemands();
	 
});

// -- scrolls trough the calendar by using the navigation buttons and swipe gestures

test("scrolls trough the calendar by using the navigation buttons and swipe gestures", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
UIATarget.localTarget().delay(1);
calendarEntry.goThroughCalendar();

UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
loginView = new LogInView();					  	

loginView.setLoginToDefault();
	 
});
// -- creates a random calendar entry within the demands view, saves and deletes it

test("creates a random calendar entry within the demands view, saves and deletes it", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.createRandomCalendarEntryWithinDemands();
	 
});

// -- scrolls trough the calendar by using the navigation buttons and swipe gestures

test("scrolls trough the calendar by using the navigation buttons and swipe gestures", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
UIATarget.localTarget().delay(1);
calendarEntry.goThroughCalendar();

UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
loginView = new LogInView();					  	

loginView.setLoginToDefault();
	 
});

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
	 
mainMenuView = new MainMenuView();	 
mainMenuView.checkIfLoggedInLogOut();
	 
loginView = new LogInView();
loginView.setLoginToDefault();	 	 
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

