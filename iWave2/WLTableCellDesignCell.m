//
//  WLTableCellDesignCell.m
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTableCellDesignCell.h"
#import "CommonSettings.h"

@implementation WLTableCellDesignCell

/**--------------------------------------------------------
 * @name Initializing a Table Cell Object
 *  --------------------------------------------------------
 */

/*- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self adaptStyle];
    }
    return self;
}*/

/** Initializes a table cell from data in given unarchiver.
 @param aDecoder An unarchiver object.
 @return A table cell layout instance.
 */
-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        [self adaptStyle];
    }
    return  self;
}

/** Initializes and returns a newly allocated view object with the specified frame rectangle.
 Does additional setup for mainmenu cell.
 @param frame The frame rectangle for the view, measured in points.
 @return An initialized view object or nil if the object couldn't be created.
 */
-(id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self adaptStyle];
    }
    return self;
    
}

/**--------------------------------------------------------
 * @name Designing the View
 *  --------------------------------------------------------
 */
/** Doing the design of a table cell. */
-(void)adaptStyle{
    
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    self.backgroundColor = [WLColorDesign getSecondBackgroundColor:design];
    [self.textLabel setFont:[WLColorDesign getFontBold:design withSize:20.]];
}

/*- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}*/

@end
