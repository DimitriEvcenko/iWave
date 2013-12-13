//
//  WLBaseResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 11.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The base class for communcation packges between the application an wave intranet.

The class is equal to the counterpart in wave intranet. The base class contains several message lists.
*/
@interface WLBaseResponse : NSObject

/**----------------------------------------------------------------
@name Communication Messages.
*------------------------------------------------------------------
*/

/** Messages with informative content.
*/
@property (nonatomic, retain) NSSet* infoMsgs;

/** Messages with warnings.
*/
@property (nonatomic, retain) NSSet* warningMsgs;

/** The token for the session. */
@property(nonatomic, retain) NSString *token;

/**----------------------------------------------------------------
@name Error Handling
*------------------------------------------------------------------
*/
/** Messages with error content.
 */
@property (nonatomic, retain) NSSet* errMsgs;

/** Gives the information if an errors occured in communication.
@return True, when there are errors in the errMsgs NSSet.
*/
-(BOOL)hasErrors;

/** Test if the token in response is equal to session token.
 @return Yes, if the token is equal. */
-(BOOL)hasValidToken;
@end
