//
//  WLCaldendarCell.m
//  iWave2
//
//  Created by Marco Lorenz on 15.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCaldendarCell.h"
#import <QuartzCore/QuartzCore.h>
#import "CommonSettings.h"
#import "WLAccessibility.h"
#import "WLCalendarOperations.h"

@implementation WLCaldendarCell
/**--------------------------------------------------------
 * @name Initializing a Calendar Cell Object
 *  --------------------------------------------------------
 */ 
/** Initializes and returns a newly allocated view object with the specified frame rectangle.
Does additional setup for calendar cell.
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
    
    //cell setup
    self.backgroundColor = [WLColorDesign getSecondBackgroundColor:design];
    self.backgroundView.backgroundColor = [WLColorDesign getThirdBackgroundColor:design];
    self.layer.borderColor = [WLColorDesign getMainFontColor:design].CGColor;
    self.layer.borderWidth = 0.0f;
    
    //the boarders
    self.bottomBoarder = [CALayer layer];
    self.bottomBoarder.frame = CGRectMake(0, self.frame.size.height, self.layer.frame.size.width, 1.0f);
    self.bottomBoarder.backgroundColor = [UIColor blackColor].CGColor;
        
    //the display label
    self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.frame.size.width-40, self.contentView.frame.size.height-25, 40, 20)];
    
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel.font = [WLColorDesign getFontBold:design withSize:16];
    self.nameLabel.textColor = [UIColor colorWithWhite:0 alpha:0.5];//[WLColorDesign getMainFontColor:design];
    self.nameLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    
    
    //the image
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    self.imageView.contentMode = UIViewContentModeRedraw;
    self.imageView.clipsToBounds = YES;
    
    [self.layer addSublayer:self.bottomBoarder];
    
}

/**--------------------------------------------------------
 * @name Reusing Cells
 *  --------------------------------------------------------
 */ 
/** Performs any clean up necessary to prepare the view for use again. 
*/
-(void)prepareForReuse{
    /*
    [self.bottomBoarder removeFromSuperlayer];
    [self.imageView removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    
    [self adaptStyle];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.nameLabel];
     */
}

/** Redraws the cell with the correct cellsize*/
-(void)redrawCell
{
    [self.bottomBoarder removeFromSuperlayer];
    [self.imageView removeFromSuperview];
    [self.nameLabel removeFromSuperview];
    
    [self adaptStyle];
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.nameLabel];
}
/**--------------------------------------------------------
 * @name Managing the Cell's State
 *  --------------------------------------------------------
 */ 
/** Change appearance of the calendar cell on selection.
@param selected Yes if the cell is selected. 
*/
-(void)setSelected:(BOOL)selected{
    
    //return, if cell is no day
    if(![self.nameLabel.text intValue])
        return;
    
    NSLog(@"Selected Cell with high:%f",self.contentView.frame.size.height);
    if(selected){
        NSLog(@"Cell Selected");
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 4.0f;
        [((UIAccessibilityElement*)[self.accessibilityElements objectAtIndex:0]) setAccessibilityLabel:[NSString stringWithFormat:@"%@ %@", [WLCalendarOperations getDateInformation:self.date withFormat:NSLocalizedString(@"AccessibiltyDateFormat", @"")], NSLocalizedString(@"Accessibilty_selected", @"")]];
    }
    else{
        NSLog(@"Cell Disselected");
        self.layer.borderWidth = 0.0f;
        [((UIAccessibilityElement*)[self.accessibilityElements objectAtIndex:0]) setAccessibilityLabel:[WLCalendarOperations getDateInformation:self.date withFormat:NSLocalizedString(@"AccessibiltyDateFormat", @"")]];

    }
    
    [self setNeedsDisplay];

}

/**---------------------------------------------------------
 * @name Making the Cell Accessible
 *----------------------------------------------------------
 */
/** Creates an accessibility label for the main cell.
 @param origin The superviews origin point.
 @param orientation The device orientation the accessibility label should be shown.
 @param text The text should be displayed in the accessibility lable.
 */
-(void)createAccessibilityLabelWithOrigin:(CGPoint)origin andInteraceOrientation:(UIInterfaceOrientation)orientation andText:(NSString*)text;
{    
    [WLAccessibility createAccessibilityLabelWithOrigin:origin andLayer:self.layer andText:text andInterfaceOrientation:orientation andAccessibilityContainer:self.accessibilityElements];
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
