#import "iWave - LogInView.js"
#import "iWave - MainMenuView.js"

function CalendarEntry (){};

// -- enters the calendar view from the main menu 

CalendarEntry.prototype.enterCalendarView = function() {
	
	UIATarget.localTarget().frontMostApp().logElementTree();
	
	UIATarget.localTarget().delay(2);
	UIATarget.localTarget().tap({x:300.00, y:300.00});
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
}

// -- deletes all calendar entrys in demands view

CalendarEntry.prototype.deleteAllCalendarEntries = function() {
	
	var testName = "calendar delete test 1"	

UIATarget.localTarget().frontMostApp().mainWindow().tabBar().buttons()["Demands"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Vacation Demands"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
	
	while (UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells().length > 0)
	{
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.1}, endOffset:{x:0.5, y:0.1}, duration:0.25});
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].buttons()[0].tap();
	}
	if (UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells().length == null){
	
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap()
	;
	UIATarget.localTarget().delay(1);
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);} 
	}

// -- creates a calendar entry with the given values and deletes it at the end - checks whether the calendar entry was saved and displayed correctly or not

CalendarEntry.prototype.createRandomCalendarEntry = function(x, y, z){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	calendarEntry = new CalendarEntry();
	calendarEntry.createRandomCalendarEntry(1, 26, 30);
	return true;
}	
	var testName = "calendar entry test 1"	
	
	UIALogger.logStart( testName );

	var calendarDateArrayWithouWe = [8, 9, 10, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42];
	
	this.x = x;
	this.y = y;
	this.z = z;
	
	var dayFrom = calendarDateArrayWithouWe[y];
	var dayTo = calendarDateArrayWithouWe[z];
	
	var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
	var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];
		
	UIATarget.localTarget().frontMostApp().logElementTree();
	var dayFromValue = UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].name();
	var dayToValue = UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].name();
	
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next month"].tap();
	UIATarget.localTarget().delay(1);
	
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].isVisible() && UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].value() != null){
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Delete"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap()
	;
	this.createRandomCalendarEntry(x, y, z);
	}
	
	UIATarget.localTarget().delay(1);
	
	if(!UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Cancel"].isVisible())
	{UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].tap();
	UIATarget.localTarget().delay(1);}
	
	var date = new Date();
	var month = new Array("01", "02", "03", "04", "05", "06",
                      "07", "08", "09", "10", "11", "12");	
	var testComment = "Test entry from the " + date.getDate() + "." + month[date.getMonth()] + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValue + " - " + dayToValue; 
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Type"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	UIATarget.localTarget().delay(0.5);
	var dayFromVacation = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name();
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	UIATarget.localTarget().delay(0.5);
	var dayToVacation = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name();
	UIATarget.localTarget().delay(0.5);
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].tap();	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].textViews()[0].setValue(testComment);
	
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Request"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tabBar().buttons()["Demands"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Vacation Demands"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
	
	while (UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells().length > 1)
	{
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.1}, endOffset:{x:0.5, y:0.1}, duration:0.25});
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].buttons()[0].tap();
	}	
	
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	
	UIATarget.localTarget().frontMostApp().logElementTree();
	
	if(
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].name() == "Type, " + vacationType &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name() == dayFromVacation &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name() == dayToVacation ){
	
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbars()[1].buttons()["Edit"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Cancel"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbars()[1].buttons()["Edit"].tap();
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].tap();
	
	var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
	var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];
	
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[2].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[0].tapWithOptions({tapOffset:{x:0.10, y:0.70}}); 
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[1].tapWithOptions({tapOffset:{x:0.50, y:0.70}});
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[2].tapWithOptions({tapOffset:{x:0.90, y:0.70}});
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[1].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[0].tapWithOptions({tapOffset:{x:0.10, y:0.70}}); 
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[1].tapWithOptions({tapOffset:{x:0.50, y:0.70}});
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[2].tapWithOptions({tapOffset:{x:0.90, y:0.70}});
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[1].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[0].tapWithOptions({tapOffset:{x:0.60, y:0.35}}); 
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[1].tapWithOptions({tapOffset:{x:0.50, y:0.35}});
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[2].tapWithOptions({tapOffset:{x:0.40, y:0.35}});
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	var dayFromValuePopover = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[1].name();
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[2].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[0].tapWithOptions({tapOffset:{x:0.60, y:0.35}}); 
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[1].tapWithOptions({tapOffset:{x:0.50, y:0.35}});
	UIATarget.localTarget().frontMostApp().mainWindow().popover().pickers()[0].wheels()[2].tapWithOptions({tapOffset:{x:0.40, y:0.35}});
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	var dayToValuePopover = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()[2].name();
		
	var date = new Date();
	var month = new Array("01", "02", "03", "04", "05", "06",
                      "07", "08", "09", "10", "11", "12");	
	var testComment = "Test entry from the " + date.getDate() + "." + month[date.getMonth()] + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValuePopover + " - " + dayToValuePopover + " (edited)"; 
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Comment"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Comment"].textViews()[0].setValue("");
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].cells()["Comment"].textViews()[0].setValue(testComment);
	UIATarget.localTarget().tap({x:400.00, y:800.00});
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Delete"].tap();	
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap()
	;
	UIATarget.localTarget().delay(1);
	UIALogger.logPass(testName);}else{
    UIALogger.logFail(testName);} 
}

