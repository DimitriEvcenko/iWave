//
//  WLRestCallCompletedProtocol.h
//  iWave2
//
//  Created by Marco Lorenz on 10.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** IWave appllicaion uses some different rest calls for communication with wave intranet.
 Rest kits rest calls are done asynchonus. The reslt call completed protocol is made to send messages when a rest call did finish and to delegate logic on finishing rest calls. */
@protocol WLRestServiceProtocol <NSObject>

/** ---------------------------------------------------------------
 * @name Finishing Rest Calls
 *-----------------------------------------------------------------
 */
/** Should be called when a rest call finished with any error.
 @param restService The rest service object caused the error.
 @param errorMessage The error message from rest call.
 @param description The rest calls description.
 */
-(void)restService:(id)restService didFinishRestCallWithErrors:(NSString*)errorMessage andDescription: (NSString*)description;

/** Should be called when any rest call finished successfull.
 @param restService The rest service object that has finished rest call.
 @param response The response from the server.
 @param description The rest calls description.
 */
-(void)restService:(id)restService didFinishRestCallWithResponse: (id)response andDescription: (NSString*)description;

/** ---------------------------------------------------------------
 * @name Delegate Rest Calls
 *-----------------------------------------------------------------
 */
@optional
/** Delegating a rest call to responder to avoid abortion on closing popover views.
 @param restService The rest service object that should do the rest call.
 @param postParameter The parameter to post in the rest call.
 @param description The rest calls description.
 @param selector The selector that should be executed to do rest call.
 */
-(void)restService:(id)restService doRestCallWithParameters:(NSDictionary*)postParameter andDescription: (NSString*)description andSelector:(SEL)selector;
@end
