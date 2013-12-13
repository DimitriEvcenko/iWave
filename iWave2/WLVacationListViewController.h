//
//  WLVacationListViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLAppDelegate.h"

@class WLVacationDetailViewController;

/** The vacation list view controller is used as master in a split view with WLVacationDetailViewController.
 It contains a table view that shows all vacation demands managed by a fetched controller.
 So all changes in core data are shown in the table. The vacation demands are sorted to sections by theire demand status.
 */
@interface WLVacationListViewController : UITableViewController <NSFetchedResultsControllerDelegate>

/**----------------------------------------------------------------------------------------
 * @name Handling Core Data
 *  ---------------------------------------------------------------------------------------
 */
/** The controller fetching vacation demands from core data.*/
@property(strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

/** This is the managed object context for the current session. */
@property(strong, nonatomic) NSManagedObjectContext *managedObjectContext;

/**----------------------------------------------------------------------------------------
 * @name Display Vacation Demands
 *  ---------------------------------------------------------------------------------------
 */
/** The formatter that describes the start date of a vacation demand shown in the table view. */
@property(strong, nonatomic) NSDateFormatter *dateFormatter;

/**--------------------------------------------------------
 *@name Managing the Splitt Views  Detail View Controller
 *---------------------------------------------------------
 */
/** The detail view controller in the split view. */
@property (strong, nonatomic) WLVacationDetailViewController *detailViewController;

@end
