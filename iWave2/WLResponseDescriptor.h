//
//  WLResponseDescriptor.h
//  iWave2
//
//  Created by Marco Lorenz on 20.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The response descriptor class is used to map server responses to rest kit frameworks mapping result.
 The complete explanation of the response descriptor princip can be found in RKRestKit - documentation. */
@interface WLResponseDescriptor : NSObject

/** ---------------------------------------------------------------
 * @name Creating Response Descriptors
 *-----------------------------------------------------------------
 */
/** The methods creates an array of all needed response descriptors for iWave application.
 The respoinse descriptor contains the used mapping method and the triggering url-request.
 @return An array containing all needed response descriptors.
 @see WLMappingHelper
 */
+(NSArray*)responseDescritorsAsArray;


@end
