//
//  WLTableHeaderLabel.m
//  iWave2
//
//  Created by Marco Lorenz on 12.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTableHeaderLabel.h"
#import "CommonSettings.h"

@implementation WLTableHeaderLabel

/**------------------------------------------------------------------------------------
 * @name Create a Table Header Label
 *-------------------------------------------------------------------------------------
 */
/** Initializes an allocated object of the table header label class.
 @return An object of the table header class.
 */
-(id)init{
    
    self = [super init];
    if (self) {
        [self adaptStyle];
    }
    return self;
}

/**------------------------------------------------------------------------------------
 * @name Do the Design
 *-------------------------------------------------------------------------------------
 */
/** Making the common design for all header view labels in iWave. */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    self.frame = CGRectMake(50, 10, 400, 20);
    
    [self setFont:[WLColorDesign getFontNormal:design withSize:16.]];
    self.textColor = [WLColorDesign getMainFontColor:design];
    self.backgroundColor = [UIColor clearColor];
}


@end
