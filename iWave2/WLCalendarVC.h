//
//  WLCalendarVC.h
//  iWave2
//
//  Created by Marco Lorenz on 05.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLVacationDemandProtocol.h"
#import "WLRestCallCompletedProtocol.h"
#import "WLRoundedRectangleView.h"

static NSString * const CalendarCellIdentifier = @"CalendarCell";

/** This is the applications calendar view controller.

This view shows a calendar in a month overview created as collection view. Navigation through the months and years is managed here.
The view controller can be used to create vacation demand on klicking on the calendar days.
Implemented is the calender view by an UICollectionView.*/
@interface WLCalendarVC : UIViewController <UICollectionViewDelegateFlowLayout,
                                            UICollectionViewDataSource,
                                            UICollectionViewDelegate,
                                            WLDesignGuide,
                                            WLVacationDemandProtocol,
                                            WLRestServiceProtocol>
/**------------------------------------------------------------------------
* @name Handle the UI-Controls.
*--------------------------------------------------------------------------
*/
/** The collection view that displays the calendar.*/
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

/** The label to display the selected month and year */
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

/** A label to display error messages. */
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;

/** The image view shown in the background. */
@property (weak, nonatomic) IBOutlet UIImageView *calendarImage;

/** The view navigation bar for displaying and changing the month views in collection view. */
@property (weak, nonatomic) IBOutlet WLRoundedRectangleView *navigationViewBar;

/**------------------------------------------------------------------------
* @name Navigate through the calendar.
*--------------------------------------------------------------------------
*/
/** The segment controll to navigate through the months and years */
@property (weak, nonatomic) IBOutlet UISegmentedControl *navigationSegmentControl;

/** This method moves the calendar view horizontal by users pan gesture over the view.
On only little movements the calendar view is animated back to origin on finishing the gesture.
Doing the gesture to a threshold value this method finishes the started animation to the selected direction.
A swipe gesture to the left switches to the next month.
@param sender This is the pan gesture recognizer on the collectionView.
*/
- (IBAction)changeMonth:(UIPanGestureRecognizer *)sender;

/** This mehtod displays another month on collectionView.
 There are 5 different states to use:
 
    - next/previous Year
    - next/ previous Month
    - todays Month
 
 To change the month the old month-view is animated out of the view and the next month-view is animated into the view.
 @param sender The segment control that has changed value.
 */
- (IBAction)monthChanged:(UISegmentedControl *)sender;

@end
