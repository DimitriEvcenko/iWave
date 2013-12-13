//
//  WLBaseRequest.h
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Sending a request to the server the properties of this class are always needed.
 So any request class has to inherit from this class.
 */
@interface WLBaseRequest : NSObject

/**----------------------------------------------------------------
 @name Basics of any Request
 *------------------------------------------------------------------
 */
/** The token for the current session. */
@property (strong, nonatomic) NSString *token;

/** The users locale to get correct string information. */
@property (strong, nonatomic) NSLocale *locale;

@end
