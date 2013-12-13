//
//  WLVacationDetailViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationDetailViewController.h"
#import "VacationDemandStatus.h"
#import "VacationDemandType.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonSettings.h"
#import "WLTableCellDesignCell.h"
#import "WLDatePickerViewController.h"
#import "WLMappingHelper.h"
#import "WLVacationDemandRequest.h"
#import "WLAppDelegate.h"
#import "WLBaseResponse.h"
#import "WLVacationListViewController.h"
#import "WLVacationRest.h"
#import "WLVacationDecisionRequest.h"
#import "WLVacationDeleteRequest.h"
#import "WLTutorial.h"
#import "WLCalendarOperations.h"
#import "FirstLaunch.h"
#import "WLTableHeaderLabel.h"
#import "WLVacationDemandResponse.h"
#import "WLVacationDecisionResponse.h"



@interface WLVacationDetailViewController ()

#pragma mark - Managing the Master View Controller in Viewmode View
/**--------------------------------------------------------
 *@name Managing the Master View Controller in Viewmode View
 *---------------------------------------------------------
 */
/** The master popover in the split view. */
@property (strong, nonatomic) UIPopoverController *masterPopoverController;

#pragma mark - Handling Core Data
/**---------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/** This is the managed object context for the current session. */
@property NSManagedObjectContext *managedObjectContext;

#pragma mark - Handle the UI-Controls in View Mode
/**--------------------------------------------------------
 *@name Handle the UI-Controls in View Mode.
 *---------------------------------------------------------
 */
/** An array of all possible button elements in navigateToolbar. */
@property (strong, nonatomic) NSArray *navigationItems;

/** An array of all possible button elements in editToolbar. */
@property (strong, nonatomic) NSArray *editbarItems;

#pragma mark - Communication with the Server
/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */
/** This object handles the communication with the wave-server. Mehtods are declared in WLVacationRest. */
@property (nonatomic, strong) WLVacationRest *restService;

@end

@implementation WLVacationDetailViewController
int design;

#pragma mark - Getter and Setter for the View
/**-------------------------------------------------------------
 * @name Getter and Setter for the View.
 *--------------------------------------------------------------
 */
/** Setting the vacation demand for the view controller
 @param vacationDemand The vacation demand that should set to the views vacation demand.
 */
- (void)setVacationDemand:(VacationDemand *)vacationDemand
{
    if (_vacationDemand != vacationDemand) {
        _vacationDemand = vacationDemand;
        
        [self configureView];
    }
    
    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

/** The date formatters getter to display date in the controller. 
 @return The view controller specific date formatter.
 */
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        _dateFormatter = dateFormat;
    }
    return _dateFormatter;
}

#pragma mark - Managing the View
/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Called after the controller’s view is loaded into memory. Configuring the controller. */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Hidden: %d", self.navigationController.navigationBarHidden);
    
    if (!self.viewMode) {
        self.viewMode = WLVacationDetailViewMode_VIEW;
    }
    
    self.navigationItems = [[NSArray alloc] initWithArray:[self.navigateToolbar items]];
    self.editbarItems = [[NSArray alloc] initWithArray:[self.editToolbar items]];
    
    //prepare View on Start
    if(!self.vacationDemand)
        [self initForView:nil];
    
    [self adaptStyle];
    [self configureView];
    
    self.tableView.delegate = self;
    self.splitViewController.delegate = self;
    self.commentTextField.delegate = self;
    
    self.managedObjectContext = self.vacationDemand.managedObjectContext;
    
    self.restService = [[WLVacationRest alloc]init];
    self.restService.delegate = self;
    
    if(![self.vacationDemand vacationDemandisComplete])
        [self.sendButtonFromEditOrCreate setEnabled:NO];


}

#pragma mark - Responding to View Events

/**---------------------------------------------------------------------------------------
 * @name Responding to View Events
 *  ---------------------------------------------------------------------------------------
 */
/** Notifies the view controller that its view was added to a view hierarchy. The tutorial is dong the next step.
 @param animated If YES, the view was added to the window using an animation.
 */
-(void)viewDidAppear:(BOOL)animated{
    
    [[WLTutorial sharedTutorial]doNextStep];
}


