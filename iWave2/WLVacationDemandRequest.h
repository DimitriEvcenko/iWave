//
//  WLVacationDemandRequest.h
//  iWave2
//
//  Created by Marco Lorenz on 21.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacationDemandType.h"
#import "VacationDemand.h"
#import "WLBaseRequest.h"

/** An instance of this class represents a request, that can be send to wave intranet.
 A vacation demand request is used to  demand for vacation.
 */
@interface WLVacationDemandRequest : WLBaseRequest

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Demand Requests Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The primary key for the user to request the vacation. */
@property NSNumber *userId;

/** The start date of the vacation demand request. */
@property NSDate *startDate;

/** The end date of the vacation demand request. */
@property NSDate *endDate;

/** Any comment that can be made in addition to the demand request*/
@property NSString *comment;

/** The vacation demand type of the request. */
@property VacationDemandType *demandType;

/** The vacations primary key in wave intranet if existing. */
@property NSNumber *vacationId;

/**---------------------------------------------------------------------------------------
 * @name Creating a Vacation Demand Request Object
 *  ---------------------------------------------------------------------------------------
 */
/** This method mapps a vacation demand to a vacation demand request 
 @param demand The vacation demand that will be mapped.
 @return The vacation request created by the vacation demand
 */
+(WLVacationDemandRequest*)initWithVacationDemand:(VacationDemand*)demand;

@end
