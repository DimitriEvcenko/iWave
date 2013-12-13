//
//  WLDatePickerViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 03.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLDatePickerViewController.h"

@implementation WLDatePickerViewController

/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some configuration on view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

/** Setting minimum and maximum date of the datePicker and the shown date on appearance.*/
-(void)configureView{
    
    NSDate *today = [[NSDate alloc]init];
    self.datePicker.minimumDate = today;
    
    switch (self.dateType) {
        case START_DATE:
            self.datePicker.minimumDate = [[NSDate alloc]init];
            if(self.startDate)
                self.datePicker.date = self.startDate;
            if(self.endDate)
                self.datePicker.maximumDate = self.endDate;
            break;
        case END_DATE:
            if(self.endDate)
                self.datePicker.date = self.endDate;
            if ([self.startDate compare: today] == NSOrderedDescending)
                self.datePicker.minimumDate = self.startDate;
            break;
        default:
            break;
    }
}

/**---------------------------------------------------------------------------------------
 * @name Responding to View Events
 *  ---------------------------------------------------------------------------------------
 */
/** Delegate the changes in datePicker to parent controller.
 @param animated If YES, the disappearance of the view is being animated.
 @see WLVacationDemandProtocol
 */
-(void)viewWillDisappear:(BOOL)animated{
    switch (self.dateType) {
        case START_DATE:
            [self.delegate didChangeVacationDemandStartDate:self.datePicker.date];
            break;
        case END_DATE:
            [self.delegate didChangeVacationDemandEndDate:self.datePicker.date];
            break;
        default:
            break;
    }
}

@end
