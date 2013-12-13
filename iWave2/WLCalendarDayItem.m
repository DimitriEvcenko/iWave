//
//  WLCalendarDayItem.m
//  iWave2
//
//  Created by Marco Lorenz on 29.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCalendarDayItem.h"
#import "VacationDemand.h"

@implementation WLCalendarDayItem

@synthesize date;

/**--------------------------------------------------------
 *@name Prepare for displaying the Model
 *---------------------------------------------------------
 */
/** Depending to the typeOfDay the methods chosses a display image for calendar cell from the resorces.
 @return An image to display in the calendar cell.
 @see WLCaldendarCell
 */
-(UIImage *)getImage{
    
    switch (self.typeOfDay) {
        case noDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"anderer-monatUC" ofType:@"gif"]];
        case normalDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tag-normal" ofType:@"gif"]];
        case singleVacationDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"urlaub_einzeltag" ofType:@"gif"]];
        case firstVacationDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"tag1-urlaub" ofType:@"gif"]];
        case vacationDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"urlaubstag" ofType:@"gif"]];
        case lastVacationDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"urlaub-ende" ofType:@"gif"]];
        case freeDay:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"wochenendeUC" ofType:@"gif"]];
        default:
            return [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"wochentagUC" ofType:@"gif"]];
    }
    
}

@end
