//
//  WLColorDesign.m
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

@implementation WLColorDesign


/**------------------------------------------------------------------------
 * @name Making the App Sidion Style
 *-------------------------------------------------------------------------
 */
/** Returns the defined sidion blue color with RGB(0,100,192).
 @return The sidion blue color.
 */
+(UIColor*)getSidionBlue{
    return [UIColor colorWithRed:0./255. green:100./255. blue:192./255. alpha:1];
}

/** Returns the defined sidion gray color with RGB(125,126,129).
 @return The sidion gray color.
 */
+(UIColor*)getSidionGray{
    return [UIColor colorWithRed:125./255. green:126./255. blue:129./255. alpha:1];
}

/** Returns the defined first sidion light blue color with RGB(238,243,249).
 @return The first sidion light blue color.
 */
+(UIColor*)getSidionLightBlue1{
    return [UIColor colorWithRed:238./255. green:243./255. blue:249./255. alpha:1];
}

/** Returns the defined second sidion light blue color with RGB(220,230,242).
 @return The second sidion light blue color.
 */
+(UIColor*)getSidionLightBlue2{
    return [UIColor colorWithRed:220./255. green:230./255. blue:242./255. alpha:1];
}

/** Returns the defined sidion normal font Licia Sans with size.
 @param size The size the font is returned.
 @return The sidion normal style font.
 */
+(UIFont*)getSidionFont: (CGFloat)size{
    UIFont *fonts = [UIFont fontWithName:@"Lucia Sans" size:size];
    fonts = [UIFont systemFontOfSize:size];
    return fonts;
}

/** Returns the defined sidion italic font Licia Sans with size.
 @param size The size the font is returned.
 @return The sidion italic style font.
 */
+(UIFont*)getSidionFontItalic:(CGFloat)size{
    UIFont *fonts = [UIFont fontWithName:@"Lucia Sans" size:size];
    fonts = [UIFont italicSystemFontOfSize:size];
    return fonts;
}

/** Returns the defined sidion bold font Licia Sans with size.
 @param size The size the font is returned.
 @return The sidion bold style font.
 */
+(UIFont*)getSidionFontBold:(CGFloat)size{
    UIFont *fonts = [UIFont fontWithName:@"Lucia Sans" size: size];
    fonts = [UIFont boldSystemFontOfSize: size];
    return fonts;
}


/**------------------------------------------------------------------------
 * @name Background Colors
 *-------------------------------------------------------------------------
 */
/** Returns the backgroundcolor that should be used most in the application.
 @param design The value of the selected design.
 @return The main background color.*/
+(UIColor*)getMainBackgroundColor:(AppDesigns)design{
    
    switch (design){
    case SIDION_LIGHT:
        return [UIColor whiteColor];
    case SIDION_DARK:
        return [self getSidionGray];
    case SIDION_BLUE:
        return [self getSidionLightBlue1];
    case SIDION_SAND:
        return [UIColor colorWithRed:236./255. green:231./255. blue:212./255. alpha:1];
    default:
        return  nil;
    }
    
}

/** Returns the backgroundcolor that should be used most, when main background color is not used.
 @param design The value of the selected design.
 @return The second background color.*/
+(UIColor *)getSecondBackgroundColor: (AppDesigns)design{
    switch (design){
        case SIDION_LIGHT:
            return [UIColor whiteColor];
        case SIDION_DARK:
            return [UIColor whiteColor];
        case SIDION_BLUE:
            return [UIColor whiteColor];
        case SIDION_SAND:
            return [UIColor colorWithRed:255./255. green:250./255. blue:231./255. alpha:1];
        default:
            return  nil;
    }
}

/** Returns the backgroundcolor that should be used as last option for a background color.
 @param design The value of the selected design.
 @return The third background color.*/
+(UIColor *)getThirdBackgroundColor: (AppDesigns)design{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionGray];
        case SIDION_DARK:
            return [UIColor blackColor];
        case SIDION_BLUE:
            return [self getSidionLightBlue2];
        case SIDION_SAND:
            return [UIColor colorWithRed:217./255. green:200./255. blue:158./255. alpha:1];
        default:
            return  nil;
    }
}

