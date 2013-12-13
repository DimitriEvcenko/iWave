//
//  WLCalendarVC.m
//  iWave2
//
//  Created by Marco Lorenz on 05.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCalendarVC.h"
#import "WLCaldendarCell.h"
#import "WLCalendarViewLayout.h"
#import "CommonSettings.h"
#import "WLCalendarMonthItem.h"
#import "VacationDemandType.h"
#import "WLAppDelegate.h"
#import "WLCalendarDayItem.h"
#import "WLVacationDetailViewController.h"
#import "Teammate.h"
#import "WLVacationRest.h"
#import "WLTutorial.h"
#import "WLCalendarOperations.h"
#import "WLVacationDemandResponse.h"

#define APP_WINDOW  (((WLAppDelegate *)[[UIApplication sharedApplication] delegate]).window)

@interface WLCalendarVC ()

/**------------------------------------------------------------------------
* @name Managing Calendar Properties
*--------------------------------------------------------------------------
*/
/** The used calendar in the view.*/
@property NSCalendar *calendar;

/** The displayed month item.
@see WLCalendarMonthItem
*/
@property WLCalendarMonthItem *monthItem;

/** The selected date in the collectionView */
@property NSDate *selectedDate;

/** The current date to initialize the calendar view */
@property NSDate *date;

/**-------------------------------------------------------------------------------------
* @name Animate the Calendar View
*---------------------------------------------------------------------------------------
*/
/** The current point defines the center of the collectioView during pan gesture. */
@property CGPoint currentPoint;

/** Thor origin point defines the center of the collectionView in its origin position. */
@property CGPoint originPoint;

/**-------------------------------------------------------------------------------------
* @name Demand for Vacation
*---------------------------------------------------------------------------------------
*/
/** This is a vacation demand that can be displayed on the calendar view or sent to wave intranet.
@see VacationDemand */
@property VacationDemand *vacationDemand;

/** The rest service to handle vacation demands.
 @see WLVacationRest */
@property (nonatomic, strong) WLVacationRest *restService;


@end

@implementation WLCalendarVC

#pragma mark - Responding to View Events
/**-------------------------------------------------------------------------------------
* @name Responding to View Events
*---------------------------------------------------------------------------------------
*/
/** Origin point is set to collectionViews center.
@param animated If YES, the view was added to the window using an animation.
*/
-(void)viewDidAppear:(BOOL)animated{
    self.originPoint = self.collectionView.center;
}

/** Doing some configuration before showing the calendar view.
@param animated If YES, the view is being added to the window using an animation.
*/
-(void)viewWillAppear:(BOOL)animated{
    [self configureCalendar];
    [self.collectionView reloadData];
}

/** Stop Tutorial if view disappears.
 @param animated If YES, the view is being removed from the window using an animation.
 */
-(void)viewWillDisappear:(BOOL)animated{
    [[WLTutorial sharedTutorial]endTutorial];
}

#pragma mark - Managing the View
/**-------------------------------------------------------------------------------------
* @name Managing the View
*---------------------------------------------------------------------------------------
*/
/** Doing some basic configuration on the controller after loding. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.date = [[NSDate alloc]init];
    
    self.restService = [[WLVacationRest alloc]init];
    self.restService.delegate = self;
    
    [self.calendarImage.superview sendSubviewToBack:self.calendarImage];
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:[WLCaldendarCell class] forCellWithReuseIdentifier:CalendarCellIdentifier];
    [self adaptStyle];
    
    if(!session.hasManager)
        self.errorLabel.text = NSLocalizedString(@"noManagerError", @"");
}

#pragma mark -Configuration
/**---------------------------------------------------------------------------------------
 * @name Configuration
 *  ---------------------------------------------------------------------------------------
 */
 /** Creating the model used to display the calendar initial. */
-(void)configureCalendar{
    
    self.monthItem = [[WLCalendarMonthItem alloc]init];
    
    self.calendar = [NSCalendar currentCalendar];
    [self showMonthItemOnDate:self.date];
}

/** Modelling the calendar month item from the given date.
@param date A date in the month to be created.

 */
