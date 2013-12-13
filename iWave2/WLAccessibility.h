//
//  WLAccessibility.h
//  iWave2
//
//  Created by Alexander Eiselt on 06.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The methods in this class are used to create accessible elements in controls that do not inherit from UIView.
 */
@interface WLAccessibility : NSObject

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
+(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andLayer:(CALayer*)layer andText:(NSString*)text andInterfaceOrientation:(UIInterfaceOrientation)orientation andAccessibilityContainer:(NSMutableArray*)container;

@end
