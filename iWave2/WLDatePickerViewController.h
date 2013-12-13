//
//  WLDatePickerViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 03.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLVacationDemandProtocol.h"

typedef enum{
    START_DATE = 0,
    END_DATE,
}WLDateType;

/** The date picker view controller is made to select a single date with day, month and year.
 The view controller can delegate changes in datePicker to a parent controller.
 */
@interface WLDatePickerViewController : UIViewController<WLVacationDemandProtocol>

/**---------------------------------------------------------------------------------------
 * @name Select a Date
 *  ---------------------------------------------------------------------------------------
 */
/** The date picker to select a date that can be set to vacation demands start or end date. */
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

/**--------------------------------------------------------
 *@name Handle the Delegate
 *---------------------------------------------------------
 */
/** The delegate to handle changes in datePicker. */
@property (strong, nonatomic) id<WLVacationDemandProtocol> delegate;

/**---------------------------------------------------------------------------------------
 * @name Configure Porperties from Parent
 *  ---------------------------------------------------------------------------------------
 */
/** If the start date is set it is set to the current date in datePicker, when dateType is START_DATE. */
@property (strong, nonatomic) NSDate *startDate;

/** If the end date is set it is set to the current date in datePicker, when dateType is END_DATE. */
@property (strong, nonatomic) NSDate *endDate;

/** The date type defines if the view controller is used to set a start date or an end date of a vacation demand.
 So there are two types:
 
    - START_DATE
    - END_DATE
 
 */
@property WLDateType dateType;

@end
