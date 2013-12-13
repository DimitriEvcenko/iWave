//
//  WLBaseRest.h
//  iWave2
//
//  Created by Marco Lorenz on 11.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLRestCallCompletedProtocol.h"

/** The class is implementing the rest calls and responds for the applications base functions.

To handle rest calls the RestKit framework is used. 
The basic functions are:

	- doing login
	- getting user profile information
	
This class contents some private methods to manage NewsMessages, User and the WLRestCallCompletedProtocol.
*/
@interface WLBaseRest : NSObject <WLRestServiceProtocol>


/**---------------------------------------------------------------------------------------
 * @name Delegate to Parent
 *  ---------------------------------------------------------------------------------------
 */
/** The property to delegate rest results to the calling view controller.
*/
@property (nonatomic, weak) id<WLRestServiceProtocol> delegate;

/**---------------------------------------------------------------------------------------
 * @name Calling Rest-Service
 *  ---------------------------------------------------------------------------------------
 */
/** Doing a rest call to manage the login communication.
 
 On Login user profile request and user vacation information request are executed too.
@param postParameters Is a NSDictionary that contents login parameters.
*/
-(void)doLoginWithParameters: (NSDictionary*)postParameters;
- (void)saveOrUpdateUserFromUrl;

@end
