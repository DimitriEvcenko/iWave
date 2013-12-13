//
//  WLUserProfileRequest.h
//  iWave2
//
//  Created by Marco Lorenz on 13.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRequest.h"

/** Sending a request to the server if user specified information is needed.
 */
@interface WLUserProfileRequest : WLBaseRequest

/**----------------------------------------------------------------
 @name Request User Information
 *------------------------------------------------------------------
 */
/** The userId for the current session. */
@property (nonatomic, strong) NSNumber *userId;

@end
