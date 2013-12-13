//
//  WLBaseResponse.m
//  iWave2
//
//  Created by Marco Lorenz on 11.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLBaseResponse.h"
#import "WLAppDelegate.h"

@implementation WLBaseResponse

/**----------------------------------------------------------------
 @name Error Handling
 *------------------------------------------------------------------
 */
/** Gives the information if an errors occured in communication.
 @return True, when there are errors in the errMsgs NSSet.
 */
-(BOOL)hasErrors{
    
    if(self.errMsgs == nil || [self.errMsgs count] == 0)
        return NO;
    
    return YES;
}

/** Test if the token in response is equal to session token.
 @return Yes, if the token is equal. */
-(BOOL)hasValidToken{
    
    //until token is used in wave
    //return YES;
    
    //if([self.token isEqualToString:session.token]||!session.token || !self.token)
      //  return YES;
    
    return YES;
}
@end
