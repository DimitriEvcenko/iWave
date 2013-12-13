//
//  VacationDemand.m
//  iWave2
//
//  Created by Marco Lorenz on 20.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "VacationDemand.h"
#import "VacationDemandStatus.h"
#import "VacationDemandType.h"


@implementation VacationDemand

@dynamic comment;
@dynamic createdOn;
@dynamic endDate;
@dynamic id;
@dynamic startDate;
@dynamic userDisplayName;
@dynamic userId;
@dynamic demandStatus;
@dynamic demandType;

/**---------------------------------------------------------------------------------------
 * @name Handle the Vacation Demand
 *  ---------------------------------------------------------------------------------------
 */
/** Test if the vacation demand shown on the view controller is complete to be requested.
 Start date, end date and the type of vacation have to be set.
 @return Yes, if the demand is requestable.
 */
-(BOOL)vacationDemandisComplete{
    
    if(!self)
        return NO;
    if(!self.startDate || !self.endDate)
        return NO;
    if(!self.demandType.name)
        return NO;
    return YES;
}

@end
