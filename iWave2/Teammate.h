//
//  Teammate.h
//  iWave2
//
//  Created by Marco Lorenz on 15.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** This class handles the logged in users relationship to other colleagues.
 
 This class is persisted in core data during a session but is deleted on logout or determination of the application. 
 The Teammates are sent from wave intranet in WLUserProfileResponse after login action.
 */
@interface Teammate : NSManagedObject
/**---------------------------------------------------------------------------------------
 * @name Administrate Teammates.
 *  ---------------------------------------------------------------------------------------
 */
/** The displayed name of the colleague. 

	The propery is used to show the users teamstructure.
	
		displayName = fristName + " " + lastName;

*/
@property (nonatomic, retain) NSString * displayName;

/** The primary key of Teammate in wave intranet.
*/
@property (nonatomic, retain) NSNumber * waveUserId;

/** The number describes the type of relationship to the user.

	The usable numers are listed in the enummeration UserRelationships with the values:
		
    - MANAGER describes the teamate as manager of the user.
    - TEAMMATE the teammate is in the same team.
    - DIRECTREPORT the teammate is a direct report of the user.
    - OTHERUSERREPORT the teammate is a report of the user, but not a direct one.
		
*/
@property (nonatomic, retain) NSNumber * relationToUser;

/** The Enummeration to describe relationships of logged in user an Teammate.
*/
typedef enum {
    MANAGER = 0,
    TEAMMATE = 1,
    DIRECTREPORT = 2,
    OTHERUSERREPORT = 3,
} UserRelationships;
@end
