//
//  WLCalendarOperations.m
//  iWave2
//
//  Created by Marco Lorenz on 30.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCalendarOperations.h"
#import "VacationDemand.h"
#import "WLAppDelegate.h"
#import "User.h"
#import "VacationDemandStatus.h"

@implementation WLCalendarOperations

/**-----------------------------------------------------------------------------------------
 *@name Vacation on Date
 *------------------------------------------------------------------------------------------
 */
/** Testing if the given vacation demand is valide.
 @param demandToCheck The vacation demand to validate.
 @return Yes if the demandToCheck is valide.
 */
+(BOOL)isValidVacation: (VacationDemand*)demandToCheck
{
    if([self dateIsWeenkend:demandToCheck.startDate] || [self dateIsWeenkend:demandToCheck.endDate])
    {
        NSLog(@"weekend detected");
        return NO;
    }
    NSArray *exceptionIDs = [NSArray arrayWithObject:demandToCheck.id];
    
    if([self isVacationDay:demandToCheck.startDate exeptIDs:exceptionIDs] || [self isVacationDay:demandToCheck.endDate exeptIDs:exceptionIDs])
    {
        NSLog(@"start or enddate is in vacation");
        return NO;
    }
    NSArray *demands = [VacationDemand MR_findByAttribute:USERID withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([exceptionIDs containsObject:demand.id])
            continue;
        
        if([demandToCheck.startDate compare:demand.startDate] == NSOrderedAscending && [demandToCheck.endDate compare:demand.endDate] == NSOrderedDescending)
        {
            NSLog(@"vacation is between other vacation");
            return NO;
        }
    }
    return YES;
}

/** Testing if the given date is during users vacation.
 @warning Dont use this method with a date from a new vacation demand. The return value alway will be YES.
 @param date The date to test for vacation.
 @return Yes if the date is a vacation day.
 */
+(BOOL)isVacationDay: (NSDate*)date{
    NSArray *demands = [VacationDemand MR_findByAttribute:USERID withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([self vacationIsDisplayableInCalendar:demand])
        {
            if([self areSameDayDate:date andDate:demand.startDate]||[self areSameDayDate:date andDate:demand.endDate])
                return YES;
            if([date compare:demand.startDate]==NSOrderedDescending && [date compare:demand.endDate]==NSOrderedAscending)
                return YES;
        }
    }
    return NO;
}

/** Testing if the given date is during users vacation.
 @param date The date to test for vacation.
 @param idArray An array of vacation ids not to compare wiht the date.
 @return Yes if the date is a vacation day.
 */
+(BOOL)isVacationDay: (NSDate*)date exeptIDs:(NSArray *)idArray{
    NSArray *demands = [VacationDemand MR_findByAttribute:USERID withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([idArray containsObject:demand.id])
            continue;
        
        if([self vacationIsDisplayableInCalendar:demand])
        {
            if([self areSameDayDate:date andDate:demand.startDate]||[self areSameDayDate:date andDate:demand.endDate])
                return YES;
            if([date compare:demand.startDate]==NSOrderedDescending && [date compare:demand.endDate]==NSOrderedAscending)
                return YES;
        }
    }
    return NO;
}


/** Test if the vacation demand should be shown in the iWave calendar depending on the status.
 @param demand The vacation demand to test.
 @return YES, if the vacation demand should be shown in calendar. 
 */
+(BOOL)vacationIsDisplayableInCalendar:(VacationDemand*)demand{
    
    if([demand.demandStatus.name isEqualToString: VS_REJECTED]||[demand.demandStatus.name isEqualToString: VS_TEAM]||[demand.demandStatus.name isEqualToString: VS_TEAM_INDIRECT])
        return NO;
    
    return YES;
}

/** Testing if the given date is the users first vacation day.
 @param date The date to test for first vacation day.
 @return Yes if the date is the first vacation day.
 */
+(BOOL)isFirstVacationDay:(NSDate*)date{
    NSArray *demands = [VacationDemand MR_findByAttribute:@"userId" withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([self vacationIsDisplayableInCalendar:demand])
        {
            if([self areSameDayDate:date andDate:demand.startDate])
            return YES;
        }
    }
    return NO;
}

