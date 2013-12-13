//
//  WLUserProfileResponse.h
//  iWave2
//
//  Created by Marco Lorenz on 20.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLBaseResponse.h"

/** On requesting the information about the user, the server send a response that is mapped to an object of this class.*/
@interface WLUserProfileResponse : WLBaseResponse

/**----------------------------------------------------------------
 @name The Users Information
 *------------------------------------------------------------------
 */
/** The users first name. */
@property(nonatomic, retain) NSString *firstName;

/** The users last name.*/
@property(nonatomic, retain) NSString *lastName;

/** The users displayed name. */
@property(nonatomic, retain) NSString *displayName;

/** The users short name*/
@property(nonatomic, retain) NSString *shortName;

/** The users department. */
@property(nonatomic, retain) NSString *department;

/** The users telephone number. */
@property(nonatomic, retain) NSString *phoneNumber;

/** The users email address. */
@property(nonatomic, retain) NSString *email;

/** The users primary key in wave intranet. */
@property(nonatomic, retain) NSNumber *userId;

/**----------------------------------------------------------------
 @name Information about Users Colleagues
 *------------------------------------------------------------------
 */
/** A set of users managers.
 @see Teammate*/
@property(nonatomic, retain) NSSet *manager;

/** A set of users team mates.
 @see Teammate*/
@property(nonatomic, retain) NSSet *teamMates;

/** A set of users direct reports.
 @see Teammate*/
@property(nonatomic, retain) NSSet *directReports;

/** A set of users other reports.
 @see Teammate*/
@property(nonatomic, retain) NSSet *otherUserReports;

@end
