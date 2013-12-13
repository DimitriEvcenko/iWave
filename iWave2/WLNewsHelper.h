//
//  WLNewsHelper.h
//  iWave2
//
//  Created by Marco Lorenz on 22.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class helps to get information about all the news messages. */
@interface WLNewsHelper : NSObject

/**-------------------------------------------------------------
 * @name Counting News
 *--------------------------------------------------------------
 */
/** This Methds counts all news for the logged in user that have not been opened yet.
 @return The int value of unread messages.
 */
+(int)getUreadNews;

/** This method counts all news messages for the logged in user.
 @return The int value of users news messages.
 */
+(int)getAllNews;

@end
