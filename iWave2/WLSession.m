//
//  WLSession.m
//  iWave2
//
//  Created by Marco Lorenz on 10.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSession.h"

@implementation WLSession

/**---------------------------------------------------------------------------------------
 * @name Initialize a Session
 *  ---------------------------------------------------------------------------------------
 */
/** Initializes a session object.
 @return A default session object.
 */
-(id)init{
    
    self = [super init];
    if (self) {
        self.sessionUserId = nil;
        self.isManager = NO;
        self.displayName = nil;
        self.hasManager = YES;
        self.token = @"";
    }
    return self;
    
}

@end
