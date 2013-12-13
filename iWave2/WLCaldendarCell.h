//
//  WLCaldendarCell.h
//  iWave2
//
//  Created by Marco Lorenz on 15.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>


/** This class defines a single cell in the applications calender view.

An instance of this class represents a displayed calendar day.
*/
@interface WLCaldendarCell : UICollectionViewCell <WLDesignGuide>

/**--------------------------------------------------------
*@name Handle the UI-Controls.
*---------------------------------------------------------
*/
/** The displayed image view. */
@property (nonatomic, strong) UIImageView *imageView;

/** The dispayed description of the calendar cell. */
@property (nonatomic, strong) UILabel *nameLabel;

/** The bottom boarder to be displayed in the cell.  */
@property (nonatomic, strong) CALayer *bottomBoarder;

/** The date displayed in the calendar cell. */
@property(nonatomic, strong) NSDate *date;

/** Redraws the cell with the correct cellsize*/
-(void)redrawCell;

/**---------------------------------------------------------
 * @name Making the Cell Accessible
 *----------------------------------------------------------
 */
/** The Accessibility Element*/
@property (nonatomic, strong) UIAccessibilityElement *accessibilityElement;

/** The Accessibility Element Container */
@property (nonatomic, strong) NSMutableArray *accessibilityElements;

/** Creates an accessibility label for the main cell.
 @param origin The superviews origin point.
 @param orientation The device orientation the accessibility label should be shown.
 @param text The text should be displayed in the accessibility lable.
 */
-(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andInteraceOrientation:(UIInterfaceOrientation)orientation andText:(NSString*)text;

@end
