//
//  WLVacationDemandProtocol.h
//  iWave2
//
//  Created by Marco Lorenz on 03.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacationDemand.h"

/** This protocol defines the methods that are used on creating or editing vacation demands. 
 In calendar view and vacation detail view modal popover views are used. To delegate changes to the parent views
 this protocol is created.*/
@protocol WLVacationDemandProtocol <NSObject>

/**--------------------------------------------------------
 * @name Do Changes on Vacation Demands
 *---------------------------------------------------------
 */
@optional
/** This mehtod should be called, when the demand type of the vacation demand has been changed.
 @param demandType The demand type after changing
 */
-(void)didChangeVacationDemandType: (NSString*)demandType;

/** This mehtod should be called, when the start date of the vacation demand has been changed.
 @param startDate The start date after changing.
 */
-(void)didChangeVacationDemandStartDate: (NSDate*)startDate;

/** This mehtod should be called, when the end date of the vacation demand has been changed.
 @param endDate The end date after changing.
 */
-(void)didChangeVacationDemandEndDate: (NSDate*)endDate;

/** This mehtod should be called, when the popover view is closed.
 @param demand The vacation demand edited by popover view. */
-(void)didCloseEditView: (VacationDemand*)demand;

@end
