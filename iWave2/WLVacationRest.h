//
//  WLVacationRest.h
//  iWave2
//
//  Created by Marco Lorenz on 12.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRestCallCompletedProtocol.h"

/** This class handles communication with wave intranet server.
 The interface that is used are REST-Services with RestKit-Framework.
 The class only handles communication in vacation context.
 */
@interface WLVacationRest : NSObject


/**---------------------------------------------------------------------------------------
 * @name Delegate Rest Events
 *  ---------------------------------------------------------------------------------------
 */
/** The delegat to delegate events in rest call
 @see WLRestServiceProtocol
 */
@property (nonatomic, weak) id<WLRestServiceProtocol> delegate;


/**---------------------------------------------------------------------------------------
 * @name Communication with the Server
 *  ---------------------------------------------------------------------------------------
 */
/**
 Sending a single VacationDemand to the Server getting a Response
 @param postParameters is a Dictionary from a VacationDemandRequest
 @see WLVacationDemandRequest
 */
-(void)sendVacationDemandRequest:(NSDictionary *)postParameters;

/** Get all the information about users vacation.
 
 A Manager also gets the information about pending vacation of theire reports.
 @param postParameters A user profile request.
 */
-(void)postUserVacationInformation:(NSDictionary*)postParameters;

/** Sending reports vacation decision as request to server.
 @param postParameters An vacation decision request.
 @see WLVacationDecisionRequest
 */
-(void)sendVacationDecisionRequest:(NSDictionary*)postParameters;

/** Sending vacation delete request to server.
 @param postParameters An vacation delete request.
 @see WLVacationDeleteRequest
 */
-(void)sendVacationDeleteRequest:(NSDictionary*)postParameters;


@end