-(void)showMonthItemOnDate: (NSDate*)date{
   
    NSDateComponents *comp = [self.calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:date];
    
    [comp setDay:1];
    [comp setHour:12];
    
    NSDate *firstDayOfMonthDate = [self.calendar dateFromComponents:comp];
    
    //days of Month
    NSRange days = [self.calendar rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:firstDayOfMonthDate];
    
    [comp setDay:days.length];
    
    NSDate *lastDayOfMonthDate = [self.calendar dateFromComponents:comp];
    
    [self.monthItem initWithStartDate:firstDayOfMonthDate andEndDate:lastDayOfMonthDate];
    
    [self displayMonthItem];
}

#pragma mark - Show a Month in Calendar
/**---------------------------------------------------------------------------------------
 * @name Show a Month in Calendar
 *  ---------------------------------------------------------------------------------------
 */
 /** Displays the monthItem on the view. */
-(void)displayMonthItem{
    self.dateLabel.text = [NSString stringWithFormat:@"%@ %@",self.monthItem.yearDisplayName,self.monthItem.monthDisplayName];
}

#pragma mark - Designing the View
/**------------------------------------------------------------------------------------
 * @name Designing the View
 *  -----------------------------------------------------------------------------------
 */ 
 /** This Method handles special designed controls on calendar view controller */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    [self.dateLabel setFont:[WLColorDesign getFontBold:design withSize:20.]];
    
    NSDictionary *textAttributes = @{NSFontAttributeName: [WLColorDesign getFontNormal:design withSize:8.]};
    
    [self.tabBarItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.tabBarItem.title = NSLocalizedString(@"Calendar",@"");
    
    [self.collectionView setBackgroundColor:[UIColor clearColor]];
    
    self.errorLabel.textColor = [UIColor redColor];
    
    [self.navigationViewBar setBackgroundColor:[WLColorDesign getExtraDesignColor:design]];
    [self.navigationSegmentControl setTintColor:[WLColorDesign getExtraDesignColor:design]];
    
    //making the segment control accessible
    NSArray *subViews = [self.navigationSegmentControl subviews];
    [[subViews objectAtIndex:0] setAccessibilityLabel:NSLocalizedString(@"NextYearString", @"")];
    [[subViews objectAtIndex:1] setAccessibilityLabel:NSLocalizedString(@"NextMonthString", @"")];
    [[subViews objectAtIndex:3] setAccessibilityLabel:NSLocalizedString(@"PreviousMonthString", @"")];
    [[subViews objectAtIndex:4] setAccessibilityLabel:NSLocalizedString(@"PreviousYearString", @"")];
    [self.navigationSegmentControl setTitle:NSLocalizedString(@"CalendarToday", @"") forSegmentAtIndex:2];

}