#pragma mark - Configure the View Controller
/**---------------------------------------------------------------------------------------
 * @name Configure the View Controller.
 *  ---------------------------------------------------------------------------------------
 */
/** Tests if a vacation demand for the view controller exists in wave database and is editable or deletable by user.
 @param demand The vacation demand that is tested.
 @return Yes, if the remote vacation demand is editable.
 */
-(BOOL)demandIsRemoteEditable:(VacationDemand*)demand{
    
    if([demand.demandStatus.name isEqualToString:VS_REJECTED]||[demand.demandStatus.name isEqualToString:VS_PENDING])
        return YES;
    
    return NO;
}
/** Tests if a vacation demand for the view controller is editable by user.
 @param demand The vacation demand that is tested.
 @return Yes, if the vacation demand is editable.
 */
-(BOOL)demandIsLocaleEditable:(VacationDemand*)demand{
    
    if([demand.demandStatus.name isEqualToString:VS_NOTSEND])
        return YES;
    
    return NO;
}

/** Tests if a vacation demand for the view controller is approvable by user.
 @param demand The vacation demand that is tested.
 @return Yes, if the vacation demand is approvable.
 */
-(BOOL)demandIsApprovable:(VacationDemand*)demand{
    
    if([demand.demandStatus.name isEqualToString:VS_TEAM])
        return YES;
    if([demand.demandStatus.name isEqualToString:VS_TEAM_INDIRECT])
        return YES;
    
    return NO;
}

/** Setting the toolbars and buttons to use. 
 Some buttons are disabled/enabled or removed from toolbar depending on the view mode. */
- (void)configureView {
    NSLog(@"Selected ViewMode : %i", self.viewMode);
    self.editToolbar.hidden= TRUE;
    self.navigateToolbar.hidden = TRUE;
    
    if(![self demandIsApprovable:self.vacationDemand])
        self.vacationRequestButton.title = NSLocalizedString(@"SendDemand", @"");
    else
        self.vacationRequestButton.title = NSLocalizedString(@"ApproveDemand", @"");
    
    switch (self.viewMode) {
        case WLVacationDetailViewMode_ADD:
            NSLog(@"Add");
            self.editToolbar.hidden= FALSE;
            [self removeDeleteButton];
            break;
        case WLVacationDetailViewMode_EDIT:
            NSLog(@"Edit");
            if(![self.vacationDemand.demandStatus.name isEqualToString:VS_NOTSEND])
                [self removeSaveButton];
            
            if([self.vacationDemand.demandStatus.name isEqualToString:VS_REJECTED])
                [self removeEditButtonFromToolbar];
            
            self.commentTextField.text = self.vacationDemand.comment;
            self.editToolbar.hidden= FALSE;
            break;
        case WLVacationDetailViewMode_VIEW:
            NSLog(@"View");
            //self.commentTextField.text = @"bla";
            self.commentTextField.text = self.vacationDemand.comment;
            self.navigateToolbar.hidden = FALSE;
            break;
        case WLVacationDetailViewMode_POPOVER_VIEW:
            NSLog(@"Popover View");
            [self initForPopoverView:self.vacationDemand];
            self.commentTextField.text = self.vacationDemand.comment;
            self.editToolbar.hidden= FALSE;
            break;
        default:
            NSLog(@"None");
            self.navigateToolbar.hidden = FALSE;
    }
}

/** Removes the delete button from editToolbar. */
-(void)removeEditButtonFromToolbar{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.editToolbar.items];
    
    NSLog(@"Remove Delete Button");
    [items removeObject:self.sendButtonFromEditOrCreate];
    
    self.editToolbar.items = [[NSArray alloc] initWithArray:items];
}

/** Removes the delete button from editToolbar. */
-(void)removeDeleteButton{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.editToolbar.items];
    
    NSLog(@"Remove Delete Button");
    [items removeObject:self.deleteButton];
    
    self.editToolbar.items = [[NSArray alloc] initWithArray:items];
}

