//
//  WLLoginResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 24.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLBaseResponse.h"

/** On login the server sends parameters that are mapped to an object of this class.
 */
@interface WLLoginResponse : WLBaseResponse

/**----------------------------------------------------------------
 @name Login and Session Information.
 *------------------------------------------------------------------
 */
/** The login name of the logged in user.*/
@property(nonatomic, retain) NSString *loginName;

/** The email address of the logged in user. */
@property(nonatomic, retain) NSString *email;

/** Messages with news content. */
@property (nonatomic, retain) NSSet* newsMsgs;

/** The logged in users displayed name */
@property(nonatomic, retain) NSString *displayName;

/** The users primary key in wave intranet. */
@property(nonatomic, retain) NSNumber *userId;

@end