/** Testing if the given date is the users last vacation day.
 @param date The date to test for last vacation day.
 @return Yes if the date is the last vacation day.
 */
+(BOOL)isLastVacationDay:(NSDate*)date{
    NSArray *demands = [VacationDemand MR_findByAttribute:@"userId" withValue:session.sessionUserId];
    
    for (VacationDemand *demand in demands) {
        
        if([self vacationIsDisplayableInCalendar:demand])
        {
            if([self areSameDayDate:date andDate:demand.endDate])
            return YES;
        }
    }
    return NO;
}

/** Testing if the given date a single vacation day.
 @param date The date to test for single vacation day.
 @return Yes if the date is a single vacation day.
 */
+(BOOL)isSingleVacationDay:(NSDate*)date{
    
    if([self isFirstVacationDay:date]&&[self isLastVacationDay:date])
        return YES;
    
    return NO;    
}

/** This mehtod checks if the last vacation day of the user was wihtin the week before the date parameter.
 @param date The date to look for last vacation.
 @return Yes, if the last vacation day is within one week before the date parameter.
 */
+(BOOL)dateIsWeekAfterVacation:(NSDate *)date{
    
    NSTimeInterval weekIntervall = 60*60*24*7;
    NSTimeInterval today = date.timeIntervalSince1970;
    NSTimeInterval lastVacartionEnd = [self getLastVacationEnd];
    
    if((today - lastVacartionEnd) < weekIntervall)
        return YES;
    
    return NO;
}

/** This mehtod checks if the next vacation day of the user is wihtin the week after the date parameter.
 @param date The date to look for next vacation.
 @return Yes, if the nextt vacation day is within one week after the date parameter.
 */
+(BOOL)dateIsWeekBeforeVacation:(NSDate *)date{
    
    NSTimeInterval weekIntervall = 60*60*24*7;
    NSTimeInterval today = date.timeIntervalSince1970;
    NSTimeInterval nextVacationStart = [self getNextVacationStart];
    
    if(nextVacationStart == 0)
        return NO;
    
    if((nextVacationStart - today) < weekIntervall)
        return YES;
    
    return NO;
}

/** This methods searches for the last vacation day user had.
 @return The time intervall of the last vacation day since 1970.
 */
+(NSTimeInterval)getLastVacationEnd{
    NSArray *demands = [VacationDemand MR_findByAttribute:@"demandStatus.name" withValue:VS_APPROVED];
    VacationDemand *returnValue;
    NSDate *today = [[NSDate alloc]init];
    
    for(VacationDemand *demand in demands){
        
        if(demand.endDate.timeIntervalSince1970 > today.timeIntervalSince1970)
            continue;
        
        if(!returnValue)
            returnValue = demand;
        else{
            if(demand.endDate.timeIntervalSince1970 > returnValue.endDate.timeIntervalSince1970)
                returnValue = demand;
        }
    }
    
    if(returnValue)
        return returnValue.endDate.timeIntervalSince1970;
    else
        return 0;
}

/** This methods searches for the next vacation day user has.
 @return The time intervall of the next vacation day since 1970.
 */
+(NSTimeInterval)getNextVacationStart{
    
    NSArray *demands = [VacationDemand MR_findByAttribute:@"demandStatus.name" withValue:VS_APPROVED];
    VacationDemand *returnValue;
    NSDate *today = [[NSDate alloc]init];
    
    for(VacationDemand *demand in demands){
        
        if(demand.startDate.timeIntervalSince1970 < today.timeIntervalSince1970)
            continue;
        
        if(!returnValue)
            returnValue = demand;
        else{
            if(demand.startDate.timeIntervalSince1970 < returnValue.startDate.timeIntervalSince1970)
                returnValue = demand;
        }
    }
    
    if(returnValue)
        return returnValue.startDate.timeIntervalSince1970;
    else
        return 0;
}


/**-----------------------------------------------------------------------------------------
 *@name Compare Dates
 *------------------------------------------------------------------------------------------
 */
