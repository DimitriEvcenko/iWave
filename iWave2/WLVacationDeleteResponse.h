//
//  WLVacationDeleteResponse.h
//  iWave2
//
//  Created by Alexander Eiselt on 08.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseResponse.h"

/** An instance of this class represents a response, that is sent from wave intranet.
 A vacation delete response is used to tell if vacation demand is removed successull from data base of wave intranet.
 */
@interface WLVacationDeleteResponse : WLBaseResponse

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Decision Response Properties
 *  ---------------------------------------------------------------------------------------
 */
/** A bool value to tell, if the vacation demand has been removed or not. */
@property BOOL  isVacationDeleted;

@end
