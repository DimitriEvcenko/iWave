//
//  WLVacationDemandResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 13.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLBaseResponse.h"

/** An instance of this class represents a response, that is sent from wave intranet.
 A vacation demand response is used to get hte vacation demands primary key in wave intranet.
 */
@interface WLVacationDemandResponse : WLBaseResponse

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Demand Response Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The requested vacation demands primary key in wave intranet. */
@property (strong, nonatomic) NSNumber *vacationId;

@end
