//
//  WLMiniApp.m
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLMiniApp.h"


@implementation WLMiniApp

/**---------------------------------------------------------------------------------------
 * @name Creating a Mini App
 *  ---------------------------------------------------------------------------------------
 */
/** Creates a mini app object with a number. The used numbers are limited to the number of developed mini apps.
 The number is defined in WLConstants.
 @param number The defined number of the mini app.
 @see WLConstants
 @return A mini app object.
 */
+ (WLMiniApp *)createWithNumber:(int)number{
    
    WLMiniApp *output = [[self alloc] init];
        
    switch (number) {
        case SETTINGS:
            output.name = NSLocalizedString(@"Settings", @"settings");
            output.image = [UIImage imageNamed:@"settings.png"];
            return output;
        case VACATION:
            output.name = NSLocalizedString(@"Vacation", @"vacation");
            output.image = [UIImage imageNamed:@"vacation.png"];
            return output;
        case MARKETPLACE:
            output.name = NSLocalizedString(@"Marketplace", @"marketplace");
            output.image = [UIImage imageNamed:@"marketplace.gif"];
            return output;
        default:
            output.name = NSLocalizedString(@"Marketplace", @"marketplace");
            output.image = [UIImage imageNamed:@"marketplace.gif"];
            return output;
    }
    
}


@end
