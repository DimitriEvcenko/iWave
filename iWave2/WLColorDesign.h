//
//  WLColorDesign.h
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class contains class methods that describe the color design of iWave application.
 The color design depends on desgin in common settings and on sidion CI. */
@interface WLColorDesign : NSObject

/**------------------------------------------------------------------------
 * @name Background Colors
 *-------------------------------------------------------------------------
 */
/** Returns the backgroundcolor that should be used most in the application. 
 @param design The value of the selected design.
 @return The main background color.*/
+(UIColor *)getMainBackgroundColor: (AppDesigns)design;

/** Returns the backgroundcolor that should be used most, when main background color is not used.
 @param design The value of the selected design.
 @return The second background color.*/
+(UIColor *)getSecondBackgroundColor: (AppDesigns)design;

/** Returns the backgroundcolor that should be used as last option for a background color.
 @param design The value of the selected design.
 @return The third background color.*/
+(UIColor *)getThirdBackgroundColor: (AppDesigns)design;

/**------------------------------------------------------------------------
 * @name Extradesign Colors
 *-------------------------------------------------------------------------
 */
/** Returns the extra color that should be additional to other colors.
 @param design The value of the selected design.
 @return The extra design background color.*/
+(UIColor *)getExtraDesignColor: (AppDesigns)design;

/**------------------------------------------------------------------------
 * @name Font Colors
 *-------------------------------------------------------------------------
 */
/** Returns the main font color that should be used for fonts.
 @param design The value of the selected design.
 @return The main font color.*/
+(UIColor *)getMainFontColor: (AppDesigns)design;

/** Returns the second font color that should be used, when contrast of main fontcolor and the background color is not good.
 @param design The value of the selected design.
 @return The second font color.*/
+(UIColor *)getSecondFontColor: (AppDesigns)design;

/**------------------------------------------------------------------------
 * @name Navigation Bar Colors
 *-------------------------------------------------------------------------
 */
/** Returns the background color that's used in navigation bars.
 @param design The value of the selected design.
 @return The navigation bar color.*/
+(UIColor *)getNavigationColor:(AppDesigns)design;

/** Returns the title color that's used in navigation bars.
 @param design The value of the selected design.
 @return The navigation bar title color.*/
+(UIColor *)getNavigationTitleColor:(AppDesigns)design;

/**------------------------------------------------------------------------
 * @name Getting the Font
 *-------------------------------------------------------------------------
 */
/** This method returns the normal sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return A normal font.
 */
+(UIFont *)getFontNormal:(AppDesigns)design withSize: (CGFloat)size;

/** This method returns the italic sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return An italic font.
 */
+(UIFont *)getFontItalic:(AppDesigns)design withSize: (CGFloat)size;

/** This method returns the bold sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return A bold font.
 */
+(UIFont *)getFontBold:(AppDesigns)design withSize: (CGFloat)size;
@end