// -- creates a calendar entry and deletes it immediately - checks whether the calendar entry was saved and displayed correctly or not

CalendarEntry.prototype.saveAndDeleteRandomCalendarEntry = function(x, y, z){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	calendarEntry = new CalendarEntry();
	calendarEntry.saveAndDeleteRandomCalendarEntry();
	return true;
}	
	
	var testName = "calendar entry test 2"	
	
	UIALogger.logStart(testName);

	var calendarDateArrayWithouWe = [8, 9, 10, 11, 12, 15, 16, 17, 18, 19, 22, 23, 24, 25, 26, 29, 30, 31, 32, 33, 36, 37, 38, 39, 40];
	
	this.x = x;
	
	var randomDateIndex = [Math.floor(Math.random() * calendarDateArrayWithouWe.length)];
	var dayFrom = calendarDateArrayWithouWe[randomDateIndex];
	var dayTo = calendarDateArrayWithouWe[randomDateIndex];
	
	var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
	var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];

	if (x > 2)	{
	
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next month"].tap();
	UIATarget.localTarget().delay(1);
	this.x = 0;}
		
	UIATarget.localTarget().frontMostApp().logElementTree();
	var dayFromValue = UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].name();
	var dayToValue = UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].name();
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	

	while (UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Status, Approved"].isVisible()|| UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Status, Pending"].isVisible()){
		
	UIATarget.localTarget().frontMostApp().logElementTree();	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Cancel"].tap();
	UIATarget.localTarget().delay(1);
	x++;
	this. saveAndDeleteRandomCalendarEntry();}
		
	
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	
	var date = new Date();
	var month = new Array("01", "02", "03", "04", "05", "06",
                      "07", "08", "09", "10", "11", "12");	
	var testComment = "Test entry from the " + date.getDate() + "." + month[date.getMonth()] + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValue + " - " + dayToValue; 
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Type"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	UIATarget.localTarget().delay(0.5);
	var dayFromVacation = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name();
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	UIATarget.localTarget().delay(0.5);
	var dayToVacation = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name();
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].tap();	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()["Comment"].textViews()[0].setValue(testComment);
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Save"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	
	if(
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].name() == "Type, " + vacationType &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name() == dayFromVacation &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name() == dayToVacation &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[4].name() == "Status, Unrequested"){
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Delete"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap()
	;
	UIATarget.localTarget().delay(1);
	UIALogger.logPass(testName);}
	else{
    UIALogger.logFail(testName);}	
}

// -- creates a random calendar entry within demands view and deletes it afterwards - checks whether the calendar entry was saved and displayed correctly or not

