//
//  WLVacationTypeViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 03.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationTypeViewController.h"
#import "WLTableCellDesignCell.h"
#import "CommonSettings.h"


@interface WLVacationTypeViewController ()

/**---------------------------------------------------------------------------------------
 * @name Model the Table View Cells
 *  ---------------------------------------------------------------------------------------
 */
/** The different vacartion demand types in an array that can be displayed in the table view.
 @see VacationDemandType
 */
@property NSArray *vacationTypes;

/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** The property describes the selected design of the logged in user.
 @see CommonSettings
 */
@property int design;

@end

@implementation WLVacationTypeViewController


/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design and creating model on view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adaptStyle];
    self.vacationTypes = [[NSArray alloc] initWithObjects:
                          VD_HOLIDAY,
                          VD_PARENTALLEAVE,
                          VD_SEMINAR,
                          VD_FLEXITIME,
                          VD_SABBATICAL, nil];
}


/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Returns 1 because there is only one section.
 @param tableView The table view requesting the information.
 @return The number of sections in tableView.
 */- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/** Returns the count of different vacation demand types in the table view.
 @param tableView The table view requesting this information.
 @param section The section the vacation demand types are counted. Only section 1 exists.
 @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.vacationTypes count];
}

/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location row in tableView.
 @return An WLTableCellDesignCelll Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VacationTypeCell" forIndexPath:indexPath];
    
    cell.textLabel.text = NSLocalizedString((NSString*)[self.vacationTypes objectAtIndex:indexPath.row],@"the shown String");
    [cell.textLabel setFont:[WLColorDesign getFontBold:self.design withSize:16.]];
    [cell.detailTextLabel setFont: [WLColorDesign getFontItalic:self.design withSize:12.]];
    
    
    return (WLTableCellDesignCell*)cell;
}

/**---------------------------------------------------------------------------------------
 * @name Managing Selections
 *  ---------------------------------------------------------------------------------------
 */
/** Delegate the selection in tableView to a vacation demand.
 @param tableView The table view a row is selected.
 @param indexPath An index path specifies the selected row in tableView.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.delegate didChangeVacationDemandType:[self.vacationTypes objectAtIndex:indexPath.row]];
}

/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on view controller
i.e. the table views backgroundcolor is changed here.
 */
-(void)adaptStyle{
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    self.design = [cSettings.design intValue];
}

@end
