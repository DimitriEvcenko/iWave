//
//  CommonSettings.h
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** This class handles the iWave CommonSettings.
 
 This class is to persist in core data. An instance of CommonSettings is a singleton and is overwritten when changed.
 It has two values usability and design.
 */
@interface CommonSettings : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name Persist the Settings
 *  ---------------------------------------------------------------------------------------
 */
 /** Usability has the information of users prefered handling.
	
	There are three states:
	- only button handling
	- only gestures handling
	- both
 */
@property (nonatomic, retain) NSNumber * usability;

/** Design has the information of users prefered color styles.
	
	There are three states:
	- sidion-light
	- sidion-dark
	- ml-thesis	
@warning *Warning:* Only sidion-light is designed at the current state (17.07.2013).
 */
@property (nonatomic, retain) NSNumber * design;

/**---------------------------------------------------------------------------------------
 * @name Getting the Settings for Display
 *  ---------------------------------------------------------------------------------------
 */
/** Gets the Name of the usability value

@return The stringvalue of the usability value
 */
-(NSString*)getUsability;

/** Gets the Name of the design value

@return The stringvalue of the design value
 */
-(NSString*)getDesign;

@end
