//
//  WLVacationDemandRequest.m
//  iWave2
//
//  Created by Marco Lorenz on 21.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationDemandRequest.h"

@implementation WLVacationDemandRequest


/**---------------------------------------------------------------------------------------
 * @name Creating a Vacation Demand Request Object
 *  ---------------------------------------------------------------------------------------
 */
/** This method mapps a vacation demand to a vacation demand request
 @param demand The vacation demand that will be mapped.
 @return The vacation request created by the vacation demand
 */
+(WLVacationDemandRequest*)initWithVacationDemand:(VacationDemand *)demand {
 
    WLVacationDemandRequest *request = [[WLVacationDemandRequest alloc]init];
    
    if(request){
        request.userId = demand.userId;
        request.startDate = demand.startDate;
        request.endDate = demand.endDate;
        request.comment = demand.comment;
        request.demandType = demand.demandType;
        request.vacationId = demand.id;
    }
    
    return request;
}
@end
