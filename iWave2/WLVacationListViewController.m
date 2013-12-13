//
//  WLVacationListViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationListViewController.h"
#import "VacationDemand.h"
#import "CoreData+MagicalRecord.h"
#import "WLVacationListViewCell.h"
#import "WLVacationDetailViewController.h"
#import "VacationDemandStatus.h"
#import "CommonSettings.h"
#import "WLTableHeaderLabel.h"


@interface WLVacationListViewController ()

@end

@implementation WLVacationListViewController

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some configuration on view did load. */
- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailViewController = (WLVacationDetailViewController *) [self.splitViewController.viewControllers lastObject];
    self.managedObjectContext = [NSManagedObjectContext MR_contextForCurrentThread];
    [self adaptStyle];
}

/** Releases the properties on unloading view. */
- (void)viewDidUnload {
    self.fetchedResultsController = nil;
}

/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on vacation detail controller. */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getThirdBackgroundColor:design];
    
}


/**---------------------------------------------------------------------------------------
 * @name Configuring the Table View
 *  ---------------------------------------------------------------------------------------
 */
/** Returns the count of different demand statuses of users vacation demands to create sections in table view. 
 @param tableView The table view requesting the information.
 @return The number of sections in tableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [[self.fetchedResultsController sections] count];
}

/** Returns the count of vacation demands in a section of table view.
 @param tableView The table view requesting this information.
 @param section The section the vacation demands are counted.
 @return The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    NSLog(@"What : %i", [sectionInfo numberOfObjects]);
    return [sectionInfo numberOfObjects];
}

/** Configures the cells in table view in a particular location.
 @param tableView The table view requesting the cell. 
 @param indexPath An index path location row in tableView.
 @return An UITableViewCell Object that is used from tableView for the specific indexPath.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VacationCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/** Creates the headers of the table view. The vacation demand types are the titles.
 @param tableView The table view asking for the title.
 @param section The section the title is set to.
 @return A string used as title of the section header.
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
        return [self titleForHeaderInSection:section];
}

/** Returns the header title in table view.
 @param section The section the title is set to.
 @return The header title for section.
 */
-(NSString*)titleForHeaderInSection:(NSInteger)section{
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return NSLocalizedString([sectionInfo name],@"the Sectionname");
    
}

/** Creates and returns the header for section in table view.
 @param tableView The tabe view calling the data source.
 @param section The section the header view should be returned.
 @return The created header view.
 @see WLTableHeaderLabel
 */
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, tableView.bounds.size.height)];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 400, 30)];
    
    textLabel.text = [self titleForHeaderInSection:section];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.backgroundColor = [UIColor clearColor];
    [headerView addSubview:textLabel];
    
    return headerView;
    
}

/**---------------------------------------------------------------------------------------
 * @name Inserting or Deleting Table Rows
 *  ---------------------------------------------------------------------------------------
 */
/** Inserting or deleting tableView rows on changes in vacation demand core data count.
 @param tableView The table view requesting the insertion or deletion.
 @param editingStyle The cell editing style corresponding to a insertion or deletion requested for the row specified by indexPath.
 @param indexPath An index path locating the row in tableView.
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        VacationDemand *vacationDemand = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [vacationDemand MR_deleteInContext:self.managedObjectContext];
        [self.managedObjectContext MR_saveToPersistentStoreAndWait];
    }
}

/**---------------------------------------------------------------------------------------
 * @name Managing Selections
 *  ---------------------------------------------------------------------------------------
 */
/** Showing vacation demand in detail view on selection row in tableView.
 @param tableView The table view a row is selected.
 @param indexPath An index path specifies the selected row in tableView.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        VacationDemand *vacationDemand = [self.fetchedResultsController objectAtIndexPath:indexPath];
        WLVacationDetailViewController *detailViewController = (WLVacationDetailViewController*)[self.splitViewController.viewControllers lastObject];
        //[detailViewController setVacationDemand:vacationDemand];
        //[self.detailViewController setVacationDemand:vacationDemand];
        [self.detailViewController initForView:vacationDemand];
        [self.detailViewController.tableView reloadData];
        detailViewController.delegate = self;
    }
}

/**----------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/** The getter of the fetched results controller. Vacation demands are grouped by theire demand status.
 @return The instance of the special view controllers fetched results controller.
 */
- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }
    
    _fetchedResultsController = [VacationDemand MR_fetchAllGroupedBy:@"demandStatus.name" withPredicate:nil sortedBy:@"demandStatus.name,startDate" ascending:YES delegate:self];
    
    return _fetchedResultsController;
}

/**----------------------------------------------------------------------------------------
 * @name Responding to Changes in Vacation Demands
 *  ---------------------------------------------------------------------------------------
 */
/** Called when the controller is about to start processing of one or more changes.
 Doing updates in table view to display changes.
 @param controller The fetchedResultsController sending the message.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

/** Called when a new vacation demand status is used or one is removed. The section in table view is added or removed.
 @param controller The fetched controller getting the changes.
 @param sectionInfo The section that has changed.
 @param sectionIndex The index of the changed section.
 @param type The type of change.
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/** Called when the fetched object (any vacation demand) has been changed.
 Doing updates in table view to display changes.
 @param controller The fetchedResultsController sending the message.
 @param anObject The object in controller'S fetched reults that changed.
 @param indexPath The index path of the changed object.
 @param type The type of change.
 @param newIndexPath The destioation path for insertion or movements of objects.
 */
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [tableView reloadData];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

/** Called when the controller finished one or more changes to vacation demands.
 Doing updates in table view to display changes.
 @param controller The fetchedResultsController sending the message.
 */
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

/**----------------------------------------------------------------------------------------
 * @name Display Vacation Demands
 *  ---------------------------------------------------------------------------------------
 */
/** Configures a cell in table view to display the vacation damands start date.
 @param cell The WLVacationListViewCell to be configured in table view.
 @param indexPath The index path of the vacation demand to display.
 */
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    VacationDemand *vacationDemand = [self.fetchedResultsController objectAtIndexPath:indexPath];
    WLVacationListViewCell *listViewCell = (WLVacationListViewCell *) cell;
    NSLog(@"DEBUGGING it: %i %i : %@ %@", indexPath.section, indexPath.row, [vacationDemand valueForKey:@"userDisplayName"], vacationDemand.demandStatus);
    listViewCell.vacationDemand = vacationDemand;
}

/** The getter of the formatter that describes the start date of a vacation demand shown in the table view cell. 
 @return An Instance of the view controller specific date formatter.
 */
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterMediumStyle];
        _dateFormatter = dateFormat;
    }
    return _dateFormatter;
}

@end