/** Compares two dates and figures out if they are on the same day.
 @param firstDate The first date to compare.
 @param secondDate The second date to compare.
 @return Yes if the dates are on the equal day.
 */
+(BOOL)areSameDayDate:(NSDate*)firstDate andDate:(NSDate*)secondDate{
    NSDateComponents *comp1 = [[NSCalendar currentCalendar] components:NSUIntegerMax fromDate:firstDate];
    NSDateComponents *comp2 = [[NSCalendar currentCalendar] components:NSUIntegerMax fromDate:secondDate];
    
    if(comp1.day == comp2.day && comp1.month == comp2.month && comp1.year == comp2.year)
        return YES;
    
    return NO;
}

/** Compares the date parameter with the date of the last login. And returns the difference in complete days.
 @param date The date to compare with last login date.
 @return The day difference from date and last login. 0 if date is before last login date. */
+(int)daysSinceLastLogin:(NSDate*)date{
    
    User *user = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
    
    if(!user.lastLogin)
        return 0;
    
    NSTimeInterval difference = date.timeIntervalSince1970 - user.lastLogin.timeIntervalSince1970;
    
    return difference / (24*60*60);
}

/** Compares the two date parameters and counts dates between both.
 @param firstDate The first date to compare.
 @param secondDate The second date to compare.
 @param includeDates YES if first and second date should be counted, NO if only dates between should be counted.
 @return The day difference from first and second date. 1 if first and second date are the same. */
+(int)daysFromDate:(NSDate*)firstDate toDate:(NSDate*)secondDate includingDates:(BOOL)includeDates{
    
    if([self areSameDayDate:firstDate andDate:secondDate])
        return 1;
    
    NSTimeInterval difference = firstDate.timeIntervalSince1970 - secondDate.timeIntervalSince1970;

    
    difference = abs(difference);
    
    int days = (int)round(difference/(24*60*60));
    
    if(includeDates)
        days++;
    
    return days;
}


/**-----------------------------------------------------------------------------------------
 *@name Get formatted Date Information
 *------------------------------------------------------------------------------------------
 */
/** Method to get the full months name from a date.
 @param date The date to get the month from.
 @return The full months name of the date.
 */
+(NSString*)getMonthFromDate: (NSDate*)date{
    
    return [self getDateInformation:date withFormat:@"MMMM"];
}

/** Method to get the full years description from a date.
 @param date The date to get the year from.
 @return The full years description of the date.
 */
+(NSString*)getYearFromDate: (NSDate*)date{
    
    return [self getDateInformation:date withFormat:@"yyyy"];
}

/** Method to get the short description of weekday from a date.
 @param date The date to get the weekday from.
 @return The short weekdays description of the date.
 */
+(NSString*)getShortWeekdayFromDate: (NSDate*)date{
    return [self getDateInformation:date withFormat:@"EE"];
}

/** Method to get the days number in month from a date.
 @param date The date to get the number from.
 @return The short weekdays number of the date.
 */
+(NSString*)getWeekdayNumberFromDate: (NSDate*)date{
    return [self getDateInformation:date withFormat:@"dd"];
}

/** The method gets the information of a date by giving a date format.
 @param date The date to get the information from.
 @param format The format the output should be.
 @return The description of the date by the given format.
 */
+(NSString*)getDateInformation:(NSDate*)date withFormat:(NSString*)format{
    NSLocale *appLocale = [[NSLocale alloc]initWithLocaleIdentifier:[[[NSBundle mainBundle]preferredLocalizations]objectAtIndex:0]];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setLocale:appLocale];
    [df setDateFormat:format];
    return [df stringFromDate:date];
}

/**-----------------------------------------------------------------------------------------
 *@name Get Weekend and Holiday Information
 *------------------------------------------------------------------------------------------
 */
/** Checks if a date is a Sunday or Saturday
 @param date The date to check for weekend.
 @return YES, if the date is Sunday or Saturday.
 */
+(BOOL)dateIsWeenkend:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger dayOfWeek = [weekdayComponents weekday];
    
    if(dayOfWeek == 1 || dayOfWeek == 7)
        return YES;
    
    return NO;
}

