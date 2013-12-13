//
//  WLSettingsModel.h
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** An object of the settings model class describes the different settings options that can be choosen in iWave.
 In the beginning there are two different setting options the uswer can select:
 
    design and usability
 
 Each of this options offers new options to select. For design there are:
 
    - Sidion-Ligth
    - Sidion-Dark
    - Special
 
 For usability there are:
 
    - only buttons
    - only gestures
    - both
 
 @warning usability settings are not implemented in iWave. Design is implemented but changings are not possible yet.
 */
@interface WLSettingsModel : NSObject

/**---------------------------------------------------------------------------------------
 * @name Getting Setting Descriptons
 *  ---------------------------------------------------------------------------------------
 */
/** The settings array contains two strings for the two different settings options. */
@property (strong, nonatomic) NSMutableArray *settings;

/** The design settings array contains all strings to describe desing options. 
 @return An array containing the string to describe designs. */
+(NSArray*)setTheDesginSettings;

/** The usability settings array contains all strings to describe usability options.
 @return An array containing the string to describe usability. */
+(NSArray*)setTheUsabilitySettings;

@end
