//
//  WLMainCell.m
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLMainCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonSettings.h"
#import "WLAccessibility.h"

@implementation WLMainCell

/**--------------------------------------------------------
 * @name Initializing a Mainmenu Cell Object
 *  --------------------------------------------------------
 */
/** Initializes and returns a newly allocated view object with the specified frame rectangle.
 Does additional setup for mainmenu cell.
 @param frame The frame rectangle for the view, measured in points.
 @return An initialized view object or nil if the object couldn't be created.
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self adaptStyle];                
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.nameLabel];
        self.accessibilityElements = [[NSMutableArray alloc]init];
    }
    return self;
}

/**--------------------------------------------------------
 * @name Designing the View
 *  --------------------------------------------------------
 */
/** Doing the design of the calendar cell.
 */
-(void)adaptStyle{
    
    CommonSettings *commonSettings = [CommonSettings MR_findFirst];
    
    int design = [commonSettings.design intValue];
    
    self.backgroundColor = [WLColorDesign getSecondBackgroundColor:design];
    
    
    self.layer.borderColor = [WLColorDesign getMainFontColor:design].CGColor;
    self.layer.borderWidth = 2.0f;
    self.layer.shadowColor = [WLColorDesign getMainFontColor:design].CGColor;
    self.layer.shadowRadius = 5.0f;
    self.layer.shadowOffset = CGSizeMake(4.0f, 4.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.cornerRadius = 18.0f;
    
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(-10, 110, 120, 40)];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.nameLabel.font = [WLColorDesign getFontNormal:design withSize:14];
    self.nameLabel.textColor = [WLColorDesign getMainFontColor:design];
    self.nameLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
}

/**--------------------------------------------------------
 * @name Reusing Cells
 *  --------------------------------------------------------
 */
/** Performs any clean up necessary to prepare the view for use again.
 */
- (void)prepareForReuse
{
    [self.imageView removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    
    [self adaptStyle];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.nameLabel];
}

/**---------------------------------------------------------
 * @name Making the Cell Accessible
 *----------------------------------------------------------
 */
/** Creates an accessibility label for the main cell.
 @param origin The superviews origin point.
 @param orientation The device orientation the accessibility label should be shown.
 */
-(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andInterfaceOrientation:(UIInterfaceOrientation)orientation;
{
    [WLAccessibility createAccessibilityLabelWithOrigin:origin andLayer:self.layer andText:self.nameLabel.text andInterfaceOrientation:orientation andAccessibilityContainer:self.accessibilityElements];

    /*
    [self.accessibilityElements removeAllObjects];
    self.accessibilityElement = [[UIAccessibilityElement alloc]initWithAccessibilityContainer:self];
    
    self.accessibilityElement.accessibilityFrame = CGRectMake(self.layer.frame.origin.x, self.layer.frame.origin.y + y, self.layer.frame.size.width, self.layer.frame.size.height);
    self.accessibilityElement.isAccessibilityElement = YES;
    self.accessibilityElement.accessibilityTraits = UIAccessibilityTraitButton;
    self.accessibilityElement.accessibilityLabel = self.nameLabel.text;
    [self.accessibilityElements addObject:self.accessibilityElement];
     */
}

/** Getter for the accessibility element property.
 @return The accessibility element.
 */
-(NSArray*)theElementArray
{
    if(self.accessibilityElements.count > 0)
    {
        return self.accessibilityElements;
    }
    return nil;
}


/*-(BOOL)isAccessibilityElement
{
 
    //Comment
    //return NO is default value. Makes implementation unnecessary
 
    return NO;
}*/

/** Returns an accessibility element from accessibility elements array.
 @param index The accessibility elements index.
 @return An accessibility element.
 */
-(id)accessibilityElementAtIndex:(NSInteger)index
{
    return [self.accessibilityElements objectAtIndex:index];
}

/** Returns the index of an accessibility element in the accessibility elements array.
 @param element The accessibility element.
 @return The accessibility elements index.
 */
-(NSInteger)indexOfAccessibilityElement:(id)element
{
    return [self.accessibilityElements indexOfObject:element];
}

/** Returns the count of accessibility elements in the accessibility elements array.
 @return The count of elements in the accessibility elements array.*/
-(NSInteger)accessibilityElementCount
{
    return self.accessibilityElements.count;
}
@end