CalendarEntry.prototype.createRandomCalendarEntryWithinDemands = function(){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	calendarEntry = new CalendarEntry();
	calendarEntry.createRandomCalendarEntryWithinDemands();
	return true;
}	
	
	var testName = "calendar entry test 3"	
	
	UIALogger.logStart(testName);
	
	UIATarget.localTarget().frontMostApp().mainWindow().tabBar().buttons()["Demands"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Add"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].tap();
	
	var vacationCellTypeArray = ["Holiday", "Parentalleave", "Seminar", "Flexible Time", "Sabbatical"];
	var vacationType = vacationCellTypeArray[Math.floor(Math.random() * vacationCellTypeArray.length)];
	
	UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[vacationType].tap();
	UIATarget.localTarget().tap({x:100.00, y:300.00});
	UIATarget.localTarget().delay(1);
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()[1].tap();
	
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	UIATarget.localTarget().delay(1);
	var dayFromValuePopover = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()[1].name();
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()[2].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().tap({x:250.00, y:400.00});
	UIATarget.localTarget().delay(1);
	var dayToValuePopover = UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()[2].name();
	
	var date = new Date();
	var month = new Array("01", "02", "03", "04", "05", "06",
                      "07", "08", "09", "10", "11", "12");	
	var testComment = "Test entry from the " + date.getDate() + "." + month[date.getMonth()] + "." + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() +  ". Booked free time: " + dayFromValuePopover + " - " + dayToValuePopover; 
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()["Comment"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()["Comment"].textViews()[0].setValue("");
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].cells()["Comment"].textViews()[0].setValue(testComment);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].toolbar().buttons()["Save"].tap();
	
	UIALogger.logMessage("dayFromValuePopover = " + dayFromValuePopover);
	UIALogger.logMessage("dayToValuePopover = " + dayToValuePopover);
	UIALogger.logMessage("cell(1) = " + UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name());
	UIALogger.logMessage("cell(2) = " + UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name());
	
	if(
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[0].name() == "Type, " + vacationType &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[1].name() == dayFromValuePopover &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[2].name() == dayToValuePopover &&
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].cells()[4].name() == "Status, Unrequested"){
		
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Vacation Demands"].tap();
	UIATarget.localTarget().frontMostApp().logElementTree();
	UIATarget.localTarget().delay(1);
		
	while (UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells().length > 0)
	{
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.1}, endOffset:{x:0.5, y:0.1}, duration:0.25});
		UIATarget.localTarget().frontMostApp().mainWindow().popover().tableViews()["Empty list"].cells()[0].buttons()[0].tap();
	}
	
	UIATarget.localTarget().tap({x:400.00, y:550.00});	
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);	
	UIALogger.logPass(testName);}
	else{
    UIALogger.logFail(testName);}	
		
}

// -- creates a new calendar entry on a weekend day with causing an error in the calendar view

CalendarEntry.prototype.createCalendarEntryWeekendError = function (x, y){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	UIALogger.logPass(testName);	
	return true;
}	
	var testName = "calendar entry test 4"	
	
	UIALogger.logStart(testName);
	
	var calendarDateArrayWithouWe = [7, 13, 14, 20, 21, 27, 28, 34, 35, 41];
	
	this.x = x;
	this.y = y;
	
	var dayFrom = calendarDateArrayWithouWe[x];
	var dayTo = calendarDateArrayWithouWe[y];
	
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
		return;}else{
			UIALogger.logFail(testName);
	}
}

// -- creates a new calendar entry on a already existing vacation entry with causing an error in the calendar view

CalendarEntry.prototype.createCalendarEntryVacationError = function (x, y){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	UIALogger.logPass(testName);
	return true;
}	
	var testName = "calendar entry test 5"	
	
	UIALogger.logStart(testName);
	
	var calendarDateArrayWithouWe = [7, 13, 14, 20, 21, 27, 28, 34, 35, 41];
	
	this.x = x;
	this.y = y;
	
	var dayFrom = calendarDateArrayWithouWe[x];
	var dayTo = calendarDateArrayWithouWe[y];
	
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
		return;}else{
			UIALogger.logFail(testName);
	
}	}

// -- creates a new calendar entry with missing details and causes an error in the calendar view

