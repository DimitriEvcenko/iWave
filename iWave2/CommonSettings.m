//
//  CommonSettings.m
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "CommonSettings.h"



@implementation CommonSettings

@dynamic usability;
@dynamic design;

/**---------------------------------------------------------------------------------------
 * @name Getting the Settings for Display
 *  ---------------------------------------------------------------------------------------
 */
/** Gets the Name of the usability value
 
 @return The stringvalue of the usability value
 */
-(NSString*)getUsability{
    switch ([self.usability intValue]){
        case BUTTONS:
            return NSLocalizedString(@"Buttons", @"Buttons");
        case GESTURES:
            return NSLocalizedString(@"Gestures", @"Gestures");
        case BOTH:
            return NSLocalizedString(@"ButtonsAndGestures", @"Both");
        default:
            return @"";
    }
}

/** Gets the Name of the design value
 
 @return The stringvalue of the design value
 */
-(NSString*)getDesign{
    
    switch ([self.design intValue]) {
        case SIDION_LIGHT:
            return NSLocalizedString(@"SidionLight", @"SidionLight");
        case SIDION_DARK:
            return NSLocalizedString(@"SidionDark", @"SidionDark");
        case SIDION_BLUE:
            return NSLocalizedString(@"SidionBlue", @"SidionBlue");
        case SIDION_SAND:
            return NSLocalizedString(@"SidionSand", @"SidionSand");
        default:
            return @"";
    }
}
@end
