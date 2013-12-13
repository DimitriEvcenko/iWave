//
//  WLTutorialArrow.m
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTutorialArrow.h"
#import "WLRoundedRectangleView.h"
#import "CommonSettings.h"

#define DEGREES_TO_RADIANS(x)(M_PI * x/180.0)

@implementation WLTutorialArrow

@synthesize displayedArrow = _displayedArrow;

static WLTutorialArrow *_sharedTutorialArrow;

/**----------------------------------------------------------------------------
 * @name Managing the Singleton
 *-----------------------------------------------------------------------------
 */
/** This public mehtod return the shared instance of the class.
 @return The singleton instance of the class.
 */
+ (WLTutorialArrow *)sharedTutorialArrow
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTutorialArrow = [[WLTutorialArrow alloc] init];
    });
    return _sharedTutorialArrow;
}

/** Returns an initialized tutorial arrow object.
 @return A tutorial arrow object.
 */
- (id)init
{
    return [self initWithArrowImage:[UIImage imageNamed:@"TutorialArrow"] anchorPoint:CGPointMake(1.0, 0.5)];
}

/** Initializes the tutroial arrow object with image and start point.
 @param arrowImage The image to display the arrow.
 @param anchorPoint The startpoint for the arrow image view.
 @return The tutorial arrwo object.
 */
- (id)initWithArrowImage:(UIImage *)arrowImage anchorPoint:(CGPoint)anchorPoint
{
    if (self = [super init]) {
        
        
        _arrowView = [[UIImageView alloc] initWithImage:arrowImage];
        _origSize = _arrowView.frame.size;
        _arrowView.layer.anchorPoint = anchorPoint;
        
        _textView = [[WLRoundedRectangleView alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        _textLabel = [[UILabel alloc]initWithFrame:_textView.frame];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
        _textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _textLabel.textColor = [WLColorDesign getSecondFontColor:SIDION_LIGHT];
        _textLabel.backgroundColor = [UIColor colorWithRed:0.8 green:0.8 blue:1. alpha:0.8];
        _textLabel.font = [WLColorDesign getFontNormal:SIDION_LIGHT withSize:24.];
        
        [_textView addSubview:_textLabel];
        //[_arrowView addSubview:self.tutorialText];
    }
    return self;
}

/**----------------------------------------------------------------------------
 * @name Displaying the Tutorial Arrow
 *-----------------------------------------------------------------------------
 */
/** Removes the arrow view from screen. 
 @param animated YES, if the arrow view should be removed animated.
 */
- (void)removeArrowAnimated:(BOOL)animated
{
    
    if (animated) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            [_arrowView setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            
            [self removeArrowCompleted];
            
        }];
        
    } else {
        
        [self removeArrowCompleted];
        
    }
}

/** Removes the array view from superview and removes animations from arrow view. */
- (void)removeArrowCompleted
{
    [_arrowView removeFromSuperview];
    
    _displayedArrow = NO;
    [_arrowView.layer removeAnimationForKey:@"bounceAnimation"];
}

/** Displays the arrow view on the screen.
 @param window The window the arrow view is shown
 @param point The point in window the arrow view should be placed.
 @param angle The angle the arrow view shold have.
 @param orientation The orientation the arrow view is shown in.
 @param length The arrow views length.
 */
- (void)showArrowInWindow:(UIWindow *)window atPoint:(CGPoint)point atAngle:(CGFloat)angle inOrientation:(UIInterfaceOrientation)orientation length:(CGFloat)length
{
    
    _window = window;
    _point = point;
    _length = length;
    
    //dooing Transformation to orientation
    CGFloat degrees = [self transformAngle:angle inOrientation:orientation];
    point = [self pointMake:point inOrientation:orientation];
    
    //// bounce animation
    [_arrowView.layer removeAnimationForKey:@"bounceAnimation"];
    
    CABasicAnimation *yAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    yAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    yAnimation.fromValue = [NSNumber numberWithFloat:0];
    yAnimation.toValue = [NSNumber numberWithFloat:0.0 - 10.0 * sin(DEGREES_TO_RADIANS(degrees))];
    yAnimation.repeatCount = INT_MAX;
    yAnimation.autoreverses = YES;
    yAnimation.fillMode = kCAFillModeForwards;
    yAnimation.removedOnCompletion = NO;
    yAnimation.additive = YES;
    
    CABasicAnimation *xAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    xAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    xAnimation.fromValue = [NSNumber numberWithFloat:0];
    xAnimation.toValue = [NSNumber numberWithFloat:0.0 - 10.0 * cos(DEGREES_TO_RADIANS(degrees))];
    xAnimation.repeatCount = INT_MAX;
    xAnimation.autoreverses = YES;
    xAnimation.fillMode = kCAFillModeForwards;
    xAnimation.removedOnCompletion = NO;
    xAnimation.additive = YES;
    
    CAAnimationGroup *bounceAnimation = [CAAnimationGroup animation];
    bounceAnimation.fillMode = kCAFillModeForwards;
    bounceAnimation.removedOnCompletion = NO;
    [bounceAnimation setAnimations:[NSArray arrayWithObjects:yAnimation, xAnimation, nil]];
    bounceAnimation.duration = 0.25;
    bounceAnimation.repeatCount = INT_MAX;
    bounceAnimation.autoreverses = YES;
    
    [_arrowView.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    
    if (!_displayedArrow) {
        
        _arrowView.alpha = 0.0;
        [window addSubview:_arrowView];
        
    }
    
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction animations:^{
        
        [_arrowView setAlpha:1.0];
        
        
        CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(degrees));
        
        
        if (length == 0.0) {
            
            _arrowView.transform = CGAffineTransformIdentity;
            _arrowView.transform = rotateTransform;
            _arrowView.transform = CGAffineTransformScale(rotateTransform, 1.0, 1.0);
            
        } else {
            
            CGFloat ratio = length / _origSize.width;
            _arrowView.transform = CGAffineTransformIdentity;
            _arrowView.transform = rotateTransform;
            _arrowView.transform = CGAffineTransformScale(rotateTransform, ratio, ratio);
            
        }
        
        _arrowView.layer.position = point;
        
    } completion:^(BOOL finished) {
        
        _displayedArrow = YES;
        
    }];
}