#pragma mark - Collection View: Getting Item and Section Metrics
/**-----------------------------------------------------------------------------------
 * @name Collection View: Getting Item and Section Metrics
 *  ----------------------------------------------------------------------------------
 */
 /** Determines the number of sections in the collection view by counting the day items of the monthItem.
 @param collectionView The calendar collectioView requesting this information.
 @return The number of sections in collectionView.
 @see WLCalendarMonthItem
 @see WLCalendarDayItem
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.monthItem.dayItems count];
}

/** Asks the data source for the number of items in the specified section. (required)
@param collectionView The calendar collectioView requesting this information.
@param section An index number identifying a section in collectionView. This index value is 0-based.
@return The number of rows in section. (Always 1)
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

#pragma mark - Collection View: Getting Views for Items
/**-----------------------------------------------------------------------------------
 * @name Collection View: Getting Views for Items
 *  ----------------------------------------------------------------------------------
 */
 /** Asks the data source for the cell that corresponds to the specified item in the collection view. (required)
@param collectionView The calendar collectioView requesting this information.
@param indexPath The index path that specifies the location of the item.
@return A configured calendar cell object.
@see WLCaldendarCell
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{    
    WLCaldendarCell *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:CalendarCellIdentifier forIndexPath:indexPath];
   
    WLCalendarDayItem *dayItem = (WLCalendarDayItem *)[self.monthItem.dayItems objectAtIndex:indexPath.section];
    
    //Bild und Text setzen
    [mainCell redrawCell];
    mainCell.imageView.image = [dayItem getImage];
    mainCell.nameLabel.text = dayItem.displayText;
    mainCell.date = dayItem.date;
    mainCell.backgroundColor = dayItem.vacationColor;
        
    CGPoint point = [collectionView.superview convertPoint:collectionView.frame.origin toView:APP_WINDOW];
    NSString *accessibilityDate;
    if(dayItem.typeOfDay == dayName)
    {
        accessibilityDate = dayItem.displayText;
    }
    else
    {
        accessibilityDate = [WLCalendarOperations getDateInformation:dayItem.date withFormat:NSLocalizedString(@"AccessibiltyDateFormat", @"")];
        if([WLCalendarOperations isVacationDay:dayItem.date])
        {
            accessibilityDate = [NSString stringWithFormat:@"%@ - %@", accessibilityDate, NSLocalizedString(@"is_vacation", @"")];
        }
    }
    [mainCell createAccessibilityLabelWithOrigin:CGPointMake(point.x, point.y)andInteraceOrientation:self.interfaceOrientation andText:accessibilityDate];
    return mainCell;
}


#pragma mark - Responding to View Rotation Events
/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** Sent to the view controller before performing a one-step user interface rotation.

didRotateFromInterfaceOrientation is an ihnherited method from UIViewController.
@param toInterfaceOrientation The new orientation for the user interface. The possible values are described in UIInterfaceOrientation.
@param duration The duration of the pending rotation, measured in seconds.
*/
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.collectionView setHidden:YES];
    [[WLTutorial sharedTutorial] didChangeDeviceOrientationTo:toInterfaceOrientation];
}

/** Sent to the view controller after the user interface rotates.

didRotateFromInterfaceOrientation is an ihnherited method from UIViewController.
@param fromInterfaceOrientation The old orientation of the user interface.
 */
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    
    //[self.collectionView.collectionViewLayout invalidateLayout];
    [self showMonthItemOnDate:((WLCalendarDayItem *)[self.monthItem.dayItems objectAtIndex:15]).date];
    
    self.originPoint = self.collectionView.center;
    
    [self.collectionView reloadData];
    //[self animateNextViewWithDuration:0.0 andDirectionRight:NO];
    [self.collectionView setHidden:NO];
    
}


#pragma mark - Managing the Selected Cells
/**---------------------------------------------------------------------------------------
 * @name Managing the Selected Cells
 *  ---------------------------------------------------------------------------------------
 */
/** Called when a calendar view cell is selected. Handling selectedDate and vacationDemand.
@param collectionView The collection view object that is notifying you of the selection change.
@param indexPath The index path of the cell that was selected.
*/
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WLCalendarDayItem *dayItem = [self.monthItem.dayItems objectAtIndex:indexPath.section];
    
    NSLog(@"Pressed Button for DayItem: %@", dayItem.displayText);
    
    UIAlertView *aView;
    
    
    if(dayItem.typeOfDay == dayName){
        //do nothing
        return;
    }
    if(!session.hasManager){
        //user with no manager can not demand for vacation
        aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NoManagerErrorHeader", @"No manager header") message:NSLocalizedString(@"NoManagerErrorMessage", @"No manager message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aView show];
        return;
    }
    if([WLCalendarOperations isVacationDay:dayItem.date]){
        
        //Edit an existing Demand, when no other cell is selected!        
        if(!self.selectedDate){
            [[WLTutorial sharedTutorial] abortTutorial];
            [self performSegueWithIdentifier:@"showVacationFromCalendarSegue" sender:dayItem];
        }
        else{
           //show Alert, when second selection is already a vacation day.
            aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"VacationOverlappingErrorHeader", @"Vacation overlapping header") message:NSLocalizedString(@"VacationOverlappingError", @"Vacation overlapping message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aView show];
            self.selectedDate = nil;
            [[WLTutorial sharedTutorial]stepBack];
        }
        
    }
    else{
        
        if(!self.selectedDate){
            //create selected Date on first click
            [[WLTutorial sharedTutorial] doNextStep];
            self.selectedDate = dayItem.date;
        }
        else{
            
            [self createVacationDemand];

            if([self.selectedDate compare:dayItem.date]==NSOrderedDescending){
                self.vacationDemand.startDate = dayItem.date;
                self.vacationDemand.endDate = self.selectedDate;
            }
            else{
                self.vacationDemand.startDate = self.selectedDate;
                self.vacationDemand.endDate = dayItem.date;
            }
            self.selectedDate = nil;
            
            if([WLCalendarOperations isValidVacation:self.vacationDemand])
            {
                [self performSegueWithIdentifier:@"showVacationFromCalendarSegue" sender:dayItem];
            }
            else
            {
                [self.vacationDemand MR_deleteEntity];
                aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error header") message:NSLocalizedString(@"InvalideVacationDemand", @"Invalide vacation demand message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [aView show];
                self.selectedDate = nil;
                [[WLTutorial sharedTutorial]stepBack];
            }
        }
        
    }    
}