/** Checks if a date is public holiday.
 @param date The date to check for weekend.
 @return YES, if the date is public holiday..
 */
+(BOOL)dateIsPublicHoliday:(NSDate *)date forLocale:(NSLocale *)locale{
    int year = [[self getYearFromDate:date] intValue];
    NSArray *publicHolidaysForLocaleAndYear = [self getPublicHolidayForLocale:locale andYear:year];
    
    for(NSDate *publicHoliday in publicHolidaysForLocaleAndYear){
        if([self areSameDayDate:publicHoliday andDate:date])
            return YES;
        
    }
    return NO;
}

/** Returns all public holidays for year and locale in an array.
 @warning Only german/ baden wuertemberg public holidays are returned yet.
 @param locale The locale the public holidays existing.
 @param year The year searched for holiday.
 @return An array contaioning all public holiday dates for locale and year.
 */
+(NSArray*)getPublicHolidayForLocale:(NSLocale*)locale andYear:(int)year{
    NSMutableSet *publicHolidaysForLocaleAndYear = [[NSMutableSet alloc]init];
    int easterSunday = [self getEasterSundayMarchDayForYear:year];
    
    //newyear day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:1 andDay:1]];
    
    //twelfth day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:1 andDay:6]];
    
    //good friday
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday-2]];
    
    //easyter sunday
    [publicHolidaysForLocaleAndYear addObject:[self getEasterSunday:year]];
    
    //easter monday
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday+1]];
    
    //may day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:5 andDay:1]];
    
    //ascension day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday +39]];
    
    //whit sunday
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday +49]];
    
    //whit monday
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday +50]];
    
    //corpus christi
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:3 andDay:easterSunday +60]];
    
    //assumtion day
    //[publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:8 andDay:15]];
    
    //german unification day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:10 andDay:3]];
    
    //reformation day
    //[publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:10 andDay:10]];
    
    //all saints
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:11 andDay:1]];
    
    //christmas day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:12 andDay:25]];
    
    //boxing day
    [publicHolidaysForLocaleAndYear addObject:[self dayWithYear:year andMonth:12 andDay:26]];
    
    return [publicHolidaysForLocaleAndYear allObjects] ;
}

/** Get the easter sunday date for the given year.
 @param year The year the easter day should be found.
 @return The date of easter sunday in year.
 */
+(NSDate*)getEasterSunday:(int)year{

    int easterSundayMarchDate = [self getEasterSundayMarchDayForYear:year];
    
    NSDate *result = [self dayWithYear:year andMonth:3 andDay:easterSundayMarchDate];
    
    return result;
}

/** Doing the Gauß-easter-formular to get the march day of easter sunday for the given year.
 Day 32 is first of april.
 @param year The year the easter day should be found.
 @return The day of easter sunday in year after 1st march.
 */
+(int)getEasterSundayMarchDayForYear:(int)year{
    
    int secularNumber = year/100;
    int secularMoonSwitch = 15 +(3*secularNumber+3)/4 -(8*secularNumber+13)/25;
    int secularSunSwitch = 2-(3*secularNumber+3)/4;
    int moonParameter = year%19;
    int seedOfFirstFullMoon = (19*moonParameter +secularMoonSwitch)%30;
    int calendricalCorrectionParameter = (seedOfFirstFullMoon + moonParameter/11)/29;
    int easterLimit = 21 + seedOfFirstFullMoon - calendricalCorrectionParameter;
    int firstSundayInMarch = 7 - (year+year/4 +secularSunSwitch)%7;
    int distanceOfEasterSunday = 7 -(easterLimit -firstSundayInMarch)%7;
    int easterSundayMarchDate = easterLimit + distanceOfEasterSunday;
    
    return easterSundayMarchDate;
}


/** Creates a date by parameters day, month and year.
 @param year The year the date is set.
 @param month The month the date is set. Months larger than 12 switch to next year.
 @param day The day in selected month. Values larger than last day of month change to next month.
 @return A date from the three parameters.
 */
+(NSDate*)dayWithYear:(int)year andMonth:(int)month andDay:(int)day{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    
    return [calendar dateFromComponents:components];
}



@end
