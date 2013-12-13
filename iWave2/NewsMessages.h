//
//  NewsMessages.h
//  iWave2
//
//  Created by Marco Lorenz on 27.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** This class handles the persistance of NewsMessages send by wave intranet.
 
NewsMessages are only sent on login by wave intranet. They are part of WLLoginResponse.
This class is to persist the messages.
@warning Tere is no primary key. IWave uses the msgText to distinguish the messages.
 */
@interface NewsMessages : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name Persis the Messages
 *  ---------------------------------------------------------------------------------------
 */
 /** Is a bool value to mark if the user has already opened the message on iPad.
 
@warning *Warning:* There is no synchronisation to wave intranet. News are not persisted in wave, but sent.
 */
@property (nonatomic, retain) NSNumber * alreadyRead;

/** Is the content of the message.
 */
@property (nonatomic, retain) NSString * msgText;

/** This is the receive date of the message.
 
This value is set during the login action in WLBaseRest
 */
@property (nonatomic, retain) NSDate * receivedDate;

/** This is the key to allocate the message to the user.

*/
@property (nonatomic, retain) NSNumber * userId;

@end
