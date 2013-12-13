//
//  WLCalendarMonthItem.m
//  iWave2
//
//  Created by Marco Lorenz on 24.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCalendarMonthItem.h"
#import "WLCalendarDayItem.h"
#import "VacationDemand.h"
#import "WLAppDelegate.h"

#import "VacationDemandType.h"
#import "WLCalendarOperations.h"

@interface WLCalendarMonthItem()

/**-------------------------------------------------------------------------
*@name Creating Calendar Month Item
*---------------------------------------------------------------------------
*/
/** Count of the days in the current month.
@see WLCalendarDayItem
*/
@property (nonatomic) NSInteger daysInMonth;

/** The date of the first day in month.
*/
@property (strong, nonatomic) NSDate *firstDayInMonth;

@end

@implementation WLCalendarMonthItem
int secondsPerDay = 60*60*24;

/** Setting the month item to a real month.

The dayItems created are not only the days of the month. There are also days of the previous or following month to fill up weeks.
Additional there are created day items to describe the weekdays a first.
@warning Not yet testet, what happens, when start and end date are not correct!
@param startDate Has to be the first day of the month.
@param endDate Has to be the last day of the same month.
*/
-(void)initWithStartDate:(NSDate *)startDate andEndDate: (NSDate *)endDate{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *actualDay = startDate;
    NSDateComponents *comp;
    
    [comp setDay:1];
    
    //NSRange hoursPerDay;
    self.daysInMonth = [endDate timeIntervalSinceDate:startDate]/secondsPerDay + 1;
    
    NSLog(@"Setting up the CalendarMonthItem with %i days", self.daysInMonth);
    
    self.firstDayInMonth = startDate;
    
    WLCalendarDayItem *dayItem;
    NSMutableArray *items = [[NSMutableArray alloc] init];
    
    /*
     *
     * First create the names of the Days
     *
     */
    NSDate *sunday = [[NSDate alloc] initWithTimeIntervalSince1970:secondsPerDay*3];
    for(int i = 0; i< 7;i++){
        dayItem = [[WLCalendarDayItem alloc]init];
        dayItem.displayText = [WLCalendarOperations getShortWeekdayFromDate:sunday];
        dayItem.typeOfDay = dayName;
        dayItem.date = nil;
        dayItem.vacationColor = [UIColor whiteColor];
        [items addObject:dayItem];
        sunday = [sunday dateByAddingTimeInterval:secondsPerDay];
    }
    
    
    /*
     *
     *Create the empty days in the beginning
     *
     */
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:startDate];
    NSInteger firstWeekDay = [weekdayComponents weekday];
    
    actualDay = [actualDay dateByAddingTimeInterval:-(firstWeekDay-1)*secondsPerDay];
    
    for(int i = 1; i< firstWeekDay;i++){
        dayItem = [[WLCalendarDayItem alloc]init];
        dayItem.displayText = [WLCalendarOperations getWeekdayNumberFromDate:actualDay];
        dayItem.typeOfDay = noDay;
        dayItem.date = actualDay;
        dayItem.vacationColor = [UIColor whiteColor];
        [items addObject:dayItem];
        actualDay = [actualDay dateByAddingTimeInterval:secondsPerDay];
    }
    
    actualDay = startDate;
    
    /*
     *
     *Add the Days of the Month
     *
     */    
    for(int i=2; i<self.daysInMonth+2; i++){
        dayItem = [[WLCalendarDayItem alloc]init];
        dayItem.displayText = [WLCalendarOperations getWeekdayNumberFromDate:actualDay];
        
        //check for Weekend or holiday
        if([WLCalendarOperations dateIsWeenkend:actualDay]||[WLCalendarOperations dateIsPublicHoliday:actualDay forLocale:[NSLocale currentLocale]])
            dayItem.typeOfDay = freeDay;
        else if([WLCalendarOperations isVacationDay:actualDay]){
            
            if([WLCalendarOperations isSingleVacationDay:actualDay])
                dayItem.typeOfDay = singleVacationDay;
            else if([WLCalendarOperations isFirstVacationDay:actualDay])
                dayItem.typeOfDay = firstVacationDay;
            else if([WLCalendarOperations isLastVacationDay:actualDay])
                dayItem.typeOfDay = lastVacationDay;
            else
                dayItem.typeOfDay = vacationDay;
            
            dayItem.vacationColor = [self getVacationColor:actualDay];
        }        
        else
            dayItem.typeOfDay = normalDay;
        
        dayItem.date = actualDay;
        [items addObject:dayItem];
        
        comp = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:actualDay];
        //weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:actualDay];
        [comp setDay:i];
        actualDay = [calendar dateFromComponents:comp];
    }
    
    //fill the calendar
    int components = 7-[items count]%7;
    
    for(int i= 0;i< components && components!=7;i++){
        dayItem = [[WLCalendarDayItem alloc]init];
        dayItem.displayText = [WLCalendarOperations getWeekdayNumberFromDate:actualDay];
        
        dayItem.typeOfDay = noDay;
        dayItem.date = actualDay;
        dayItem.vacationColor = [UIColor whiteColor];
        
        [items addObject:dayItem];
        actualDay = [actualDay dateByAddingTimeInterval:secondsPerDay];
    }
    
    self.dayItems = [[NSArray alloc] initWithArray:items];
    
    self.monthDisplayName = [WLCalendarOperations getMonthFromDate:startDate];
    self.yearDisplayName = [WLCalendarOperations getYearFromDate:startDate];
}