/** Removes the save button from editToolbar. */
-(void)removeSaveButton{
    
    NSMutableArray *items = [[NSMutableArray alloc] initWithArray:self.editToolbar.items];
    
    NSLog(@"Remove Save Button");
    [items removeObject:self.saveButton];
    
    self.editToolbar.items = [[NSArray alloc] initWithArray:items];
}

/** Configures the view for viewmode view.
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForView:(VacationDemand *)vacationDemandToView {
    self.viewMode = WLVacationDetailViewMode_VIEW;
    self.vacationDemand = vacationDemandToView;
    
    NSMutableArray *navigationItems = [[NSMutableArray alloc] initWithArray:self.navigationItems];
    
    //enable Editbutton, when Request is editable
    if([self demandIsLocaleEditable:vacationDemandToView]){
        [navigationItems removeObject:self.rejectButton];
        //[navigationItems addObject:self.editButton];
        //self.editButton.enabled = true;
        //self.vacationRequestButton.enabled = true;
    }
    else if ([self demandIsApprovable:vacationDemandToView]){
        [navigationItems removeObject:self.editButton];
    }
    else if ([self demandIsRemoteEditable:vacationDemandToView]){
        [navigationItems removeObject:self.rejectButton];
        [navigationItems removeObject:self.vacationRequestButton];
    }
    else{
        [navigationItems removeObject:self.editButton];
        [navigationItems removeObject:self.vacationRequestButton];
        [navigationItems removeObject:self.rejectButton];
        //self.editButton.enabled = false;
        //self.vacationRequestButton.enabled = true;
    }
    if(!session.hasManager)
        [navigationItems removeObject: self.addButton];
    
    self.navigateToolbar.items = navigationItems;
}

/** Configures the view for popover-viewmode view. 
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForPopoverView:(VacationDemand *)vacationDemandToView{
    self.viewMode = WLVacationDetailViewMode_POPOVER_VIEW;
    self.editbarItems = [[NSArray alloc] initWithArray:[self.editToolbar items]];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] initWithArray:self.editbarItems];
    
    if([toolbarItems count]>0){
        UIBarButtonItem *cancelButton = [toolbarItems objectAtIndex:0];
        [toolbarItems removeAllObjects];
        [toolbarItems addObject:cancelButton];
    }
    self.editToolbar.items = toolbarItems;
}

/** Configures the view for viewmode edit.
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForEdit:(VacationDemand *)vacationDemandToEdit {
    self.viewMode = WLVacationDetailViewMode_EDIT;
    self.vacationDemand = vacationDemandToEdit;
    
    //set the UndoManager
    self.managedObjectContext = self.vacationDemand.managedObjectContext;
    self.managedObjectContext.undoManager = [[NSUndoManager alloc]init];
    [self.managedObjectContext.undoManager beginUndoGrouping];
}

/** Configures the view for viewmode add. A null parameter is possible.
 @param newVacationDemand The vacation demand that is displayed in the view controller
 */
- (void)initForAdd: (VacationDemand *)newVacationDemand{
    self.viewMode = WLVacationDetailViewMode_ADD;
    self.vacationDemand = newVacationDemand;
    
    //creating a new VacationDemand
    if(!newVacationDemand)
        [self createVacationDemand];
}

#pragma mark - Using a Storyboard
/**---------------------------------------------------------------------------------------
 * @name Using a Storyboard
 *  ---------------------------------------------------------------------------------------
 */
