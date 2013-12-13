//
//  WLMainCell.h
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>


/** This class defines a single cell in the applications mainmenu view.
 
 An instance of this class represents a link to a mini app.
 @see WLMiniApp
 */
@interface WLMainCell : UICollectionViewCell <WLDesignGuide>

/**--------------------------------------------------------
 *@name Handle the UI-Controls.
 *---------------------------------------------------------
 */
/** The displayed image view. */
@property (nonatomic, strong) UIImageView *imageView;

/** The dispayed description of the mini app. */
@property (nonatomic, strong) UILabel *nameLabel;

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
 */
-(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end