#pragma mark - Navigate to other Months
/**-------------------------------------------------------------------------
*@name Navigate to other Months.
*---------------------------------------------------------------------------
*/
/** Setting the instance to the next month.
*/
-(void)getNextMonthItem{
    
    NSDate *firstDayOfNextMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfNextMonth];
    
    [comp setMonth:[comp month]+1];
    firstDayOfNextMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    //Im Oktober fehlt eine Stunde wegen Zeitverschiebung!!!
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                       inUnit:NSMonthCalendarUnit
                                      forDate:firstDayOfNextMonth];
    
    NSDate *lastDayOfNextMonth = [firstDayOfNextMonth dateByAddingTimeInterval:secondsPerDay*(days.length-1)];
    
    [self initWithStartDate:firstDayOfNextMonth andEndDate:lastDayOfNextMonth];
    
}

/** Setting the instance to the previous month.
*/
-(void)getPreviousMonthItem{
    
    NSDate *firstDayOfPreviousMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfPreviousMonth];
    
    [comp setMonth:[comp month]-1];
    firstDayOfPreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    //Im Oktober fehlt eine Stunde wegen Zeitverschiebung!!!
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                      inUnit:NSMonthCalendarUnit
                                                     forDate:firstDayOfPreviousMonth];
    
    NSDate *lastDayOfNextMonth = [firstDayOfPreviousMonth dateByAddingTimeInterval:secondsPerDay*(days.length-1)];
    
    [self initWithStartDate:firstDayOfPreviousMonth andEndDate:lastDayOfNextMonth];
}

/** Setting the instance to the next year.
*/
-(void)getNextYearMonthItem{
    
    NSDate *firstDayOfNextYearsMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfNextYearsMonth];
    
    [comp setYear:[comp year]+1];
    
    firstDayOfNextYearsMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    //Im Oktober fehlt eine Stunde wegen Zeitverschiebung!!!
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                      inUnit:NSMonthCalendarUnit
                                                     forDate:firstDayOfNextYearsMonth];
    
    NSDate *lastDayOfNextMonth = [firstDayOfNextYearsMonth dateByAddingTimeInterval:secondsPerDay*(days.length-1)];
    
    [self initWithStartDate:firstDayOfNextYearsMonth andEndDate:lastDayOfNextMonth];
    
}

/** Setting the instance to the previous year.
*/
-(void)getPreviousYearMonthItem{
	
	NSDate *firstDayOfPreviousYearsMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfPreviousYearsMonth];
    
    [comp setYear:[comp year]-1];
    
    firstDayOfPreviousYearsMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    //Im Oktober fehlt eine Stunde wegen Zeitverschiebung!!!
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                                      inUnit:NSMonthCalendarUnit
                                                     forDate:firstDayOfPreviousYearsMonth];
    
    NSDate *lastDayOfNextMonth = [firstDayOfPreviousYearsMonth dateByAddingTimeInterval:secondsPerDay*(days.length-1)];
    
    [self initWithStartDate:firstDayOfPreviousYearsMonth andEndDate:lastDayOfNextMonth];
}