/** Configure desitnation view controller on using a segue.
 @param segue The segue object containing information about the view controllers involved in the segue.
 @param sender The object, that initiated the segue.
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"called Segue: %@", segue.identifier);
    
    if([segue.identifier isEqualToString:@"addVacationPopoverSegue"]){
        [self createVacationDemand];
        ((WLVacationDetailViewController*)segue.destinationViewController).delegate = self;
        [((WLVacationDetailViewController*)segue.destinationViewController) initForAdd:self.vacationDemand];
    }
    if([segue.identifier isEqualToString:@"editVacationPopoverSegue"]){
        ((WLVacationDetailViewController*)segue.destinationViewController).delegate = self;
        [((WLVacationDetailViewController*)segue.destinationViewController) initForEdit:self.vacationDemand];
    }
    if([segue.identifier isEqualToString:@"DemandTypeSegue"]){
        ((WLVacationTypeViewController*)segue.destinationViewController).delegate = self;
    }
    if([segue.identifier isEqualToString:@"StartDateSegue"]){
        ((WLDatePickerViewController*)segue.destinationViewController).delegate = self;
        ((WLDatePickerViewController*)segue.destinationViewController).dateType = START_DATE;
        ((WLDatePickerViewController*)segue.destinationViewController).startDate = self.vacationDemand.startDate;
        ((WLDatePickerViewController*)segue.destinationViewController).endDate = self.vacationDemand.endDate;
    }
    if([segue.identifier isEqualToString:@"EndDateSegue"]){
        ((WLDatePickerViewController*)segue.destinationViewController).delegate = self;
        ((WLDatePickerViewController*)segue.destinationViewController).dateType = END_DATE;
        ((WLDatePickerViewController*)segue.destinationViewController).startDate = self.vacationDemand.startDate;
        ((WLDatePickerViewController*)segue.destinationViewController).endDate = self.vacationDemand.endDate;
    }
}

#pragma mark - Managing the Master Popover's Dismissal
/**---------------------------------------------------------------------------------------
 * @name Managing the Master Popover's Dismissal
 *  ---------------------------------------------------------------------------------------
 */
/** Setting the master popover to null after has been dismissed.
 @param popoverController The popover controller that was dismissed.*/
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
    self.masterPopoverController.delegate = nil;
    self.masterPopoverController = nil;
}

#pragma mark - Showing and Hiding Master Popover
/**---------------------------------------------------------------------------------------
 * @name Showing and Hiding Master Popover
 *  ---------------------------------------------------------------------------------------
 */
/** Showing the vacation overview button, when master popover is about to be hidden.
 @param splitController The splitt view controller that owns the master popover.
 @param viewController The master view popover.
 @param barButtonItem The button to be added to navigationToolbar.
 @param popoverController The popover that is shown on pressing barButtonItem.
 */
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"VacationOverview", @"Menu");
    [self setButton:barButtonItem visible:YES];
    self.masterPopoverController = popoverController;
}

/** Remove the vacation overview button, when master popover is about to appear.
 @param splitController The splitt view controller that owns the master popover.
 @param viewController The master view popover that will be shown.
 @param barButtonItem The button to be removed from navigationToolbar.
 */
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    
    [self setButton:barButtonItem visible:NO];
    self.masterPopoverController = nil;
}

/** Setting visible property of a button in navigationToolbar
 @param barButtonItem The button that is modified.
 @param visible Yes if button should be visible.
 */
-(void)setButton:(UIBarButtonItem*)barButtonItem visible:(BOOL)visible{
    
    NSMutableArray *items = [[self.navigateToolbar items] mutableCopy];
    
    if(visible)
        [items insertObject: barButtonItem atIndex: 0];
    else
        [items removeObject:barButtonItem];
    
    [self.navigateToolbar setItems:items animated:YES];
}

#pragma mark - Configuring the Table View
/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Asks the data source for a cell to insert in a particular location of the vacation demand table cell.
 @param tableView The vacation demand table view requesting the cell.
 @param indexPath An index path location the row in tableView.
 @return An object of type WLTableCellDesignCell that is used in specified row.
 */
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLTableCellDesignCell *cell = (WLTableCellDesignCell*)[super tableView: tableView cellForRowAtIndexPath:indexPath];
    
    [cell.textLabel setFont:[WLColorDesign getFontBold:design withSize:16.]];
    [cell.detailTextLabel setFont: [WLColorDesign getFontItalic:design withSize:12.]];
        
    if(self.viewMode == WLVacationDetailViewMode_VIEW || self.viewMode == WLVacationDetailViewMode_POPOVER_VIEW){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.userInteractionEnabled = FALSE;
    }
    
    if(self.vacationDemand){
    switch (indexPath.row) {
        case 0:            
            [cell.detailTextLabel setText: NSLocalizedString(self.vacationDemand.demandType.name, @"the Demand Type String")];
            break;
        case 1:
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate:self.vacationDemand.startDate];
            break;
        case 2:
            cell.detailTextLabel.text = [self.dateFormatter stringFromDate: self.vacationDemand.endDate];
            break;
        case 4:
            cell.detailTextLabel.text = NSLocalizedString(self.vacationDemand.demandStatus.name,@"the Status");
            break;
        default:
            break;
    }
    }
    return cell;
}

