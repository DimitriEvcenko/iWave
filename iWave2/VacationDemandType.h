//
//  VacationDemandType.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


NSString *const HOLYDAY;
NSString *const PARENTALLEAVE;
NSString *const SEMINR;
NSString *const FLEXITIME;
NSString *const SABBATICAL;

/** This class handles the vacation demands type.
 
There are five different types defined in the following constants:

	HOLYDAY = "holiday"
	PARENTALLEAVE= "parentalLeave"
	SEMINR= "semiNr"
	FLEXITIME= "flexiTime"
	SABBATICAL= "sabbatical"

@see VacationDemand
 */
@interface VacationDemandType : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name The Vacation Demand Type
 *  ---------------------------------------------------------------------------------------
 */
/** The description of the demand type.
*/
@property (nonatomic, retain) NSString * name;

@end
