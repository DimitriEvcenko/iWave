//
//  WLNewsHelper.m
//  iWave2
//
//  Created by Marco Lorenz on 22.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLNewsHelper.h"
#import "NewsMessages.h"
#import "WLAppDelegate.h"
#import "WLSession.h"

@implementation WLNewsHelper

/** This Methds counts all news for the logged in user that have not been opened yet.
 @return The int value of unread messages.
 */
+(int)getUreadNews{
    
    NSArray *messages = [NewsMessages MR_findByAttribute:USERID withValue:session.sessionUserId];
    int value = 0;
    
    for(NewsMessages *msg in messages){
            if(!msg.alreadyRead)
                value++;
        
    }
    return  value;
}

/** This method counts all news messages for the logged in user.
 @return The int value of users news messages.
 */
+(int)getAllNews{
    NSArray *messages = [NewsMessages MR_findByAttribute:USERID withValue:session.sessionUserId];
    int value = [messages count];
    return  value;
}

@end
