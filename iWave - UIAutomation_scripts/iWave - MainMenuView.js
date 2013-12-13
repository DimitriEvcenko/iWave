#import "iWave - LogInView.js"

function MainMenuView (){};

// -- checks if user is logged out - if not logs user out

MainMenuView.prototype.checkIfLoggedInLogOut = function() {
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
if (UIATarget.localTarget().frontMostApp().mainWindow().navigationBar().buttons()["Logout"].isVisible()){
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBar().buttons()["Logout"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().textFields()[0].setValue("");
	UIATarget.localTarget().frontMostApp().mainWindow().secureTextFields()[0].setValue("");
	UIATarget.localTarget().frontMostApp().mainWindow().switches()[0].setValue(0);
}else{
	return}
}

// -- checks if user is logged in - if not logs user in

MainMenuView.prototype.checkIfLoggedInLogIn = function() {

if (UIATarget.localTarget().frontMostApp().mainWindow().navigationBar().buttons()["Logout"].isVisible()){
	return
}else{
	
loginView = new LogInView();	
loginView.loginCorrectNoRemembering();
	
	}
}

// -- executes the introduction and checks if all messages are displayed right
	
MainMenuView.prototype.introduction = function() {

var testName = "introduction test"	
UIALogger.logStart( testName );
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
UIATarget.localTarget().delay(1);
	
UIATarget.localTarget().frontMostApp().logElementTree();
if(UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["iWave"].isVisible){
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["Introduction"].buttons()["Introduction"].tap();
UIATarget.localTarget().delay(1);}else{
UIALogger.logFail( testName );}
	
UIATarget.localTarget().delay(1);
	
UIATarget.localTarget().tap({x:300.00, y:300.00});
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["To get to iWave calendar tap here."].isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail( testName ); 
}

UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Now tap on the first vacation day in calendar..."].isVisible()){	
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[19].buttons()[0].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail(testName);}


UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["...and now tap the last one."].isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[23].buttons()[0].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail(testName);} 

	
UIATarget.localTarget().frontMostApp().logElementTree();

if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Just select the vacation type and write a comment..."].isVisible()){

var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];	
	
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Type"].tap();
UIATarget.localTarget().delay(1);	
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
UIATarget.localTarget().delay(1);

UIATarget.localTarget().frontMostApp().logElementTree();	
UIATarget.localTarget().tap({x:100.00, y:300.00});
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].tap();	
UIATarget.localTarget().delay(1);
	
var dayFromValue = UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[1].name();
var dayToValue = UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[2].name();

var date = new Date();
var testComment = "Test entry from the " + date.getDate() + "." + date.getMonth() + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValue + " - " + dayToValue;
	
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].textViews()[0].setValue(testComment);
UIATarget.localTarget().frontMostApp().keyboard().typeString("\n");
}else{
    UIALogger.logFail(testName);} 

UIATarget.localTarget().frontMostApp().logElementTree();
UIATarget.localTarget().delay(1);
	

if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["...and request!"].isVisible()){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Delete"].tap();
		UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();
UIATarget.localTarget().delay(2);
UIALogger.logPass(testName);}else{
UIALogger.logFail(testName);}
	
}

// -- executes the introduction in landscape mode and checks if all messages are displayed right
	
MainMenuView.prototype.introductionLandscape = function() {

UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	return true;
}	
	
var testName = "introduction test 2"	
UIALogger.logStart( testName );
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}	
	
UIATarget.localTarget().frontMostApp().logElementTree();
	
UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
UIATarget.localTarget().delay(1);
	
UIATarget.localTarget().frontMostApp().logElementTree();
if(UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["iWave"].isVisible){
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["Introduction"].buttons()["Introduction"].tap();}else{
UIALogger.logFail( testName);}
	
UIATarget.localTarget().delay(2);
	
UIATarget.localTarget().tap({x:300.00, y:150.00});
	
UIATarget.localTarget().frontMostApp().logElementTree();	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["To get to iWave calendar tap here."].isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail( testName); 
}

UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Now tap on the first vacation day in calendar..."].isVisible()){	
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[22].buttons()[0].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail(testName);}


UIATarget.localTarget().frontMostApp().logElementTree();
	
if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["...and now tap the last one."].isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[26].buttons()[0].tap();
UIATarget.localTarget().delay(1);}else{
    UIALogger.logFail(testName);} 

	
UIATarget.localTarget().frontMostApp().logElementTree();

if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Just select the vacation type and write a comment..."].isVisible()){

var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];	
	
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Type"].tap();
UIATarget.localTarget().delay(1);	
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
UIATarget.localTarget().delay(1);

UIATarget.localTarget().frontMostApp().logElementTree();	
UIATarget.localTarget().tap({x:100.00, y:300.00});
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].tap();	
UIATarget.localTarget().delay(1);
	
var dayFromValue = UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[1].name();
var dayToValue = UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[2].name();

var date = new Date();
var testComment = "Test entry from the " + date.getDate() + "." + date.getMonth() + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValue + " - " + dayToValue;
	
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].textViews()[0].setValue(testComment);
UIATarget.localTarget().frontMostApp().keyboard().typeString("\n");
}else{
    UIALogger.logFail(testName);} 

UIATarget.localTarget().frontMostApp().logElementTree();
UIATarget.localTarget().delay(2);
	

if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["...and request!"].isVisible()){
		UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Request"].tap();
		UIATarget.localTarget().delay(2);}

if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()["Ready! It's really that easy in iWave. \n\nP.S. To do this introduction again, go to information menu."].isVisible()){
	UIATarget.localTarget().delay(2);

	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
		UIALogger.logPass(testName);}else{
		UIALogger.logFail(testName);}
}

// -- taps the news/about/logut buttons in every view
	
MainMenuView.prototype.newsAboutLogOut = function() {

var testName = "news/about/logout test"	
UIALogger.logStart(testName);

mainMenuView = new MainMenuView();
mainMenuView.checkIfLoggedInLogIn();
UIATarget.localTarget().delay(2);
UIATarget.localTarget().tap({x:300.00, y:300.00});
	
if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible() && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()[1].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIATarget.localTarget().delay(2);}else{
	UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].isVisible()){
	mainMenuView = new MainMenuView();
	mainMenuView.checkIfLoggedInLogIn();
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()[1].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIATarget.localTarget().delay(2);}else{
	UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].isVisible()){
	mainMenuView = new MainMenuView();
	mainMenuView.checkIfLoggedInLogIn();
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()[1].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIATarget.localTarget().delay(2);}else{
	UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().mainWindow().buttons()["Login"].isVisible()){
	mainMenuView = new MainMenuView();
	mainMenuView.checkIfLoggedInLogIn();	
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().tabBar().buttons()["Demands"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()[1].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Logout"].tap();
	UIATarget.localTarget().delay(2);
	UIALogger.logPass(testName);}else{
	UIALogger.logFail(testName);}
}	
