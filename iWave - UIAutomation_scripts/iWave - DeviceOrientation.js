#import "iWave - CalendarEntry.js"

function DeviceOrientation (){};

// -- sets the device orientation to default

DeviceOrientation.prototype.setDefaultOrientation = function() {
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() != UIA_DEVICE_ORIENTATION_PORTRAIT){
UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);}else{
	return;}
}

// -- sets the device orientation to every orientation once

DeviceOrientation.prototype.orientation = function() {

var testName = "orientation test "	
UIALogger.logStart(testName);
UIATarget.localTarget().frontMostApp().logElementTree();	
UIATarget.localTarget().delay(2);
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);
	UIALogger.logPass(testName);
	}else{
    UIALogger.logFail(testName);}	
}	

// -- sets the device orientation to every orientation once with opening the about-view

DeviceOrientation.prototype.aboutOrientation = function() {
	
var testName = "main-menu-view orientation test"	
UIALogger.logStart(testName);
UIATarget.localTarget().frontMostApp().logElementTree();	
UIATarget.localTarget().delay(2);
	
UIATarget.localTarget().frontMostApp().navigationBar().buttons()["About"].tap();
UIATarget.localTarget().delay(2);	

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:315.00, y:565.00});
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);}	
}

// -- sets the device orientation to every orientation once within the Profile & Settings View

DeviceOrientation.prototype.profileAndSettingsOrientation = function() {

var testName = "profile & settings orientation test"	
UIALogger.logStart(testName);
UIATarget.localTarget().frontMostApp().logElementTree();	

UIATarget.localTarget().delay(2);	
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
   ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
UIATarget.localTarget().frontMostApp().toolbar().buttons()["Show Categories"].tap();
UIATarget.localTarget().delay(1);
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()["Profile"].tap();
UIATarget.localTarget().delay(1);
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
   ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
UIATarget.localTarget().frontMostApp().toolbar().buttons()["Show Categories"].tap();
UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[2].tap();
UIATarget.localTarget().delay(1);
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
   ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Login"].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()["Profile"].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);}				
}

// -- sets the device orientation to every orientation once within calendar view and scrolls through the calendar 

DeviceOrientation.prototype.calendarOrientationGoThroughCalendar = function() {

var testName = "calendar view orientation test"	
UIALogger.logStart(testName);
UIATarget.localTarget().frontMostApp().logElementTree();	
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
	UIATarget.localTarget().delay(1);
	
	
	if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	

	if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);
	calendarEntry = new CalendarEntry();
	calendarEntry.goThroughCalendar();
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
	UIATarget.localTarget().delay(2);}else{
	UIALogger.logFail(testName);}	
	
	if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT){
	calendarEntry = new CalendarEntry();
	calendarEntry.goThroughCalendar();	
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);}	
}

// -- sets the device orientation to every orientation once within demands view

DeviceOrientation.prototype.demandsOrientation = function() {

var testName = "demands view orientation test "	
UIALogger.logStart(testName);
UIATarget.localTarget().frontMostApp().logElementTree();	
	
UIATarget.localTarget().delay(2);	
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
UIATarget.localTarget().frontMostApp().mainWindow().tabBar().buttons()["Demands"].tap();	
	
deviceOrientation = new DeviceOrientation();
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}

if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_PORTRAIT_UPSIDEDOWN
   ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPELEFT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPELEFT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].isVisible() ){
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT);
	UIATarget.localTarget().delay(2);}else{
    UIALogger.logFail(testName);}	
	
if(UIATarget.localTarget().frontMostApp().interfaceOrientation() == UIA_DEVICE_ORIENTATION_LANDSCAPERIGHT && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].isVisible() &&
   	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].isVisible() ){
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().setDeviceOrientation(UIA_DEVICE_ORIENTATION_PORTRAIT);
	UIATarget.localTarget().delay(2);
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);}				
}


// -- swipes out the popover in demands and profile & settings view
	
DeviceOrientation.prototype.profileSettingsPopoverSwipeOut = function() {

var testName = "popover swipe test"	
UIALogger.logStart(testName);

UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].tap();	
UIATarget.localTarget().delay(1);	
	
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.0}, endOffset:{x:0.8, y:0.10}, duration:0.1})
	
UIATarget.localTarget().delay(1);	
	
if(UIATarget.localTarget().frontMostApp().mainWindow().popover().isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[0].dragInsideWithOptions({startOffset:{x:0.8, y:0.0}, endOffset:{x:0.0, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(1);
}else{
   UIALogger.logFail(testName);}
   

if(!UIATarget.localTarget().frontMostApp().mainWindow().popover().isVisible()){
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	
UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
UIATarget.localTarget().delay(1);
	
UIATarget.localTarget().frontMostApp().tabBar().buttons()["Demands"].tap();
UIATarget.localTarget().delay(1);	

UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.0}, endOffset:{x:0.8, y:0.10}, duration:0.1});
UIATarget.localTarget().delay(1);	
}else{
   UIALogger.logFail(testName);}   
	
if(UIATarget.localTarget().frontMostApp().mainWindow().popover().isVisible()){
UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[0].cells()[0].dragInsideWithOptions({startOffset:{x:0.8, y:0.0}, endOffset:{x:0.0, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(1);
}else{
   UIALogger.logFail(testName);}


if(!UIATarget.localTarget().frontMostApp().mainWindow().popover().isVisible()){
	UIATarget.localTarget().frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);}		
}