/** Asks the data source for the title of the header of the specific section of the vacation demand table view.
 @param tableView The vacation demand table view asking for the title.
 @param section An index number identifying a section in tableView.
 @return A string to use as header of section.
 */
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
        
    return [self titleForHeader];
}

/** Returns the header title in table view.
 @return The header title for section.
 */
-(NSString*)titleForHeader{
    
    if(self.viewMode == WLVacationDetailViewMode_VIEW && session.isManager && self.vacationDemand){
        
        if([self.vacationDemand.userId isEqualToNumber: session.sessionUserId])
            return NSLocalizedString(@"UsersVacationDemand", @"");
        else
            return [[NSString alloc] initWithFormat:@"%@%@%@",NSLocalizedString(@"VacationDemand", @""),NSLocalizedString(@"VacationDemandAdditional", @""),self.vacationDemand.userDisplayName];
    }
    else
        return NSLocalizedString(@"VacationDemand", @"");
    
}

/** Creates and returns the header for section in table view.
 @param tableView The tabe view calling the data source.
 @param section The section the header view should be returned.
 @return The created header view.
 @see WLTableHeaderLabel
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    WLTableHeaderLabel *textLabel = [[WLTableHeaderLabel alloc]init];
    
    textLabel.text = [self titleForHeader];
    [headerView addSubview:textLabel];
    
    return headerView;
    
}

#pragma mark - Handle Users Interaction in Add- and Edit Mode
/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction in Add- and Edit Mode
 *  ---------------------------------------------------------------------------------------
 */
/** Cancels a creation of a new vacation demand or the editing of existion one.
 @param sender The button pressed.
 */
- (IBAction)cancel:(id)sender {
    
    [[WLTutorial sharedTutorial]abortTutorial];
    [self dismissViewControllerAnimated:YES completion:^{
        //remove new Demand from Core Data
        if(self.viewMode == WLVacationDetailViewMode_ADD){
           [self.vacationDemand MR_deleteEntity];
            self.vacationDemand = nil;
        }
        
        //Undo Changes
        if(self.viewMode == WLVacationDetailViewMode_EDIT){
            if([self.managedObjectContext.undoManager canUndo]){
                NSLog(@"Undo Changes");
                [self.managedObjectContext.undoManager endUndoGrouping];
                [self.managedObjectContext.undoManager undo];                
                }
        }
        [self viewDidFinish];
    }];
}

/** Deletes the vacation demand for this view from core data. Only demand thar are not requested can be deleted.
 @warning This method has to be extended that all vacation demands can be deleted.
 @param sender The deleteButton.
 */
- (IBAction)deleteVacationDemand:(id)sender {
    
    [UIView beginAnimations:@"suck" context:NULL];
    [UIView setAnimationTransition:113 forView:self.view cache:NO];
    [UIView setAnimationDuration:1.5];
    [UIView commitAnimations];
    
    [self dismissViewControllerAnimated:YES completion:^{

        NSLog(@"Delete VacationDemand");
        if(![self.vacationDemand.demandStatus.name isEqualToString:VS_NOTSEND])
        {
            WLVacationDeleteRequest *request = [[WLVacationDeleteRequest alloc]init];
            request.vacationId = [self.vacationDemand.id stringValue];
            request.vacationStatus = self.vacationDemand.demandStatus.name;
            
            NSDictionary *postParameter = [WLMappingHelper postParameterFromVacationDeleteRequest:request];
            
            [self.restService sendVacationDeleteRequest:postParameter];
        }
        
        [self.vacationDemand MR_deleteEntity];
        self.vacationDemand = nil;
        
        [self viewDidFinish];
        [self.delegate saveVacationDemands];
    }];
}

/** The vacation demand is saved to core data but not requested.
 @param sender The button pressed.
 */
