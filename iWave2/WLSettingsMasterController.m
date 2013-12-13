//
//  WLSettingsMasterController.m
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSettingsMasterController.h"
#import "WLSettingsDetailController.h"
#import "CommonSettings.h"


@implementation WLSettingsMasterController
int design;

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some additional configuration on viewDidLoad.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.settingsModel = [[WLSettingsModel alloc]init];
    [self adaptStyle];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDesign) name:DESIGN_NOTIFICATION object:nil];
}


#pragma mark - Table view data source
/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Returns 1 because there is only one section.
 @param tableView The table view requesting the information.
 @return The number of sections in tableView.
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}

/** Returns the count of different setting options in the table view.
 @param tableView The table view requesting this information.
 @param section The section the setting options are counted. Only section 1 exists.
 @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.settingsModel.settings count];
}

/** Asks the data source for a cell to insert in information about different setting options in table cell.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location the row in tableView.
 @return An object of type UITableViewCell that is used in specified row.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SettingsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.textLabel.textColor = [WLColorDesign getMainFontColor:design];
    cell.textLabel.font = [WLColorDesign getFontNormal:design withSize:20.];
    cell.textLabel.text = [self.settingsModel.settings objectAtIndex:indexPath.row];
    cell.indentationWidth = 20.;
    
    cell.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
    
    return cell;
}

#pragma mark - Table view delegate
/**---------------------------------------------------------------------------------------
 * @name Managing Selections
 *  ---------------------------------------------------------------------------------------
 */
/** Changing detail view controller in split view on changing selected cell.
 @param tableView The table view a row is selected.
 @param indexPath An index path specifies the selected row in tableView.
 */

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *object = [NSNumber numberWithInt:indexPath.row];
    
    WLSettingsDetailController *detailViewController = (WLSettingsDetailController *)[self.splitViewController.viewControllers lastObject];
    [detailViewController setDetailItem:object];    
}

#pragma mark - Design Protocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on view controller
 i.e. the table views backgroundcolor is changed here.
 */
-(void)adaptStyle{
    
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    design = [cSettings.design intValue];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getThirdBackgroundColor:design];
        
}

/** On changes in common design settings this method is called by delegate settings detail controller.
 The method delegates the changes down the line.
 @see WLSettingsDetailController
 */
-(void)didChangeDesign{
    
    [self.tableView reloadData];
    [self adaptStyle];
}


@end
