//
//  VacationDemandStatus.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NSString *const PENDING;
NSString *const REJECTED;
NSString *const APPROVED;
NSString *const NOTSEND;

/** This class handles the vacation demands processing stage.
 
There are four different processing stages defined in the following constants:

	PENDING = "pending"
	REJECTED = "rejected"
	APPROVED = "approved"
	NOTSEND = "notsend"

@see VacationDemand
 */
@interface VacationDemandStatus : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name The Vacation Demand Processing Stage
 *  ---------------------------------------------------------------------------------------
 */
/** The description of the demand status.
*/
@property (nonatomic, retain) NSString * name;

@end
