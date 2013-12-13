//
//  WLRoundedRectangleView.m
//  iWave
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLRoundedRectangleView.h"
#import <QuartzCore/QuartzCore.h>

@implementation WLRoundedRectangleView

/**--------------------------------------------------------
 *@name Initialize the View Object.
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
        [self initRectangle];
    }
    return self;
}

/** Setting the border radius to the view object. */
- (void)initRectangle {
    [self.layer setCornerRadius:8.0f];
    [self.layer setMasksToBounds:YES];
}

/** Initializes and returns a newly allocated view object from data in given unarchiver.
 @param aDecoder An unarchiver object.
 @return An initialized view object.
 */
-(id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initRectangle];
        
    }
    return self;
}

@end