/**----------------------------------------------------------------------------
 * @name Displaying the Tutorial Textfield
 *-----------------------------------------------------------------------------
 */
/** Removes the text view from superview. */
- (void)removeTextCompleted
{
    [_textView removeFromSuperview];
    
    _displayedText = NO;
}

/** Removes the text view from screen.
 @param animated YES, if the text view should be removed animated.
 */
- (void)removeTextAnimated:(BOOL)animated
{
    
    if (animated) {
        
        [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionCurveEaseIn|UIViewAnimationOptionAllowUserInteraction animations:^{
            
            [_textView setAlpha:0.0];
            
        } completion:^(BOOL finished) {
            
            [self removeTextCompleted];
            
        }];
        
    } else {
        
        [self removeTextCompleted];
        
    }
}

/** Displays the text view on the screen.
 @param window The window the text view is shown
 @param point The point in window the text view should be placed.
 @param orientation The orientation the text view is shown in.
 @param text The text shown in text view.
 @param duration The duration the animation of appearance should last in seconds.
 */
-(void)showTextInWindow:(UIWindow *)window atPoint:(CGPoint)point inOrientation:(UIInterfaceOrientation)orientation withText:(NSString *)text andDuration:(CGFloat)duration{
    
    _window = window;
    _point = point;
    
    //dooing Transformation to orientation
    point = [self pointMake:point inOrientation:orientation];
    
    if (!_displayedText) {
        
        _textView.alpha = 0.0;
        [window addSubview:_textView];
    }
    
    CGAffineTransform rotateTransform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS([self transformAngle:180 inOrientation:orientation]));
    
    [_textView setAlpha:1.0];
    [_textLabel setText:text];
    _textView.transform = CGAffineTransformIdentity;
    _textView.transform = rotateTransform;
    _textView.transform = CGAffineTransformScale(rotateTransform, 1.0, 1.0);
    
    _textView.layer.position = point;

    
    _displayedText = YES;
}


/**------------------------------------------------------------------
 * @name Coordinate Operations
 *-------------------------------------------------------------------
 */
/** This method determines the origin of the screens coordinate system in the specified orientation.
 @param orientation The orientation the origin should be detemined.
 @return The origin in screen coordinates.*/
-(CGPoint)getOrigin:(UIInterfaceOrientation)orientation{
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            return CGPointMake(0, 0);
        case UIInterfaceOrientationPortraitUpsideDown:
            return CGPointMake(screenBounds.size.width, screenBounds.size.height);
        case UIInterfaceOrientationLandscapeRight:
            return CGPointMake(screenBounds.size.width, 0);
        case UIInterfaceOrientationLandscapeLeft:
            return CGPointMake(0, screenBounds.size.height);
    }
}

/** The method transforms a point from user coordinates to screen coordinates.
 @param point The point in user cordinates with origin in the upper left corner of the device.
 @param orientation The orientation the point should be transformed.
 @return The point in screen coordinates.
 */
-(CGPoint)pointMake:(CGPoint)point inOrientation:(UIInterfaceOrientation)orientation{
    
    int xmod = 1;
    int ymod = 1;
    
    //transform point on landscape orientation
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            ymod = -1;
            xmod = -1;
            break;
        case UIInterfaceOrientationLandscapeRight:
            point = CGPointMake(point.y, point.x);
            xmod = -1;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            point = CGPointMake(point.y, point.x);
            ymod = -1;
            break;
        default:
            break;
    }
    
    return CGPointMake(point.x*xmod + [self getOrigin:orientation].x, point.y*ymod + [self getOrigin:orientation].y);
    
}

/** The method transforms an angle from user coordinates to screen coordinates.
 @param angle The angle in user coordinates decribed in the class definition.
 @param orientation The orientation the point should be transformed.
 @return The angle in screen coordinates.
 */
-(float)transformAngle:(float)angle inOrientation:(UIInterfaceOrientation)orientation{
    
    float additionalAngel;
    
    
    switch (orientation) {
        case UIInterfaceOrientationPortraitUpsideDown:
            additionalAngel = 0.;
            break;
        case UIInterfaceOrientationLandscapeRight:
            additionalAngel = -90.;
            break;
        case UIInterfaceOrientationLandscapeLeft:
            additionalAngel = 90.;
            break;
        default:
            additionalAngel = 180.;
            break;
    }
    
    return angle + additionalAngel;;
    
}


@end
