#import "iWave - LogInView.js"
#import "iWave - MainMenuView.js"
#import "iWave - CalendarEntry.js"
#import "/Users/dimitrievcenko/.jenkins/jobs/iWave/workspace/Pods/tuneup_js/tuneup.js"

// -- performs a calendar entry delete test 

test("deletes all calendar entrys in demands view", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
calendarEntry = new CalendarEntry();
calendarEntry.enterCalendarView();
calendarEntry.deleteAllCalendarEntries();
	 
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
	 
})