CalendarEntry.prototype.createCalendarEntryMissingDetailsErrorCalendarView = function (x, y){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();
	UIALogger.logPass(testName);
	return true;
}	
	var testName = "calendar entry test 6"	
	
	UIALogger.logStart(testName);
	
	var calendarDateArrayWithouWe = [8, 9, 10, 11, 12, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42];
	
	this.x = x;
	this.y = y;
	
	var dayFrom = calendarDateArrayWithouWe[x];
	var dayTo = calendarDateArrayWithouWe[y];
	
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayFrom].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[dayTo].buttons()[0].tap();
	UIATarget.localTarget().delay(1);
	
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Save"].tap();
	
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()["Empty list"].toolbar().buttons()["Cancel"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
		return;}else{
			UIALogger.logFail(testName);
	}
}

// -- creates a new calendar entry with missing details and causes an error in the demands view

CalendarEntry.prototype.createCalendarEntryMissingDetailsErrorDemandsView = function (x, y){
	
	UIATarget.onAlert = function onAlert(alert){
	UIATarget.localTarget().frontMostApp().logElementTree();
    UIALogger.logMessage(alert.name());
	UIATarget.localTarget().frontMostApp().alert().defaultButton().tap();	
	UIATarget.localTarget().delay(1);
	UIALogger.logPass(testName);
	return true;
}	
	var testName = "calendar entry test 7"	
	
	UIALogger.logStart(testName);

	UIATarget.localTarget().frontMostApp().mainWindow().tabBar().buttons()["Demands"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[1].toolbar().buttons()["Add"].tap();
	UIATarget.localTarget().delay(1);
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].toolbar().buttons()["Save"].tap();
	UIATarget.localTarget().frontMostApp().mainWindow().tableViews()[2].toolbar().buttons()["Cancel"].tap();
	
	target.frontMostApp().navigationBar().buttons()["Mainmenu"].tap();
	UIATarget.localTarget().delay(1);
	if(UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[0].buttons()["Profile & Settings"].isVisible && UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].cells()[1].buttons()["Caribbean"].isVisible()){
		return;}else{
			UIALogger.logFail(testName);		
	}
	}

// -- scrolls trough the calendar by using the navigation buttons and swipe gestures - checks whether the calendar was displayed correctly or not

CalendarEntry.prototype.goThroughCalendar = function (){
	
	
	var testName = "calendar view test 2"	
	
	UIALogger.logStart(testName);
	
	var date = new Date();
	
	var month = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", "January");	
	
	var currentMonth = month[date.getMonth()];
	var currentYear = date.getFullYear();
	
	
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Previous year"].tap();
	UIATarget.localTarget().delay(3);
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear-1) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Previous year"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear-2) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next year"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear-1) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next year"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Previous month"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-1]){ 
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Previous month"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	 
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-2]){   
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next month"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	 
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-1]){   
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Next month"].tap();
	UIATarget.localTarget().delay(3);}else{
	UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.0}, endOffset:{x:0.8, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);}
	   
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-1]){    
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].dragInsideWithOptions({startOffset:{x:0.0, y:0.0}, endOffset:{x:0.8, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);}
	   
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-2]){ 
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].dragInsideWithOptions({startOffset:{x:0.8, y:0.0}, endOffset:{x:0.0, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);}
	   
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + month[(date.getMonth())-1]){    
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].dragInsideWithOptions({startOffset:{x:0.8, y:0.0}, endOffset:{x:0.0, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);}
	   
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + currentMonth){   
	UIATarget.localTarget().frontMostApp().mainWindow().collectionViews()[0].dragInsideWithOptions({startOffset:{x:0.8, y:0.0}, endOffset:{x:0.0, y:0.10}, duration:0.1});
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);}
	
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + (month[(date.getMonth())+1])){   
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Today"].tap();
	UIATarget.localTarget().delay(3);}
	else if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear +1) + " " + (month[(date.getMonth())+1])){   
	UIATarget.localTarget().frontMostApp().mainWindow().segmentedControls()[0].buttons()["Today"].tap();
	UIATarget.localTarget().delay(3);}else{
	   UIALogger.logFail(testName);
	}
	   
	if(UIATarget.localTarget().frontMostApp().mainWindow().staticTexts()[0].name() == (currentYear) + " " + currentMonth){
	UIATarget.localTarget().frontMostApp().mainWindow().navigationBars()["Caribbean"].buttons()["Mainmenu"].tap()
	UIATarget.localTarget().delay(2);
	UIALogger.logPass(testName);}else{
	UIALogger.logFail(testName);}
}
