//
//  WLListViewCell.m
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationListViewCell.h"
#import "WLCalendarOperations.h"
#import "VacationDemandType.h"

@implementation WLVacationListViewCell

/**--------------------------------------------------------
 * @name Display a Vacation Demands Duration
 *--------------------------------------------------------
 */
/** Setter of the vacation demand property. The textLabel is set in this setter.
 @param vacationDemand The vacation demand that should be shown in the cell.
 */
-(void)setVacationDemand:(VacationDemand *)vacationDemand{
    
    _vacationDemand = vacationDemand;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterMediumStyle];
    
    int vacationDays = [WLCalendarOperations daysFromDate:_vacationDemand.startDate toDate:_vacationDemand.endDate includingDates:YES];
    NSString *dayName = NSLocalizedString(@"DaysString", @"");
    
    if(vacationDays == 1)
        dayName = [dayName substringToIndex:[dayName length]-1];
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    
    if(!_vacationDemand.startDate || !_vacationDemand.endDate)
        self.textLabel.text = @"";
    else{
        self.textLabel.text = [NSString stringWithFormat:@"%@: %@ - %@ (%i %@)", NSLocalizedString(_vacationDemand.demandType.name,@""),[dateFormat stringFromDate: _vacationDemand.startDate],[dateFormat stringFromDate: _vacationDemand.endDate], vacationDays,dayName];
    }
}

@end
