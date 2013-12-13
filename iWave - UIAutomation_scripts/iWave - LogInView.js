
function LogInView (){};

// -- performs a log-in without entering any values

LogInView.prototype.loginNoValues = function() {

var testName = "log-in test 1"
UIALogger.logStart(testName);
	
UIATarget.localTarget().frontMostApp().logElementTree();	

UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].tap();
UIATarget.localTarget().frontMostApp().logElementTree();
UIATarget.localTarget().delay(1);
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Please enter username and password."].isVisible()){
		UIALogger.logPass(testName);}else{
    	UIALogger.logFail(testName);} 
	UIATarget.localTarget().delay(1);
}	

// -- performs a log-in with invalid values and without remembering 

LogInView.prototype.loginFalseNoRemembering = function() {

var testName = "log-in test 2"
UIALogger.logStart(testName);
	
var user = "user0";
var pass = "Pass0";
var	switchValue = 0;
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].tap();
UIATarget.localTarget().frontMostApp().logElementTree();
UIATarget.localTarget().delay(1);
	
if(UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].value() == "Userid" &&
   UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].value() == "Password" &&
   UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].value() == switchValue){
		UIALogger.logPass(testName);}else{
    	UIALogger.logFail(testName);} 
UIATarget.localTarget().delay(1);
}	
	
// -- performs a log-in-test with invalid values and with remembering data	

LogInView.prototype.loginFalseRemembering = function() {

var testName = "log-in test 3"
UIALogger.logStart(testName);
	
var user = "user0";
var pass = "Pass0";
var	switchValue = 1;
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].tap();
UIATarget.localTarget().frontMostApp().logElementTree();
UIATarget.localTarget().delay(1);
	
if(UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].value() == "Userid" &&
   UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].value() == "Password" &&
   UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].value() == switchValue){
		UIALogger.logPass(testName);}else{
    	UIALogger.logFail(testName);} 
UIATarget.localTarget().delay(1);
}	
	
	
// -- performs a log-in-test with valid values and without remembering data
	
	
LogInView.prototype.loginCorrectNoRemembering = function() {

var testName = "log-in test 4"
UIALogger.logStart(testName);
	
var user = "user1";
var pass = "Pass1";
var	switchValue = 0;
	
UIATarget.localTarget().frontMostApp().logElementTree();	
UIATarget.localTarget().delay(2);
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].tap();
UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() &&
   UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().staticTexts()["Wavemenu"].isVisible()){	
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);}
	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value() == null){
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIALogger.logPass(testName);}else{
	UIALogger.logFail(testName);}
UIATarget.localTarget().delay(1);
}

// -- performs a log-in-test with valid values and without remembering data in both landscapemodes, confirmes login by pressing the return button on the keyboard 
	
LogInView.prototype.loginCorrectNoRememberingLandscape = function() {

var testName = "log-in test 5"
UIALogger.logStart(testName);
	
var user = "user1";
var pass = "Pass1";
var	switchValue = 0;
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
UIATarget.localTarget().delay(2);
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT){
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].tap();
	UIATarget.localTarget().frontMostApp().keyboard().typeString("\n");	

	
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() &&
   UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().staticTexts()["Wavemenu"].isVisible()){	
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
}else{
    	UIALogger.logFail(testName);}
	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value() == null){
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
}else{
    	UIALogger.logFail(testName);}
UIATarget.localTarget().delay(1);

UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);	
UIATarget.localTarget().delay(2);	
UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
UIATarget.localTarget().delay(2);
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT){
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].tap();
	UIATarget.localTarget().frontMostApp().keyboard().typeString("\n");	
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() &&
   UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().staticTexts()["Wavemenu"].isVisible()){	
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
}else{
    	UIALogger.logFail(testName);}
	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value() == null){
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIALogger.logPass(testName);
}else{
    	UIALogger.logFail(testName);}
UIATarget.localTarget().delay(1);	
		
}	

// -- performs a log-in-test with valid values and with remembering data	
LogInView.prototype.loginCorrectRemembering = function() {

var testName = "log-in test 6"
UIALogger.logStart(testName);
	
var user = "user1";
var pass = "Pass1";
var	switchValue = 1;
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue(user);
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue(pass);
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(switchValue);
UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].tap();
UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() &&
   UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].isVisible() &&
   UIATarget.localTarget().frontMostApp().navigationBar().staticTexts()["Wavemenu"].isVisible()){	
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);}else{
    	UIALogger.logFail(testName);}
	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Autologin"].value() == switchValue){
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIALogger.logPass(testName);}else{
    	UIALogger.logFail(testName);}
UIATarget.localTarget().delay(1);
}	
   
// -- sets log-in-screen to default 

LogInView.prototype.setLoginToDefault = function() {
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(0);
UIATarget.localTarget().delay(1);	
}
