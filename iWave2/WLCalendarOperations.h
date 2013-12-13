//
//  WLCalendarOperations.h
//  iWave2
//
//  Created by Marco Lorenz on 30.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacationDemand.h"

/** This class contains a lot of class methods that handle dates.
 The first task is to test a date if it is vacation date or what kind of vacation date it is.
 The second task is the comparison of dates like if dates are the same day or getting day difference of dates.
 The third task handles formatting the date to string.
 The fourth task is testing a date on public holiday or weekend.
 */
@interface WLCalendarOperations : NSObject

/**-----------------------------------------------------------------------------------------
 *@name Vacation on Date
 *------------------------------------------------------------------------------------------
 */
/** Testing if the given date is during users vacation.
 @param date The date to test for vacation.
 @return Yes if the date is a vacation day.
 */
+(BOOL)isVacationDay: (NSDate*)date;


/** Testing if the given date is during users vacation.
 @param date The date to test for vacation.
 @param idArray An array of vacation ids not to compare wiht the date.
 @return Yes if the date is a vacation day.
 */
+(BOOL)isVacationDay: (NSDate*)date exeptIDs: (NSArray*)idArray;

/** Testing if the given date is the users first vacation day.
 @param date The date to test for first vacation day.
 @return Yes if the date is the first vacation day.
 */
+(BOOL)isFirstVacationDay:(NSDate*)date;

/** Testing if the given date is the users last vacation day.
 @param date The date to test for last vacation day.
 @return Yes if the date is the last vacation day.
 */
+(BOOL)isLastVacationDay:(NSDate*)date;

/** Testing if the given date a single vacation day.
 @param date The date to test for single vacation day.
 @return Yes if the date is a single vacation day.
 */
+(BOOL)isSingleVacationDay:(NSDate*)date;

/** This mehtod checks if the last vacation day of the user was wihtin the week before the date parameter.
 @param date The date to look for last vacation.
 @return Yes, if the last vacation day is within one week before the date parameter.
 */
+(BOOL)dateIsWeekAfterVacation:(NSDate *)date;

/** This mehtod checks if the next vacation day of the user is wihtin the week after the date parameter.
 @param date The date to look for next vacation.
 @return Yes, if the nextt vacation day is within one week after the date parameter.
 */
+(BOOL)dateIsWeekBeforeVacation:(NSDate *)date;

/** Testing if the given vacation demand is valide.
 @param demandToCheck The vacation demand to validate.
 @return Yes if the demandToCheck is valide.
 */
+(BOOL)isValidVacation: (VacationDemand*)demandToCheck;

/**-----------------------------------------------------------------------------------------
 *@name Compare Dates
 *------------------------------------------------------------------------------------------
 */
/** Compares two dates and figures out if they are on the same day.
 @param firstDate The first date to compare.
 @param secondDate The second date to compare.
 @return Yes if the dates are on the equal day.
 */
+(BOOL)areSameDayDate:(NSDate*)firstDate andDate:(NSDate*)secondDate;

/** Compares the date parameter with the date of the last login.
 @param date The date to compare with last login date.
 @return The day difference from date and last login. 0 if date is before last login date. */
+(int)daysSinceLastLogin:(NSDate*)date;

/** Compares the two date parameters and counts dates between both.
 @param firstDate The first date to compare.
 @param secondDate The second date to compare.
 @param includeDates YES if first and second date should be counted, NO if only dates between should be counted.
 @return The day difference from first and second date. 1 if first and second date are the same. */
+(int)daysFromDate:(NSDate*)firstDate toDate:(NSDate*)secondDate includingDates:(BOOL)includeDates;

/**-----------------------------------------------------------------------------------------
 *@name Get formatted Date Information
 *------------------------------------------------------------------------------------------
 */
/** Method to get the full months name from a date.
 @param date The date to get the month from.
 @return The full months name of the date.
 */
+(NSString*)getMonthFromDate: (NSDate*)date;

/** Method to get the full years description from a date.
 @param date The date to get the year from.
 @return The full years description of the date.
 */
+(NSString*)getYearFromDate: (NSDate*)date;

/** Method to get the short description of weekday from a date.
 @param date The date to get the weekday from.
 @return The short weekdays description of the date.
 */
+(NSString*)getShortWeekdayFromDate: (NSDate*)date;

/** Method to get the days number in month from a date.
 @param date The date to get the number from.
 @return The short weekdays number of the date.
 */
+(NSString*)getWeekdayNumberFromDate: (NSDate*)date;

/** The method gets the information of a date by giving a date format.
 @param date The date to get the information from.
 @param format The format the output should be.
 @return The description of the date by the given format.
 */
+(NSString*)getDateInformation:(NSDate*)date withFormat:(NSString*)format;

/**-----------------------------------------------------------------------------------------
 *@name Get Weekend and Holiday Information
 *------------------------------------------------------------------------------------------
 */
/** Checks if a date is a Sunday or Saturday
 @param date The date to check for weekend.
 @return YES, if the date is Sunday or Saturday.
 */
+(BOOL)dateIsWeenkend:(NSDate*)date;

/** Checks if a date is public holiday.
 @param date The date to check for weekend.
 @param locale The locale to check for public holidays.
 @return YES, if the date is public holiday..
 */
+(BOOL)dateIsPublicHoliday:(NSDate*)date forLocale:(NSLocale*)locale;

@end
