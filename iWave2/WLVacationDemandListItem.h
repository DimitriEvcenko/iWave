//
//  WLVacationDemandListItem.h
//  iWave2
//
//  Created by Marco Lorenz on 28.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** An instance of this class represents a item in vacation demand list response sent by wave intranet.
 A vacation demand list item contains all information about a demanded vacation.
 */
@interface WLVacationDemandListItem : NSObject

/**---------------------------------------------------------------------------------------
 * @name Accessing Vacation Demand List Item Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The vacations primary key in wave intranet. */
@property (strong, nonatomic) NSNumber *id;

/** The name of the user belonging to the vacation. */
@property (strong, nonatomic) NSString *userDisplayName;

/** The vacations start date. */
@property (nonatomic) double startDate;

/** The vacations end date*/
@property (nonatomic) double endDate;

/** The comment of the vacation. */
@property (strong, nonatomic) NSString *comment;

/** The vacation status as string.
 @see VacationDemandStatus
 */
@property (strong, nonatomic) NSString *status;

/** The type of vacation as string.
 @see VacationDemandType
 */
@property (strong, nonatomic) NSString *demandType;

/** The name of the users department belonging to the vacation.  */
@property (strong, nonatomic) NSString *department;

@end
