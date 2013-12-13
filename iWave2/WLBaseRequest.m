//
//  WLBaseRequest.m
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseRequest.h"
#import "WLAppDelegate.h"

@implementation WLBaseRequest

/**----------------------------------------------------------------
 @name Create a Request
 *------------------------------------------------------------------
 */
/** Creates a request body with the values for the current session.
 @return A base request object.*/
-(id)init{
    
    self = [super init];
    if(self){
        self.token = session.token;
        self.locale = [[NSLocale alloc]initWithLocaleIdentifier:[[[NSBundle mainBundle]preferredLocalizations]objectAtIndex:0]];
    }
    return self;
}

@end
