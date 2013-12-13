//
//  WLAccessibility.m
//  iWave2
//
//  Created by Alexander Eiselt on 06.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLAccessibility.h"
#import <QuartzCore/QuartzCore.h>

@implementation WLAccessibility

/**-------------------------------------------------------------------------------------------------
 * @name Create Accessibility Label in Collection View
 *--------------------------------------------------------------------------------------------------
 */
/** Creates an accessibility label for a collection view cell.
 @param origin The collection views origin in the application window coordinates.
 @param layer The collection view cells layer the accessibility label should be added.
 @param text The text the accessibility label should display.
 @param orientation The device orientation the accessibility label should be added.
 @param container The accessibility container the label is added.
 */
+(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andLayer:(CALayer*)layer andText:(NSString*)text andInterfaceOrientation:(UIInterfaceOrientation)orientation andAccessibilityContainer:(NSMutableArray*)container
{
    [container removeAllObjects];
    UIAccessibilityElement *element;
    element = [[UIAccessibilityElement alloc]initWithAccessibilityContainer:self];    

    switch (orientation) {
        case UIInterfaceOrientationPortrait:
            element.accessibilityFrame = CGRectMake(origin.x+layer.frame.origin.x, origin.y+layer.frame.origin.y, layer.frame.size.width, layer.frame.size.height);
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            element.accessibilityFrame = CGRectMake(origin.x-layer.frame.size.width-layer.frame.origin.x, origin.y-layer.frame.size.height-layer.frame.origin.y, layer.frame.size.width, layer.frame.size.height);
            break;
        case UIInterfaceOrientationLandscapeLeft:
            element.accessibilityFrame = CGRectMake(origin.x+layer.frame.origin.y, origin.y-layer.frame.size.width-layer.frame.origin.x, layer.frame.size.height, layer.frame.size.width);
            break;
        case UIInterfaceOrientationLandscapeRight:
            //element.accessibilityFrame = CGRectMake(offset.x-layer.frame.size.height-layer.frame.origin.x, offset.y, layer.frame.size.height, layer.frame.size.width);
            element.accessibilityFrame = CGRectMake(origin.x-layer.frame.size.height - layer.frame.origin.y, origin.y+layer.frame.origin.x, layer.frame.size.height, layer.frame.size.width);

            break;
        default:
            break;
    }
    //element.accessibilityFrame = CGRectMake(offset.x, offset.y, layer.frame.size.height, layer.frame.size.width);
    
    element.isAccessibilityElement = YES;
    element.accessibilityTraits = UIAccessibilityTraitButton;
    element.accessibilityLabel = text;
    [container addObject:element];
}

@end