#pragma mark - Using a Storyboard
/**---------------------------------------------------------------------------------------
 * @name Using a Storyboard
 *  ---------------------------------------------------------------------------------------
 */
 /** Notifies the view controller that a segue is about to be performed.
 Destination view controller is configured.
 @param segue The segue object containing information about the view controllers involved in the segue. 
 @param sender The object that initiated the segue. You might use this parameter to perform different actions based on which control (or other object) initiated the segue.
 @see WLVacationDetailViewController
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"called Segue: %@", segue.identifier);
    
    WLCalendarDayItem *dayItem = (WLCalendarDayItem*)sender;
    VacationDemand *vDemand = [self getVacationDemandForDate: dayItem.date];
    
    ((WLVacationDetailViewController*)segue.destinationViewController).delegate = self;
    [((WLVacationDetailViewController*)segue.destinationViewController) setVacationDemand:vDemand];
    
    //Bestätigter Antrag im popver öffnen
    //Sonstiger Vacation Day im Edit view, lokaler mit save button
    //Ansonsten init for add
    
    if([vDemand.demandStatus.name isEqualToString:VS_APPROVED])
        [((WLVacationDetailViewController*)segue.destinationViewController) initForPopoverView:vDemand];
    else if([WLCalendarOperations isVacationDay:dayItem.date])
        [((WLVacationDetailViewController*)segue.destinationViewController) initForEdit:vDemand];
    else
        [((WLVacationDetailViewController*)segue.destinationViewController) initForAdd:vDemand];
}

#pragma mark - External Changes on Vacation Demand
/**---------------------------------------------------------------------------------------
 * @name External Changes on Vacation Demand
 *  ---------------------------------------------------------------------------------------
 */
/** Changes the vacation demand type.
@param demandType The new demand type for the vacation demand object.
@see VacationDemand
@see VacationDemandType
@see WLVacationDemandProtocol
*/
-(void)didChangeVacationDemandType:(NSString*)demandType{
    
    [self.vacationDemand.demandType setName:demandType];
}

/** Changes the vacation demand start date.
@param startDate The new start date for the vacation demand object.
@see VacationDemand
@see WLVacationDemandProtocol
*/
-(void) didChangeVacationDemandStartDate:(NSDate *)startDate{
    
    self.vacationDemand.startDate = startDate;
}

/** Changes the vacation demand end date.
@param endDate The new end date for the vacation demand object.
@see VacationDemand
@see WLVacationDemandProtocol
*/
-(void)didChangeVacationDemandEndDate:(NSDate *)endDate{
    
    self.vacationDemand.endDate = endDate;
}

/** Reloads the collection views content on closing the popover view.
@param demand The vacation demand edited by external view.
@see WLVacationDetailViewController
@see VacationDemand
@see WLVacationDemandProtocol
*/
-(void)didCloseEditView:(VacationDemand *)demand{
    
    //show changes in VacationDemand
    self.vacationDemand = demand;
    [self.collectionView reloadData];
}


