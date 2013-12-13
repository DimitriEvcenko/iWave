
function ProfileAndSettings (){};

// -- goes through the different views in "Profile & Settings" and checks whether everything is being displayed correctly or not

ProfileAndSettings.prototype.enterProfileAndSettingsView = function() {
	
	var testName = "profile & settings test 1"	
	
	UIALogger.logStart(testName);
	
	UIATarget.localTarget().frontMostApp().logElementTree();
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[0].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[3].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].value() != 0){
		
		var autoLoginValue = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].tap();}else{
    	UIALogger.logFail(testName);} 
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value() != autoLoginValue){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[4].cells()["Sidion-Light"].tap();
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Done"].tap();
		UIATarget.localTarget().delay(1);
	
		UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].name() == "Design, Sidion-Light"){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[4].cells()["Sidion-Dark"].tap();
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Done"].tap();
		UIATarget.localTarget().delay(1);
	
		UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].name() == "Design, Sidion-Dark"){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[4].cells()["Sidion-Blue"].tap();
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Done"].tap();
		UIATarget.localTarget().delay(1);
	
		UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].name() == "Design, Sidion-Blue"){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[4].cells()["Sidion-Sand"].tap();
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Cancel"].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].name() == "Design, Sidion-Blue"){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[4].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[4].cells()["Sidion-Sand"].tap();
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Done"].tap();
		UIATarget.localTarget().delay(1);
	
		UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	
	UIATarget.localTarget().frontMostApp().toolbar().buttons()["Show Categories"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["Profile"].tap();
	UIATarget.localTarget().delay(1);
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[0].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[1].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[2].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[3].value() != 0 &&
	   UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[4].value() != 0){
		
		UIATarget.localTarget().frontMostApp().toolbar().buttons()["Show Categories"].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[2].tap();
		UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);} 
	
	UIATarget.localTarget().frontMostApp().toolbar().buttons()["Show Categories"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["Login"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible()){
		UIALogger.logPass(testName);}else{
    	UIALogger.logFail(testName);} 
	
}

