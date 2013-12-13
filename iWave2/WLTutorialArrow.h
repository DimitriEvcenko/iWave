//
//  WLTutorialArrow.h
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "WLRoundedRectangleView.h"

/** The singleton instance of this class contains a text view and a blinking arrow.
 Arrow and textfield can be shown seperatly but they are global and independent from any view controller.
 So they use global coordinates. To place the control elements in any orentation transformation methods transform the coordinate systems so that the origin is always on the upper left corner. Arrows angel is also transformatted so that a direction to the left is zero degrees and the degrees increase clockwise.
 */
@interface WLTutorialArrow : NSObject{
    UIImageView *_arrowView;
    WLRoundedRectangleView *_textView;
    UILabel *_textLabel;
    CGSize _origSize;    
    UIWindow *_window;
    CGPoint _point;
    CGFloat _length;
}

/**----------------------------------------------------------------------------
 * @name Displaying the Tutorial Arrow
 *-----------------------------------------------------------------------------
 */
/** This property is a getter only and shows if the tutorial arrow is displayed on screen. */
@property (nonatomic, assign, getter = isDisplayedArrow) BOOL displayedArrow;

- (void)showArrowInWindow:(UIWindow *)window atPoint:(CGPoint)point atAngle:(CGFloat)angle inOrientation:(UIInterfaceOrientation)orientation length:(CGFloat)length;

- (void)removeArrowAnimated:(BOOL)animated;

/**----------------------------------------------------------------------------
 * @name Displaying the Tutorial Textfield
 *-----------------------------------------------------------------------------
 */
/** This property is a getter only and shows if the tutorials text field is displayed on screen. */
@property (nonatomic, assign, getter = isDisplayedText) BOOL displayedText;

- (void)showTextInWindow:(UIWindow *)window atPoint:(CGPoint)point inOrientation:(UIInterfaceOrientation)orientation withText:(NSString*)text andDuration:(CGFloat)duration;

- (void)removeTextAnimated:(BOOL)animated;

/**----------------------------------------------------------------------------
 * @name Managing the Singleton
 *-----------------------------------------------------------------------------
 */
/** This public mehtod return the shared instance of the class.
 @return The singleton instance of the class.
 */
+ (WLTutorialArrow *)sharedTutorialArrow;

/** Initializes the tutroial arrow object with image and start point.
 @param arrowImage The image to display the arrow.
 @param anchorPoint The startpoint for the arrow image view.
 @return The tutorial arrwo object.
 */
- (id)initWithArrowImage:(UIImage *)arrowImage anchorPoint:(CGPoint)anchorPoint;


@end