/**-------------------------------------------------------------------------------------
* @name Demand for Vacation
*---------------------------------------------------------------------------------------
*/
/** Creating a new vacation demand object */
-(void)createVacationDemand{
    
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    self.vacationDemand = [VacationDemand MR_createInContext: managedObjectContext];
    self.vacationDemand.demandType = [VacationDemandType MR_createInContext: managedObjectContext];
    self.vacationDemand.demandStatus = [VacationDemandStatus MR_createInContext: managedObjectContext];
    self.vacationDemand.demandStatus.name = VS_NOTSEND;
    self.vacationDemand.userId = session.sessionUserId;
    self.vacationDemand.comment = @"";
    self.vacationDemand.userDisplayName = session.displayName;
    self.vacationDemand.createdOn = [[NSDate alloc]init];
    self.vacationDemand.id = @0;
    
}

/** Save created vacation demands in core data and refresh collection view. Called by delegate. */
-(void)saveVacationDemands{
    NSManagedObjectContext *managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    [managedObjectContext MR_saveToPersistentStoreAndWait];
    [self showMonthItemOnDate:((WLCalendarDayItem *)[self.monthItem.dayItems objectAtIndex:15]).date];
    [self.collectionView reloadData];
}

/** Looking for a vacation demand that contains the parameters date.
@param date A date to look for vacation demand.
@return The vacation demand that contains the date parameter. 
*/
-(VacationDemand*)getVacationDemandForDate:(NSDate*)date{
    
    NSArray *vacationDemandList = [VacationDemand MR_findByAttribute:@"userId" withValue:session.sessionUserId];
    
    for(VacationDemand *demand in vacationDemandList){
        
        if([WLCalendarOperations areSameDayDate:date andDate:demand.startDate]||[WLCalendarOperations areSameDayDate:date andDate:demand.endDate])
            return demand;
        
        if([date compare:demand.startDate] == NSOrderedDescending && [date compare:demand.endDate] == NSOrderedAscending)
            return demand;
        
    }
    return nil;
}

/** Doing the restcall for popover view, because view is closing before restcall has finished.
 
 So user can continue using the application while server client communication is on.
 @param restService The rest service object that should do the rest call.
 @param postParameter The parameter to post in the rest call.
 @param description The rest calls description.
 @param selector The selector that should be executed to do rest call.
 @see WLVacationDemandRequest
 @see WLRestServiceProtocol
 */
-(void)restService:(id)restService doRestCallWithParameters:(NSDictionary *)postParameter andDescription:(NSString *)description andSelector:(SEL)selector{
    
    NSLog(@"Doing %@-Call from Popover", description);
    if([restService respondsToSelector:selector])
        [restService performSelector:selector withObject:postParameter];
}

/** Display errors on restcall in alert view.
 @param restService The rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description.
 @see WLRestServiceProtocol
 */
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString *)errorMessage andDescription:(NSString *)description{
    
    UIAlertView *aView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", @"") message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [aView show];
    
}

/** Do additional things when restcall has finished successfull.
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 @see WLRestServiceProtocol*/
-(void)restService:(id)restService didFinishRestCallWithResponse:(id)response andDescription:(NSString *)description{
    
    if([[response class]isSubclassOfClass:[WLVacationDemandResponse class]]){
        if(((WLVacationDemandResponse*)response).vacationId)
            self.vacationDemand.id = ((WLVacationDemandResponse*)response).vacationId;
    }
    //changing demandstatus to pending
    self.vacationDemand.demandStatus.name = VS_PENDING;
    
    //FetchedController didChangeSection only called, when changed one of the Dates
    self.vacationDemand.startDate =  [[NSDate alloc] initWithTimeInterval:1 sinceDate:self.vacationDemand.startDate];
    
    //save changes
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    
    [self.collectionView reloadData];
}

