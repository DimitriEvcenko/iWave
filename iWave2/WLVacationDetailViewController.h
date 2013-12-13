//
//  WLVacationDetailViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VacationDemand.h"
#import "VacationDemandLocal.h"

#import "WLVacationTypeViewController.h"
#import "WLVacationDemandProtocol.h"
#import "WLRestCallCompletedProtocol.h"


typedef enum {
    
    WLVacationDetailViewMode_VIEW = 1,
    WLVacationDetailViewMode_EDIT,
    WLVacationDetailViewMode_ADD,
    WLVacationDetailViewMode_POPOVER_VIEW
    
} WLVacationDetailViewMode;

/** This class defines a view controller to create, edit or just to show vacation demands in carribean mini app.
 The vacation demands properties are displayed in a table view. The view controller has foru different appearances:
 
 - the add view mode: here a new vacation demand can be created, saved or requested here.
 - the edit view mode: here an existing vacation demand can be requested, saved, modified or deleted.
 - the show view mode: here an existing vacation demand is displayed without the opportunity to be modified. From this view a new vacation detail view controller can be opened in add- or edit view. In this view a manager can approve or reject the vacation demand of a report.
 - the popover view mode: this view is similar to the normal view, but it is an only show view. So the only interaction is the cancel butoon to close the view.
 
 This view controller is presented both as detail view and as popover. It can call itself recursiv in show view so that it has a delegate to delegate like a popover.
 */
@interface WLVacationDetailViewController : UITableViewController <UISplitViewControllerDelegate,
                                                                    WLDesignGuide,
                                                                    UITextViewDelegate,
                                                                    WLVacationDemandProtocol,
                                                                    WLRestServiceProtocol>

/**--------------------------------------------------------
 *@name Handle the UI-Controls in View Mode.
 *---------------------------------------------------------
 */
/** The toolbar shown in view mode */
@property (weak, nonatomic) IBOutlet UIToolbar *navigateToolbar;

/** The edit button is subview of navigateToolbar and used to open edit view mode. It it removed when a vacation demand cannot be edited. */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

/** The vacation request button is subview of navigateToolbar and used to approve a vacation demand request. It it removed when a vacation demand cannot be approved or user is no manager. 
 @see WLVacationDecisionRequest*/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *vacationRequestButton;

/** The reject button is subview of navigateToolbar and used to reject a vacation demand request. It it removed when a vacation demand cannot be rejected or user is no manager.
 @see WLVacationDecisionRequest*/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rejectButton;

/** The add button is subview of navigateToolbar and used to create a new vacation demand. It it removed when user has no manager.
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

/**--------------------------------------------------------
 *@name Handle the UI-Controls in Edit- and Add Mode.
 *---------------------------------------------------------
 */
/** The toolbar shown in edit- and create mode. */
@property (weak, nonatomic) IBOutlet UIToolbar *editToolbar;

/** The delete button is subview of editToolbar and used to delet a vacation demand. It it removed when a vacation demand cannot be deleted. */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;

/** The save button is subview of editToolbar and used to save a vacation demand local. It it removed when a vacation demand cannot be saved local. */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

/** The send button is subview of editToolbar and used to request a vacation demand. It is disabled as long as a vacation demand is not complete.
 @see WLVacationDecisionRequest
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sendButtonFromEditOrCreate;


/**--------------------------------------------------------
 *@name Handle the common UI-Controls
 *---------------------------------------------------------
 */
/** The textfield represents the comment of a vacation demand. In View Mode the textField cannot be edited. */
@property (weak, nonatomic) IBOutlet UITextView *commentTextField;


/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** The delegate to delegate events to parent view controller. */
@property(nonatomic, retain) id delegate;

/** The vacation demand that is displayed or modified in the view controller. */
@property (nonatomic, strong) VacationDemand *vacationDemand;

/** The mode the view controller is displayed. */
@property(nonatomic, assign) WLVacationDetailViewMode viewMode;

/** A date Formatter to display date in the controller. */
@property(strong, nonatomic) NSDateFormatter *dateFormatter;

/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction in View Mode
 *  ---------------------------------------------------------------------------------------
 */
/** Sending a vacaion decision request to wave intranet with status rejected.
 @param sender The rejectButton.
 @see WLVacationDecisionRequest.
 */
- (IBAction)rejectVacationDemand:(id)sender;

/** Sending a vacaion decision request to wave intranet with status approved.
 @param sender The vacationRequestButton.
 @see WLVacationDecisionRequest.
 */
- (IBAction)approveVacationDemand:(id)sender;

/**---------------------------------------------------------------------------------------
 * @name Handle Users Interaction in Add- and Edit Mode
 *  ---------------------------------------------------------------------------------------
 */
/** Cancels a creation of a new vacation demand or the editing of existion one.
 @param sender The button pressed. 
 */
- (IBAction)cancel:(id)sender;

/** Deletes the vacation demand for this view from core data. Only demand thar are not requested can be deleted.
 @warning This method has to be extended that all vacation demands can be deleted.
 @param sender The deleteButton.
 */
- (IBAction)deleteVacationDemand:(id)sender;

/** The vacation demand is saved to core data but not requested. 
 @param sender The button pressed. 
*/
- (IBAction)saveDemand:(id)sender;

/** The vacation demand is mapped to vacation demand request and sent to wave intranet.
 @param sender The sendButtonFromEditOrCreate button.
 @see WLVacationDemandRequest
 */
- (IBAction)sendVacationRequest:(id)sender;

/**---------------------------------------------------------------------------------------
 * @name Configure the View Controller
 *  ---------------------------------------------------------------------------------------
 */
/** Configures the view for viewmode view.
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForView:(VacationDemand *)vacationDemandToView;

/** Configures the view for viewmode add. A null parameter is possible.
 @param newVacationDemand The vacation demand that is displayed in the view controller
 */
- (void)initForAdd: (VacationDemand *)newVacationDemand;

/** Configures the view for viewmode edit.
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForEdit:(VacationDemand *)vacationDemandToView;

/** Configures the view for popover-viewmode view.
 @param vacationDemandToView The vacation demand that is displayed in the view controller
 */
- (void)initForPopoverView:(VacationDemand *)vacationDemandToView;

@end