- (IBAction)saveDemand:(id)sender {
    
    if(![self.vacationDemand vacationDemandisComplete]){
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error header") message:NSLocalizedString(@"IncompleteVacationDemand", @"incomplete vacation demand message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aView show];
    }
    else{
        if([WLCalendarOperations isValidVacation:self.vacationDemand])
        {
            [self dismissViewControllerAnimated:YES completion:^{
                [self viewDidFinish];
                [self.delegate saveVacationDemands];
            }];
        }
        else
        {
            UIAlertView *aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error header") message:NSLocalizedString(@"InvalideVacationDemand", @"Invalide vacation demand message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [aView show];
        }
    }
    [[WLTutorial sharedTutorial]abortTutorial];
}

/** The vacation demand is mapped to vacation demand request and sent to wave intranet.
 @param sender The sendButtonFromEditOrCreate button.
 @see WLVacationDemandRequest
 */
- (IBAction)sendVacationRequest:(id)sender {
    
    [[WLTutorial sharedTutorial]doLastStep];
    FirstLaunch *fL = [FirstLaunch MR_findFirst];
    
    //do not send request in tutorial
    if([fL.isFirstLaunch boolValue]){
        [self.vacationDemand MR_deleteEntity];
        [self dismissViewControllerAnimated:YES completion:^{
            [self.delegate saveVacationDemands];
            [self viewDidFinish];
        }];
        return;
    }
    
    [self demandVacation];
}

#pragma mark - Handle the Vacation Demand
/**---------------------------------------------------------------------------------------
 * @name Handle the Vacation Demand
 *  ---------------------------------------------------------------------------------------
 */
/** Creates a new vacation demand instance in core data that is edited on the view controller. */
-(void)createVacationDemand{
    
    self.managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    self.vacationDemand = [VacationDemand MR_createInContext: self.managedObjectContext];
    self.vacationDemand.demandType = [VacationDemandType MR_createInContext: self.managedObjectContext];
    self.vacationDemand.demandStatus = [VacationDemandStatus MR_createInContext: self.managedObjectContext];
    self.vacationDemand.demandStatus.name = VS_NOTSEND;
    self.vacationDemand.userId = session.sessionUserId;
    self.vacationDemand.comment = @"";
    self.vacationDemand.userDisplayName = session.displayName;
    self.vacationDemand.createdOn = [[NSDate alloc]init];
    self.vacationDemand.id = @0;
}

/** Saves the vacation demand changes to core data. Called by delegate. */
-(void)saveVacationDemands{
    if(!self.managedObjectContext)
        self.managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
}

#pragma mark - Designing the View
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on vacation detail controller. */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];    
    design = [cSettings.design intValue];
    
    //redraw Table View Background
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
    
    //design Text Field
    self.commentTextField.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.commentTextField.layer.borderColor = [[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor];
    self.commentTextField.layer.borderWidth = 1.0;
    self.commentTextField.layer.cornerRadius = 8.0;
    self.commentTextField.layer.masksToBounds = YES;
    
    // Add shadow
    self.commentTextField.layer.shouldRasterize = YES;
    self.commentTextField.layer.shadowRadius = 0.3;
    self.commentTextField.layer.shadowOffset = CGSizeMake(1, 1);
    self.commentTextField.layer.shadowOpacity = 1.0;
    self.commentTextField.layer.shadowColor = [[UIColor blackColor] CGColor];
       
}

#pragma mark - Edit or create Vacation Demand from Delegate
/**-------------------------------------------------------------------
 * @name Edit or create Vacation Demand from Delegate
 *--------------------------------------------------------------------
 */
/** This mehtod is called, when the demand type of the views vacation demand has been changed.
 @param demandType The demand type after changing.
 @see WLVacationDemandProtocol
 */
-(void)didChangeVacationDemandType:(NSString*)demandType{
    
    
    [[WLTutorial sharedTutorial]doNextStep];
    [self.vacationDemand.demandType setName:demandType];
    
    //FetchedController didChangeSection only called, when changed one of the Dates
    if(self.vacationDemand.startDate)
        self.vacationDemand.startDate =  [[NSDate alloc] initWithTimeInterval:1 sinceDate:self.vacationDemand.startDate];
    
    if([self.vacationDemand vacationDemandisComplete])
        self.sendButtonFromEditOrCreate.enabled = true;
    
    [self.tableView reloadData];
}

