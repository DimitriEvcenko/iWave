//
//  WLProfileSettingsViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 10.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLProfileSettingsViewController.h"
#import "CommonSettings.h"
#import "User.h"
#import "WLTableCellDesignCell.h"
#import "WLAppDelegate.h"
#import "WLTableHeaderLabel.h"

@interface WLProfileSettingsViewController ()

@end

@implementation WLProfileSettingsViewController
int design;

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design and configuration on view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
    [self adaptStyle];
}

/**---------------------------------------------------------------------------------------
 * @name Confiuring the View
 *  ---------------------------------------------------------------------------------------
 */
/** Setting the user object from core data. */
-(void)configureView{
    
    //Load User from Core Data
    self.user = [User MR_findFirstByAttribute:@"userId" withValue:session.sessionUserId];
    
}

/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Setting the table view background color. */
-(void)adaptStyle{
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    design = [cSettings.design intValue];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];    
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
}


#pragma mark - Table view delegate
/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location row in tableView.
 @return An WLTableCellDesignCelll Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WLTableCellDesignCell *cell = (WLTableCellDesignCell*)[super tableView: tableView cellForRowAtIndexPath:indexPath];
    [cell.textLabel setFont:[WLColorDesign getFontBold:design withSize:16.]];
    [cell.detailTextLabel setFont: [WLColorDesign getFontItalic:design withSize:12.]];
    
    
    if(indexPath.section == 0){
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = self.user.firstName;
                break;
            case 1:
                cell.detailTextLabel.text = self.user.lastName;
                break;
            case 2:
                cell.detailTextLabel.text = self.user.shortName;
                break;           
        }
    }
    else{
        switch (indexPath.row) {
            case 0:
                cell.detailTextLabel.text = self.user.email;
                break;
            case 1:
                cell.detailTextLabel.text = self.user.telephoneNumber;
                break;
            case 2:
                cell.detailTextLabel.text = self.user.email;
                break;
        }
    }
    return cell;
    
}

/** Returns the header title in table view  for a section
 @param section The section the header is returned
 @return The header title for section.
 */
-(NSString*)titleForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:
            return NSLocalizedString(@"ProfileSettings", @"");
        case 1:
            return NSLocalizedString(@"ContactSettings", @"");
        default:
            return @"";
    }
    
}

/** Creates and returns the header for section in table view.
 @param tableView The tabe view calling the data source.
 @param section The section the header view should be returned.
 @return The created header view.
 @see WLTableHeaderLabel
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    WLTableHeaderLabel *textLabel = [[WLTableHeaderLabel alloc]init];
    
    textLabel.text = [self titleForHeaderInSection:section];
    [headerView addSubview:textLabel];
    
    return headerView;
    
}

@end
