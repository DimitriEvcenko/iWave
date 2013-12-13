//
//  WLTeamViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 09.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTeamViewController.h"
#import "Teammate.h"
#import "CommonSettings.h"
#import "WLTableCellDesignCell.h"
#import "WLTableHeaderLabel.h"


@interface WLTeamViewController ()

/**---------------------------------------------------------------------------------------
 * @name Manage Relationships
 *  ---------------------------------------------------------------------------------------
 */
/** This array contains teammate objects with relationship teammate to the user.
 @see Teammate
 */
@property NSArray *teammates;

/** This array contains teammate objects with relationship manager to the user. 
 @see Teammate
 */
@property NSArray *managers;

/** This array contains teammate objects with relationship direct reports to the user.
 @see Teammate
 */
@property NSArray *directReports;

/**---------------------------------------------------------------------------------------
 * @name Model the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** This array contains the numbers of rows for each selection. */
@property NSArray *rowsInSection;


@end

@implementation WLTeamViewController

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design and creating model on view did load. 
 The relationship array are filled an the rows in section array is created.*/
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adaptStyle];
    self.teammates = [Teammate MR_findByAttribute:@"relationToUser" withValue:[[NSNumber alloc] initWithInt: TEAMMATE]];
    self.managers = [Teammate MR_findByAttribute:@"relationToUser" withValue:[[NSNumber alloc] initWithInt: MANAGER]];
    self.directReports = [Teammate MR_findByAttribute:@"relationToUser" withValue:[[NSNumber alloc] initWithInt: DIRECTREPORT]];
    
    self.rowsInSection = [[NSArray alloc]initWithObjects:[[NSNumber alloc] initWithInteger:[self.managers count]],
                          [[NSNumber alloc] initWithInteger:[self.teammates count]],
                          [[NSNumber alloc] initWithInteger:[self.directReports count]], nil];

}

#pragma mark - Table view data source

/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Returns the groups of relationships the user has and uses this as section count.
 @param tableView The table view requesting the information.
 @return The number of sections in tableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.rowsInSection count];
}

/** Returns the count of different users in one selection.
 @param tableView The table view requesting this information.
 @param section The section the users are counted.
 @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return [self.managers count];
        case 1:
            return [self.teammates count];
        case 2:
            return [self.directReports count];
        default:
            break;
    }
    return 0;
}

/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell.
 @param indexPath An index path location row in tableView.
 @return An Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TeammateCell";
    WLTableCellDesignCell *cell = (WLTableCellDesignCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = ((Teammate *)[self.managers objectAtIndex:indexPath.row]).displayName;
            break;
        case 1:
            cell.textLabel.text = ((Teammate *)[self.teammates objectAtIndex:indexPath.row]).displayName;
            break;
        case 2:
            cell.textLabel.text = ((Teammate *)[self.directReports objectAtIndex:indexPath.row]).displayName;
            break;
        default:
            break;
    }
    
    return cell;
}

/** Specify the title for the section.
 @param tableView The table view asking for the data source.
 @param section An index number identifying a section of tableView.
 @return A string to use as title of the section header.
 */
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self titleForHeaderInSection:section];
}

/** Specify the title for the section.
 @param section An index number identifying a section of tableView.
 @return A string to use as title of the section header.
 */
-(NSString*)titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            if([self.managers count]>0)
                return NSLocalizedString(@"Manager", @"");
            break;
        case 1:
            if([self.teammates count]>0)
                return NSLocalizedString(@"Teammates", @"");
            break;
        case 2:
            if([self.directReports count]>0)
            return NSLocalizedString(@"DirectReports", @"");
        default:
            return @"";
    }
    return @"";
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

    int design = [cSettings.design intValue];

    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
}


@end
