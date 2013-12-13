//
//  WLCalendarDayItem.h
//  iWave2
//
//  Created by Marco Lorenz on 29.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacationDemandStatus.h"

/** The class defines the model of a day.
The calendar day item defines the displayed text, images and colors in a calendar. It also contains the date for the day setting the clock to noon.
An Instance of this class can be displayed in the applications calendar view.
*/
@interface WLCalendarDayItem : NSObject

typedef enum{
    noDay = 0,
    normalDay = 1,
    firstVacationDay = 2,
    vacationDay = 3,
    lastVacationDay = 4,
    freeDay = 5,
    dayName = 6,
    singleVacationDay = 7,
}TypeOfDay;

/**--------------------------------------------------------
*@name Handle the Model
*---------------------------------------------------------
*/
/** The displayed text of the day item. 

In the current application the number of the day in month is used.
*/
@property NSString *displayText;

/** Describes the type of the day.

In the class there are defindet the following types:
	
	noDay = day of another month
    normalDay = normal weekday
    firstVacationDay = first day of vacation
    vacationDay = normal vacation day
    lastVacationDay = the last day of a vacation
    freeDay = weekend day or sabbath day
    dayName = is no day but a day description like: Monday, Thuesday...
    singleVacationDay = a single vacation day
	
*/
@property int typeOfDay;

/** The date of the day item
*/
@property NSDate *date;

/**--------------------------------------------------------
*@name Prepare for displaying the Model
*---------------------------------------------------------
*/
/** This property sets the backgroundcolor of the displaying calendar cell.

Every type of vacation has another color that can be displayed in calendar cell.
If the day item is no vacation day no color is displayed.
@see WLCaldendarCell
*/
@property UIColor *vacationColor;

/** Depending to the typeOfDay the methods chosses a display image for calendar cell from the resorces.
@return An image to display in the calendar cell.
@see WLCaldendarCell
*/
-(UIImage *)getImage;

@end