/** This mehtod is called, when the start date of the views vacation demand has been changed.
 @param startDate The start date after changing.
 @see WLVacationDemandProtocol
 */
-(void) didChangeVacationDemandStartDate:(NSDate *)startDate{        
  
    self.vacationDemand.startDate = startDate;
    
    if([self.vacationDemand vacationDemandisComplete])
        self.sendButtonFromEditOrCreate.enabled = true;
    
    [self.tableView reloadData];
}

/** This mehtod is called, when the end date of the views vacation demand has been changed.
 @param endDate The end date after changing.
 @see WLVacationDemandProtocol
 */
-(void)didChangeVacationDemandEndDate:(NSDate *)endDate{
    
    self.vacationDemand.endDate = endDate;
    
    if([self.vacationDemand vacationDemandisComplete])
        self.sendButtonFromEditOrCreate.enabled = true;
    
    [self.tableView reloadData];
}

/** This mehtod is called, when the delegates view is closed.
 Changes are saved to the detail view controller.
 @param demand The vacation demand edited by delegates view.
 @see WLVacationDemandProtocol
 */
-(void)didCloseEditView:(VacationDemand *)demand{
    
    //show changes in VacationDemand
    self.vacationDemand = demand;    
    self.commentTextField.text = self.vacationDemand.comment;
    [self.tableView reloadData];
    if(!demand)
       [self initForView:nil];
}

#pragma mark - Presenting Another View Controller's Content
/**--------------------------------------------------------------------
 * @name Presenting Another View Controller's Content
 *---------------------------------------------------------------------
 */
/** Enables keyboard dismissal on leaving the text view.
 @return NO to dismiss the keyboard on changing control.
 */
-(BOOL)disablesAutomaticKeyboardDismissal{
    return NO;
}

#pragma mark - Responding to Text View
/**--------------------------------------------------------------------
 * @name Responding to Text View
 *---------------------------------------------------------------------
 */
/** Asks the delegate if <<return>> is pressed in textView
 @param textView The text view containing changes.
 @param range The current selection range.
 @param text The text to insert.
 @return NO, if the replacement operation should be aborted and editiong textView should be ended.
 */
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if([text isEqualToString:@"\n"]){
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

/** Tells the delegate that editing of the comment text view has ended.
 @param textView The text view in wich editing ended.
 */
-(void)textViewDidEndEditing:(UITextView *)textView{
    
    self.vacationDemand.comment = textView.text;
    
    
    [textView resignFirstResponder];
    
    [[WLTutorial sharedTutorial]doNextStep];
}


#pragma mark - Handling View Controller as Popover
/**--------------------------------------------------------------------
 * @name Handling View Controller as Popover
 *---------------------------------------------------------------------
 */
/** Delegates to parent, that view did finish editing the vacation demand. */
-(void)viewDidFinish{
    if(self.viewMode != WLVacationDetailViewMode_VIEW)
        [self.delegate didCloseEditView: self.vacationDemand];
}

#pragma mark - Communication with the Server
/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */
/** Preparing the vacation demand request for rest call. Delegating rest call and handling core data if view controller is popover.
 @see restService:doRestCallWithParameters:andDescription:andSelector:
 @see WLVacationRest
 */
- (void)demandVacation {
    
    if(![self.vacationDemand vacationDemandisComplete]){
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error header") message:NSLocalizedString(@"IncompleteVacationDemand", @"incomplete vacation demand message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aView show];
        return;
    }
    
    
    if([WLCalendarOperations isValidVacation:self.vacationDemand])
    {
        //Request this Demand
        WLVacationDemandRequest *request = [WLVacationDemandRequest initWithVacationDemand:self.vacationDemand];
        
        if([self.vacationDemand.demandStatus.name isEqualToString:VS_NOTSEND])
            request.vacationId = NULL;
        
        NSDictionary *postDict = [WLMappingHelper postParameterFromVacationDemandRequest:request];
        
        //delegate to parent, when view is popover
        if(self.viewMode != WLVacationDetailViewMode_VIEW)
            [self.delegate restService:self.restService doRestCallWithParameters:postDict andDescription:REQUEST_VACATION_DESCRIPTION andSelector:@selector(sendVacationDemandRequest:)];
            //[self.delegate doVacationDemandRestCallWithParameters:postDict];
        else
            [self.restService sendVacationDemandRequest:postDict];
        
        if(self.viewMode != WLVacationDetailViewMode_VIEW){
            [self dismissViewControllerAnimated:YES completion:^{
                [self.delegate saveVacationDemands];
                [self viewDidFinish];
            }];
        }
    }
    else
    {
        UIAlertView *aView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"Error header") message:NSLocalizedString(@"InvalideVacationDemand", @"Invalide vacation demand message") delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [aView show];
    }
}

