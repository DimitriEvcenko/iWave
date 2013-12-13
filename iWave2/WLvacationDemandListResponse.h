//
//  WLvacationDemandListResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 25.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VacationDemand.h"
#import "WLBaseResponse.h"

/** An instance of this class represents a response sent by wave intranet.
 A vacation demand list response contains a set of vacation demand list items.
 */
@interface WLVacationDemandListResponse : WLBaseResponse

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Demand List Response Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The set  containing the vacation demand list items.
 @see WLVacationDemandListItem 
 */
@property (strong, nonatomic) NSSet *vacationDemands;



@end