/**------------------------------------------------------------------------
 * @name Extradesign Colors
 *-------------------------------------------------------------------------
 */
/** Returns the extra color that should be additional to other colors.
 @param design The value of the selected design.
 @return The extra design background color.*/
+(UIColor *)getExtraDesignColor: (AppDesigns)design{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionBlue];
        case SIDION_DARK:
            return [UIColor blackColor];
        case SIDION_BLUE:
            return [self getSidionBlue];
        case SIDION_SAND:
            return [UIColor colorWithRed:207./255. green:174./255. blue:117./255. alpha:1];
        default:
            return  nil;
    }
}

/**------------------------------------------------------------------------
 * @name Font Colors
 *-------------------------------------------------------------------------
 */
/** Returns the main font color that should be used for fonts.
 @param design The value of the selected design.
 @return The main font color.*/
+(UIColor *)getMainFontColor: (AppDesigns)design{
    switch (design){
        case SIDION_LIGHT:
            return [UIColor blackColor];
        case SIDION_DARK:
            return [UIColor whiteColor];
        case SIDION_BLUE:
            return [UIColor blackColor];
        case SIDION_SAND:
            return [UIColor colorWithRed:130./255. green:114./255. blue:94./255. alpha:1];
        default:
            return  nil;
    }
}

/** Returns the second font color that should be used, when contrast of main fontcolor and the background color is not good.
 @param design The value of the selected design.
 @return The second font color.*/
+(UIColor *)getSecondFontColor: (AppDesigns)design{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionBlue];
        case SIDION_DARK:
            return [self getSidionLightBlue1];
        case SIDION_BLUE:
            return [UIColor whiteColor];
        case SIDION_SAND:
            return [UIColor colorWithRed:255./255. green:250./255. blue:231./255. alpha:1];
        default:
            return  nil;
    }
}

/**------------------------------------------------------------------------
 * @name Navigation Bar Colors
 *-------------------------------------------------------------------------
 */
/** Returns the background color that's used in navigation bars.
 @param design The value of the selected design.
 @return The navigation bar color.*/
+(UIColor *)getNavigationColor:(AppDesigns)design{
    
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionGray];
        case SIDION_DARK:
            return [UIColor blackColor];
        case SIDION_BLUE:
            return [self getSidionBlue];
        case SIDION_SAND:
            return [UIColor colorWithRed:207./255. green:174./255. blue:117./255. alpha:1];
        default:
            return  nil;
    }
}

/** Returns the title color that's used in navigation bars.
 @param design The value of the selected design.
 @return The navigation bar title color.*/
+(UIColor *)getNavigationTitleColor:(AppDesigns)design{
    return  [UIColor whiteColor];
}

/**------------------------------------------------------------------------
 * @name Getting the Font
 *-------------------------------------------------------------------------
 */
/** This method returns the normal sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return A normal font.
 */
+(UIFont *)getFontNormal:(AppDesigns)design withSize: (CGFloat)size{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionFont:size];
        case SIDION_DARK:
            return [self getSidionFont:size];
        case SIDION_BLUE:
            return [self getSidionFont:size];
        case SIDION_SAND:
            return [self getSidionFont:size];
        default:
            return  nil;
    }
    
}

/** This method returns the italic sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return An italic font.
 */
+(UIFont *)getFontItalic:(AppDesigns)design withSize: (CGFloat)size{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionFontItalic:size];
        case SIDION_DARK:
            return [self getSidionFontItalic:size];
        case SIDION_BLUE:
            return [self getSidionFontItalic:size];
        case SIDION_SAND:
            return [self getSidionFontItalic:size];
        default:
            return  nil;
    }
}

/** This method returns the bold sidion style font in the given size.
 @param design The value of the selected design.
 @param size The font size.
 @return A bold font.
 */
+(UIFont *)getFontBold:(AppDesigns)design withSize: (CGFloat)size{
    switch (design){
        case SIDION_LIGHT:
            return [self getSidionFontBold:size];
        case SIDION_DARK:
            return [self getSidionFontBold:size];
        case SIDION_BLUE:
            return [self getSidionFontBold: size];
        case SIDION_SAND:
            return [self getSidionFontBold:size];
        default:
            return  nil;
    }
}


@end
