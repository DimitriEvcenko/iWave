//
//  WLVacationDecisionResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseResponse.h"

/** An instance of this class represents a response, that is sent from wave intranet.
 A vacation decision response is used to tell if a decision about a vacation demand is saved in data base of wave intranet.
 */
@interface WLVacationDecisionResponse : WLBaseResponse

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Decision Response Properties
 *  ---------------------------------------------------------------------------------------
 */
/** A bool value to tell, if the decision is saved or not. */
@property (nonatomic) BOOL decisionMade;

@end
