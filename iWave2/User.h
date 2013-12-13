//
//  User.h
//  iWave2
//
//  Created by Marco Lorenz on 05.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** This class handles the logged in users data.
 
 This class is persisted in core data. Every user doing a login is saved to persitance store.
 */
@interface User : NSManagedObject
/**---------------------------------------------------------------------------------------
 * @name Persist the Users date
 *  ---------------------------------------------------------------------------------------
 */
 /** Is the date of last login to iWave.
 
 @warning *Warning:* Last login date in wave cann not be used. It is updated before sending WLLoginResponse.
 */
@property (nonatomic, retain) NSDate * lastLogin;

/** Is the name of users department.
  */
@property (nonatomic, retain) NSString * department;

/** The users short name in sidion company.
Normaly the short name is combined out of the first letter of first name
an the first two letters of last name.

		"Max Mustermann" = "MMU"

*/
@property (nonatomic, retain) NSString * shortName;

/** The users email address.
*/
@property (nonatomic, retain) NSString * email;

/** The users first name.
*/
@property (nonatomic, retain) NSString * firstName;

/** The users last name.
*/
@property (nonatomic, retain) NSString * lastName;

/** The users login name in cas.
*/
@property (nonatomic, retain) NSString * loginName;

/** The users login password in cas.
*/
@property (nonatomic, retain) NSString * loginPassword;

/** The users wave primary key.
*/
@property (nonatomic, retain) NSNumber * userId;

/** The users telephone number.
*/
@property (nonatomic, retain) NSString * telephoneNumber;

@end
