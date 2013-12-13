//
//  WLSession.h
//  iWave2
//
//  Created by Marco Lorenz on 10.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRestCallCompletedProtocol.h"

/** An object of the session contains userdata that is needed for server communication like user ID.
 The data of the logged in user is in here.
 */
@interface WLSession : NSObject

/**---------------------------------------------------------------------------------------
 * @name The logged in User Data
 *  ---------------------------------------------------------------------------------------
 */
/** The logged in users primary key in wave intranet. */
@property (nonatomic) NSNumber *sessionUserId;

/** The bool value says if the logged in user is manager of any other wave user. */
@property BOOL isManager;

/** The diplayed name of the logged in user to address the user. */
@property NSString *displayName;

/** The bool value says if the logged in user has a manager.*/
@property BOOL hasManager;

/** The sessions token. */
@property NSString *token;

/**---------------------------------------------------------------------------------------
 * @name Initialize a Session
 *  ---------------------------------------------------------------------------------------
 */
/** Initializes a session object.
 @return A default session object.
 */
-(id)init;

@end
