//
//  WLTransparentButton.m
//  iWave2
//
//  Created by Marco Lorenz on 22.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTransparentButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation WLTransparentButton

/**-------------------------------------------------------------
 * @name Create a Transparent Button.
 *--------------------------------------------------------------
 */
/** Creates a transparent button item.
 @param frame The frame to set the size of the button.
 @return A transparent button object.
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureButton];
    }
    return self;
}

/** Creates a transparent button item.
 @param aDecoder An unarchiver object.
 @return A transparent button object.
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configureButton];
    }
    return self;
}

/** Doing additional conifguration to make the button transparent.
 */
-(void)configureButton{
    
    self.layer.backgroundColor = [[UIColor colorWithRed:1. green:1. blue:1. alpha:0.2] CGColor];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.cornerRadius = 90.0f;
    self.layer.borderWidth = 0.2f;
}

@end
