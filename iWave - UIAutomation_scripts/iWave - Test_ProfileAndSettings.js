
#import "iWave - MainMenuView.js"
#import "iWave - ProfileAndSettings.js"
#import "/Users/dimitrievcenko/.jenkins/jobs/iWave/workspace/Pods/tuneup_js/tuneup.js"


// -- performs a profile & settings test, goes through the different views in "Profile & Settings" and checks whether everything is being displayed correctly or not

test("profile & settings test 1", function(target, app) {

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
	 
profileAndSettings = new ProfileAndSettings();
profileAndSettings.enterProfileAndSettingsView();

mainMenuView.checkIfLoggedInLogOut();
});

