//
//  WLVacationDecisionRequest.h
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRequest.h"

/** An instance of this class represents a request, that can be send to wave intranet.
 A vacation decision request is used to  decide on vacation demands.
 */
@interface WLVacationDecisionRequest : WLBaseRequest

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Decision Requests Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The primary key of the vacation demand to decide of in wave intranet. */
@property (strong, nonatomic) NSNumber *vacationId;

/** The decision made is presented in the status.
 @see VacationDemandStatus
 */
@property (strong, nonatomic) NSString *status;

@end
