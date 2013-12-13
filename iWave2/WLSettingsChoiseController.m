//
//  WLSettingsChoiseController.m
//  iWave2
//
//  Created by Marco Lorenz on 13.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSettingsChoiseController.h"
#import "WLTableCellDesignCell.h"
#import "WLAppStyle.h"

@interface WLSettingsChoiseController (){
    /**---------------------------------------------------------------------------------------
     * @name Show and change Common Settings
     *  ---------------------------------------------------------------------------------------
     */
    /** An array that contains the complete range of options to select. */
    NSArray *choises;
    
    /**---------------------------------------------------------------------------------------
     * @name Configure the View
     *  ---------------------------------------------------------------------------------------
     */
    /** On initial configuration this value is set. On reset the view it can be used. */
    NSNumber *selectionForReset;
}

@end

@implementation WLSettingsChoiseController

@synthesize choise = _choise;


/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design and configuration on view did load. */
- (void)viewDidLoad
{
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super viewDidLoad];
    [self configureView];
    [self adaptStyle];
}

/**---------------------------------------------------------------------------------------
 * @name Configure the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing initial configuration in setting the model and preparing for undo.
 */
-(void)configureView{
    
    self.settings = [CommonSettings MR_findFirst];
    
    switch (self.choise) {
        case DESIGN:
            choises = [WLSettingsModel setTheDesginSettings];
            selectionForReset = self.settings.design;
            break;
        case USABILITY:
            choises = [WLSettingsModel setTheUsabilitySettings];
            selectionForReset = self.settings.usability;
            break;
        default:
            break;
    }
    
}

#pragma mark - table View
/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Returns 1 because there is only one section.
 @param tableView The table view requesting the information.
 @return The number of sections in tableView.
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/** Returns the count of different choise opption in the table view.
 @param tableView The table view requesting this information.
 @param section The section the coises are counted. Only section 1 exists.
 @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [choises count];
}

/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location row in tableView.
 @return An WLTableCellDesignCelll Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    WLTableCellDesignCell *cell = (WLTableCellDesignCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.textLabel setFont:[WLColorDesign getFontBold:SIDION_LIGHT withSize:16.]];
    [cell.detailTextLabel setFont: [WLColorDesign getFontItalic:SIDION_LIGHT withSize:12.]];
    
    cell.textLabel.text = (NSString*)[choises objectAtIndex:indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryNone;
    switch (self.choise) {
        case DESIGN:
            if([self.settings.design intValue] == indexPath.row)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return cell;
        case USABILITY:
            if([self.settings.usability intValue] == indexPath.row)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            return cell;
        default:
            break;
    }
    
    return (WLTableCellDesignCell*)cell;
}

/**---------------------------------------------------------------------------------------
 * @name Managing Selections
 *  ---------------------------------------------------------------------------------------
 */
/** Changing the model an changing the selected cell.
 @param tableView The table view a row is selected.
 @param indexPath An index path specifies the selected row in tableView.
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.choise) {
        case DESIGN:
            self.settings.design = [[NSNumber alloc] initWithInt:indexPath.row];
            break;
        case USABILITY:
            self.settings.usability = [[NSNumber alloc] initWithInt:indexPath.row];
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}

/**---------------------------------------------------------------------------------------
 * @name Leaving the View
 *  ---------------------------------------------------------------------------------------
 */
/** On cancel the view is dismissed whitout doing any changes.
 @param sender The button that is pressed to leave the view.
 */
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
        switch (self.choise) {
            case DESIGN:
                self.settings.design = [[NSNumber alloc] initWithInt: [selectionForReset intValue]];
                break;
            case USABILITY:
                self.settings.usability = [[NSNumber alloc] initWithInt: [selectionForReset intValue]];
                break;
            default:
                break;
        };
    }];
}

/** Changes in common settings are changed in this method. Changes in design are delegated.
 @param sender The button that is pressed to leave the view.
 */
- (IBAction)saveChanges:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        if(self.choise == DESIGN){
            [WLAppStyle applyStyle];
            [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
            [[NSNotificationCenter defaultCenter] postNotificationName:DESIGN_NOTIFICATION object:self];
        }
    }];
}

#pragma mark - Design Guide
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on view controller
 i.e. the table views backgroundcolor is changed here.
 */
-(void) adaptStyle{
    int design = [self.settings.design intValue];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
}


@end
