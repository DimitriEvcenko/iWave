//
//  WLCalendarMonthItem.h
//  iWave2
//
//  Created by Marco Lorenz on 24.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The class defines the model of a calendar month.

An Instance of this class can be displayed in the applications calendar view.
*/
@interface WLCalendarMonthItem : NSObject

/**-------------------------------------------------------------------------
*@name Display on the Calendar View.
*---------------------------------------------------------------------------
*/
/** An Array of WLCalendarDayItems modelling all days displayed on calendar view.
@see WLCalendarDayItem
*/
@property (strong, nonatomic) NSArray *dayItems;

/** The displayed name of the month.
*/
@property (strong, nonatomic) NSString *monthDisplayName;

/** The displayed description of the year.
*/
@property (strong, nonatomic) NSString *yearDisplayName;

/**-------------------------------------------------------------------------
*@name Creating Calendar Month Item
*---------------------------------------------------------------------------
*/
/** Setting the month item to a real month.

The dayItems created are not only the days of the month. There are also days of the previous or following month to fill up weeks.
Additional there are created day items to describe the weekdays a first.
@warning Not yet testet, what happens, when start and end date are not correct!
@param startDate Has to be the first day of the month.
@param endDate Has to be the last day of the same month.
*/
-(void)initWithStartDate:(NSDate *)startDate andEndDate: (NSDate *)endDate;

/**-------------------------------------------------------------------------
*@name Navigate to other Months.
*---------------------------------------------------------------------------
*/
/** Setting the instance to the next month.
*/
-(void)getNextMonthItem;

/** Setting the instance to the previous month.
*/
-(void)getPreviousMonthItem;

/** Setting the instance to the next year.
*/
-(void)getNextYearMonthItem;

/** Setting the instance to the previous year.
*/
-(void)getPreviousYearMonthItem;

/**-------------------------------------------------------------------------
*@name Display on the Calendar View.
*---------------------------------------------------------------------------
*/
/** This method determines the name of the next month.
@return The full name of the next month.
*/
-(NSString*)getNextMonth;

/** This method determines the name of the previous month.
@return The full name of the previous month.
*/
-(NSString*)getPreviousMonth;

/** This method determines the name of the next year.
@return The full name of the next year.
*/
-(NSString*)getNextYear;

/** This method determines the name of the previous year.
@return The full name of the previous year.
*/
-(NSString*)getPreviousYear;


@end