/**-------------------------------------------------------------------------
*@name Display on the Calendar View.
*---------------------------------------------------------------------------
*/
/** This method determines the name of the next month.
@return The full name of the next month.
*/
-(NSString*)getNextMonth{
    
    NSDate *firstDayOfNextMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfNextMonth];
    
    [comp setMonth:[comp month]+1];
    firstDayOfNextMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];

    return [WLCalendarOperations getMonthFromDate:firstDayOfNextMonth];
}

/** This method determines the name of the previous month.
@return The full name of the previous month.
*/
-(NSString*)getPreviousMonth{
    
    NSDate *firstDayOfPreviousMonth = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfPreviousMonth];
    
    [comp setMonth:[comp month]-1];
    firstDayOfPreviousMonth = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    return [WLCalendarOperations getMonthFromDate:firstDayOfPreviousMonth];
}

/** This method determines the name of the next year.
@return The full name of the next year.
*/
-(NSString*)getNextYear{
	NSDate *firstDayOfMonthInNextYear = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfMonthInNextYear];
    
    [comp setYear:[comp year]+1];
    firstDayOfMonthInNextYear = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    return [WLCalendarOperations getYearFromDate:firstDayOfMonthInNextYear];
}

/** This method determines the name of the previous year.
@return The full name of the previous year.
*/
-(NSString*)getPreviousYear{
	NSDate *firstDayOfMonthInPreviousYear = self.firstDayInMonth;
    NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:firstDayOfMonthInPreviousYear];
    
    [comp setYear:[comp year]-1];
    firstDayOfMonthInPreviousYear = [[NSCalendar currentCalendar] dateFromComponents:comp];
    
    return [WLCalendarOperations getYearFromDate:firstDayOfMonthInPreviousYear];
}

/** This private method determines the backgroundcolor to display on a specific date and returns it.
@param date The date to get the color from.
@return A UIColor that ist displayed for the date.
*/
-(UIColor*)getVacationColor:(NSDate*)date{
    
    NSArray *demands = [VacationDemand MR_findByAttribute:@"userId" withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([WLCalendarOperations areSameDayDate:date andDate:demand.startDate]||[WLCalendarOperations areSameDayDate:date andDate:demand.endDate])
           return [self colorForDemand:demand];
        if([date compare:demand.startDate]==NSOrderedDescending && [date compare:demand.endDate]==NSOrderedAscending)
           return [self colorForDemand:demand];
    }
    return [UIColor whiteColor];
}

/** This private method determines the demand type of a vacation day. And returns a specific color to the type.
@param demand The vacation demand.
@return A UIColor that ist specific for the vacation demand type.
@see VacationDemandType
*/
-(UIColor*)colorForDemand:(VacationDemand*)demand{
    
    if([demand.demandStatus.name isEqualToString:VS_APPROVED]){
        
        if ([demand.demandType.name isEqualToString: VD_HOLIDAY])
            return [UIColor colorWithRed:0. green:0.7 blue:0. alpha:1.];
        if ([demand.demandType.name isEqualToString: VD_PARENTALLEAVE])
            return [UIColor grayColor];
        if ([demand.demandType.name isEqualToString: VD_SABBATICAL])
            return [UIColor colorWithRed:0.5 green:0. blue:0.5 alpha:1.];
        if ([demand.demandType.name isEqualToString: VD_FLEXITIME])
            return [UIColor orangeColor];
        if ([demand.demandType.name isEqualToString: VD_SEMINAR])
            return [UIColor blueColor];
    }else{
        
        if ([demand.demandType.name isEqualToString: VD_HOLIDAY])
            return [UIColor colorWithRed:0. green:1. blue:0. alpha:1.];
        if ([demand.demandType.name isEqualToString: VD_PARENTALLEAVE])
            return [UIColor lightGrayColor];
        if ([demand.demandType.name isEqualToString: VD_SABBATICAL])
            return [UIColor colorWithRed:0.7 green:0. blue:0.7 alpha:1.];
        if ([demand.demandType.name isEqualToString: VD_FLEXITIME])
            return [UIColor yellowColor];
        if ([demand.demandType.name isEqualToString: VD_SEMINAR])
            return [UIColor blueColor];
    }

    return [UIColor whiteColor];
}
@end