#pragma mark - Handle Users Interaction in View Mode
/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction in View Mode
 *  ---------------------------------------------------------------------------------------
 */
/** Sending a vacaion decision request to wave intranet with status rejected.
 @param sender The rejectButton.
 @see WLVacationDecisionRequest.
 */
- (IBAction)rejectVacationDemand:(id)sender {
    
    //Create Request
    WLVacationDecisionRequest *request = [[WLVacationDecisionRequest alloc]init];
    request.vacationId = self.vacationDemand.id;
    request.status = VS_REJECTED;
    
    NSDictionary *postDict = [WLMappingHelper postParameterFromVacationDecisionRequest: request];
    
    
    [self.restService sendVacationDecisionRequest:postDict];
}

/** Sending a vacaion decision request to wave intranet with status approved.
 @param sender The vacationRequestButton.
 @see WLVacationDecisionRequest.
 */
- (IBAction)approveVacationDemand:(id)sender {
    
    //sending request, if demand is not send yet
    if([self.vacationDemand.demandStatus.name isEqualToString: VS_NOTSEND])
       [self demandVacation];
    else{
    
        //Create Request
        WLVacationDecisionRequest *request = [[WLVacationDecisionRequest alloc]init];
        request.vacationId = self.vacationDemand.id;
        request.status = VS_APPROVED;
        
        NSDictionary *postDict = [WLMappingHelper postParameterFromVacationDecisionRequest: request];
        
        
        [self.restService sendVacationDecisionRequest:postDict];    
    }
}

#pragma mark - Managing the Restcalls
/**---------------------------------------------------------------------------------------
 * @name Managing the Restcalls
 *  ---------------------------------------------------------------------------------------
 */
/** Shows an error message when rest call finished with error.
 @param restService The rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description.
 @see WLRestServiceProtocol.
 */
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString *)errorMessage andDescription:(NSString *)description{
    
    UIAlertView *aView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", @"") message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [aView show];
    
}

/** Updating or deleting the vacation demand on view controller. 
 On rejecteing or approving service the demand is deleted from local store.
 On requesting service the demand is set to pending.
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 @see WLRestServiceProtocol
 */
-(void)restService:(id)restService didFinishRestCallWithResponse:(id)response andDescription:(NSString *)description{
    
    if([description isEqualToString:REQUEST_VACATION_DESCRIPTION]){
        self.vacationDemand.demandStatus.name = VS_PENDING;
        if(((WLVacationDemandResponse*)response).vacationId)
            self.vacationDemand.id = ((WLVacationDemandResponse*)response).vacationId;
    }
    else if([description isEqualToString:DECIDE_VACATION_DESCRIPTION]){
        [self.vacationDemand MR_deleteEntity];
        self.vacationDemand = nil;
    }
    
    
    //FetchedController didChangeSection only called, when changed one of the Dates
    self.vacationDemand.startDate =  [[NSDate alloc] initWithTimeInterval:1 sinceDate:self.vacationDemand.startDate];
    
    //show changes in Demand and reset Buttons
    [self.tableView reloadData];
    [self initForView: self.vacationDemand];
    self.commentTextField.text = self.vacationDemand.comment;
    
    [self.managedObjectContext MR_saveToPersistentStoreAndWait];
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

@end
