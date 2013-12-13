//
//  VacationDemandLocal.h
//  iWave2
//
//  Created by Marco Lorenz on 28.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VacationDemandStatus, VacationDemandType;

/** This class handles the local vacation demands in core data.
 
Local vacation demands are stored as long as the demandStatus ist "unrequested".
This is necessary to seperate local persisted vacation demands from the session vacation demands.
Furthermore the class is identical to VacationDemand.
@warning This class is only used to store data, to display vacation demands VacationDemand is used.
@see VacationDemand
 */
@interface VacationDemandLocal : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name Administrate an persist Vacation Demands
 *  ---------------------------------------------------------------------------------------
 */
/** The demand owners comment.
*/
@property (nonatomic, retain) NSString * comment;

/** The end date of the demanded vacation.
*/
@property (nonatomic, retain) NSDate * createdOn;

/** The end date of the demanded vacation.
*/
@property (nonatomic, retain) NSDate * endDate;

/** The demands primary key in wave database.

@warning *Warning:* On creating a new demand id must not be set.
*/
@property (nonatomic, retain) NSNumber * id;

/** The start date of the demanded vacation.
*/
@property (nonatomic, retain) NSDate * startDate;

/** The demand owners displayed name.
*/
@property (nonatomic, retain) NSString * userDisplayName;

/** The demand owners primary key in wave database.
*/
@property (nonatomic, retain) NSNumber * userId;

/** The vacation demands processing stage.
@see VacationDemandStatus
*/
@property (nonatomic, retain) VacationDemandStatus *demandStatus;

/** The vacation demands type.
@see VacationDemandType
*/
@property (nonatomic, retain) VacationDemandType *demandType;

@end
