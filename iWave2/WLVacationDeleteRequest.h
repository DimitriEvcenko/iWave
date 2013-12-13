//
//  WLVacationDeleteRequest.h
//  iWave2
//
//  Created by Alexander Eiselt on 08.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRequest.h"

/** An instance of this class represents a request, that can be send to wave intranet.
 A vacation delete request is used to  delete a vacation demands from database.
 */
@interface WLVacationDeleteRequest : WLBaseRequest


/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Decision Requests Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The primary key of the vacation demand to delete in wave intranet. */
@property (strong, nonatomic) NSString *vacationId;

/** The status of the deleting vacation demand.
 @see VacationDemandStatus
 */
@property (strong, nonatomic) NSString *vacationStatus;
@end
