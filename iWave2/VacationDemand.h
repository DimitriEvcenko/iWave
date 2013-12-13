//
//  VacationDemand.h
//  iWave2
//
//  Created by Marco Lorenz on 20.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VacationDemandStatus, VacationDemandType;

/** This class handles the vacation demands in core data.
 
 Vacation Demands are deleted on logout or determination of the application. Only local demands that are not sent to wave intranet are persisted.
 Normaly a logged in User creates a new vacation demand an sends it to wave intranet. He only sees his vascation demands. 
 Managers also can see the demands of direct or other reports.
 @see VacationDemandLocal 
 */
@interface VacationDemand : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name Administrate an persist Vacation Demands
 *  ---------------------------------------------------------------------------------------
 */
/** The demand owners comment.
*/
@property (nonatomic, retain) NSString * comment;

/** The date of creating the demand.
*/
@property (nonatomic, retain) NSDate * createdOn;

/** The end date of the demanded vacation.
*/
@property (nonatomic, retain) NSDate * endDate;

/** The demands primary key in wave database.

@warning On creating a new demand id must not be set.
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


/**---------------------------------------------------------------------------------------
 * @name Handle the Vacation Demand
 *  ---------------------------------------------------------------------------------------
 */
/** Test if the vacation demand shown on the view controller is complete to be requested.
 Start date, end date and the type of vacation have to be set.
 @return Yes, if the demand is requestable.
 */
-(BOOL)vacationDemandisComplete;

@end
