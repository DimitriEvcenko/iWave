//
//  WLYesNoSwitch.m
//  iWave
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLYesNoSwitch.h"

@implementation WLYesNoSwitch

/**--------------------------------------------------------
 *@name Initialize the Switch Object.
 *---------------------------------------------------------
 */
/** Initializes and returns a newly allocated view object with the specified frame rectangle
 @param frame The frame for the view messured in points.
 @return An initialized view object.
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSwitch];
    }
    return self;
}

/** Setting the images for the switch element. */
-(void)initSwitch{
    
    self.offImage = [UIImage imageNamed:@"switchNo12px.jpg"];
    self.onImage = [UIImage imageNamed:@"switchYes12px.jpg"];
}

/** Initializes and returns a newly allocated view object from data in given unarchiver.
 @param aDecoder An unarchiver object.
 @return An initialized view object.
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSwitch];
    }
    return self;
}


@end