/**------------------------------------------------------------------------
* @name Navigate through the calendar.
*--------------------------------------------------------------------------
*/
/** This method moves the calendar view horizontal by users pan gesture over the view.
On only little movements the calendar view is animated back to origin on finishing the gesture.
Doing the gesture to a threshold value this method finishes the started animation to the selected direction.
A swipe gesture to the left switches to the next month.
@param sender This is the pan gesture recognizer on the collectionView.
@see UIPanGestureRecognizer
*/
- (IBAction)changeMonth:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.collectionView];
    self.currentPoint = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y);
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        if(self.originPoint.x < self.currentPoint.x)
            [self completeAnimationToRight:YES];
        else
            [self completeAnimationToRight:NO];
        
    }
    else{
        //set new Point for Translation
        sender.view.center = self.currentPoint;
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

/** This mehtod displays another month on collectionView.
 There are 5 different states to use:
 
 - next/previous Year
 - next/ previous Month
 - todays Month
 
 To change the month the old month-view is animated out of the view and the next month-view is animated into the view.
 @param sender The segment control that has changed value.
 */
- (IBAction)monthChanged:(UISegmentedControl *)sender {
    
      
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.monthItem getPreviousYearMonthItem];
            [self animateNextViewWithDuration:0.5 andDirectionRight:YES];
            break;
        case 1:
            [self.monthItem getPreviousMonthItem];
            [self animateNextViewWithDuration:0.2 andDirectionRight:YES];
            break;
        case 2:
            self.date = [[NSDate alloc]init];
            [self configureCalendar];
            [self animateNextViewWithDuration:0 andDirectionRight:YES];
            break;
        case 3:
            [self.monthItem getNextMonthItem];
            [self animateNextViewWithDuration:0.2 andDirectionRight:NO];
            break;
        case 4:
            [self.monthItem getNextYearMonthItem];
            [self animateNextViewWithDuration:0.5 andDirectionRight:NO];
            break;
    }
    [[WLTutorial sharedTutorial]endTutorial];
}

/**-------------------------------------------------------------------------------------
* @name Animate the Calendar View
*---------------------------------------------------------------------------------------
*/
/** Animates the collectionView out of the parents view to hte left or right side and animates it in again from the other side.
@param duration The time from starting the animation until the end.
@param right A bool value to set the direction of the animation. Yes means an animation to the right.
*/
-(void)animateNextViewWithDuration:(CGFloat)duration andDirectionRight: (BOOL)right{
    
    NSLog(@"Animate the next Month-View");
    
    if(right)
        self.currentPoint = CGPointMake(1.5*self.view.frame.size.width,self.originPoint.y);
    else
        self.currentPoint = CGPointMake(-1.5*self.view.frame.size.width,self.originPoint.y);
    
    
    //first Animation to get the Window out
    [UIView animateWithDuration:duration animations:^{
        [self.collectionView setCenter:self.currentPoint];
        
    } completion:^(BOOL finished) {
        
        if(finished){
            if(right)
                self.currentPoint = CGPointMake(-1.5*self.view.frame.size.width,self.originPoint.y);
            else
                self.currentPoint = CGPointMake(1.5*self.view.frame.size.width,self.originPoint.y);
            
            [self.collectionView setCenter:self.currentPoint];
            [UIView animateWithDuration:duration animations:^{
                [self.collectionView setCenter:self.originPoint];
                [self.collectionView reloadData];
                
            } completion:^(BOOL finished) {
                if(finished){
                    [self displayMonthItem];
                }
            }];
        }
    }];
}

/** This methods checks if a thresholdvalue on moving the collectionView is achieved.
If it is the method finishes a started animation like animateNextViewWithDuration:.
Otherwise it removes the collectioView to origin.
	
	The threshold value is achieved, when the collectionView is moved 3/8 of the controllers views width.
	
@param right Yes if the animation should finish to the rigth side.
*/
-(void)completeAnimationToRight: (bool)right{
    
    CGFloat distance = self.originPoint.x - self.currentPoint.x;
    CGFloat thresholdValue = self.originPoint.x*3./4.;
    
    //check the Animationdirection
    if(right)
        distance *= -1;
    
    bool completeAnimation = (distance > thresholdValue);
    
    if(!completeAnimation){
        //reset to StartView
        [UIView animateWithDuration: 0.5 animations:^{
            [self.collectionView setCenter:self.originPoint];
        }];
    }
    else{
        if(right){
            [self.monthItem getPreviousMonthItem];            
            [self animateNextViewWithDuration:0.3 andDirectionRight:YES];
        }
        else{
            [self.monthItem getNextMonthItem];
            [self animateNextViewWithDuration:0.3 andDirectionRight:NO];
        }
    }
    [[WLTutorial sharedTutorial]endTutorial];
}
@end

