//
//  WLCalendarViewLayout.m
//  iWave2
//
//  Created by Marco Lorenz on 06.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLCalendarViewLayout.h"

static NSString * const CalendarLayoutCellKind = @"CalendarCell";

@interface WLCalendarViewLayout()

/**---------------------------------------------------------------------------------------
 * @name Providing Layout Attributes
 *  ---------------------------------------------------------------------------------------
 */
/** The dictionary contains dicionarys describing the attribute of different cell specifiers. 
 In this class only one cell specifier is available. */
@property (nonatomic, strong) NSDictionary *layoutInfo;

@end

@implementation WLCalendarViewLayout

/**---------------------------------------------------------------------------------------
 * @name Getter and Setter
 *  ---------------------------------------------------------------------------------------
 */
/** The setter of item insets. Reload of layout is caused.
 @param itemInsets The new item insets. */
- (void)setItemInsets:(UIEdgeInsets)itemInsets
{
    if (UIEdgeInsetsEqualToEdgeInsets(_itemInsets, itemInsets)) return;
    
    _itemInsets = itemInsets;
    
    [self invalidateLayout];
}

/** The setter of item size. Reload of layout is caused.
 @param itemSize The new item size. */
- (void)setItemSize:(CGSize)itemSize
{
    if (CGSizeEqualToSize(_itemSize, itemSize)) return;
    
    _itemSize = itemSize;
    
    [self invalidateLayout];
}

/** The setter of inter item spacing in y-axis. Reload of layout is caused.
 @param interItemSpacingY The new inter item spacing in y-axis. */
- (void)setInterItemSpacingY:(CGFloat)interItemSpacingY
{
    if (_interItemSpacingY == interItemSpacingY) return;
    
    _interItemSpacingY = interItemSpacingY;
    
    [self invalidateLayout];
}

/** The setter of number of colums. Reload of layout is caused.
 @param numberOfColumns The new number of colums. */
- (void)setNumberOfColumns:(NSInteger)numberOfColumns
{
    if (_numberOfColumns == numberOfColumns) return;
    
    _numberOfColumns = numberOfColumns;
    
    [self invalidateLayout];
}

/**---------------------------------------------------------------------------------------
 * @name Initialize the Layout
 *  ---------------------------------------------------------------------------------------
 */
/** Initializes the calendar view layout.
 @return A calendar view layout instance.
 */
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

/** Initializes the calendar view layout from data in given unarchiver.
 @param aDecoder An unarchiver object.
 @return A calendar view layout instance.
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

/** Doing the setup on the layouts properties. */
- (void)setup
{    
    self.itemInsets = UIEdgeInsetsMake(0.0f, 0.0f, 2.0f, 0.0f);
    self.interItemSpacingY = 1.0f;
    self.numberOfColumns = 7;
}


/**---------------------------------------------------------------------------------------
 * @name Providing Layout Attributes
 *  ---------------------------------------------------------------------------------------
 */
/** Called when the layout is updated or set for the first time.  */
-(void) prepareLayout
{
    [self itemSizefromFrame:self.collectionView.frame];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
       
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCalendarCellAtIndexPath:indexPath];
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[CalendarLayoutCellKind] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

/** Returns the layout attributes for all the cells and views in the specified rectangle
 @param rect The recatngle containing the target views.
 @return An array of attribut objects representing the layout information for the cells and views.
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

/** Returns the layout attributes for the item at the specified index path. 
 @param indexPath The index path for the item.
 @return A layout attributes object containing the inforamtion to apply to the item's cell.
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[CalendarLayoutCellKind][indexPath];
}

/**---------------------------------------------------------------------------------------
 * @name Managing the Items in Collection View
 *  ---------------------------------------------------------------------------------------
 */
/** Determines the size of a layout item.
 @param frame the frame the layout is in.
 */
-(void)itemSizefromFrame:(CGRect)frame{
    
    int width = frame.size.width;
    int heigth =  frame.size.height - self.itemInsets.top - ([self getRowCount] - 1) * self.interItemSpacingY - self.itemInsets.bottom;
    
    width = width%self.numberOfColumns ? width/self.numberOfColumns +1 : width/self.numberOfColumns;
    heigth = heigth%[self getRowCount] ? heigth/[self getRowCount] : heigth/[self getRowCount];
    
    self.itemSize = CGSizeMake(width, heigth);
}

/** Determines the rectangle a specific cell should be placed in collection view.
 @param indexPath The index path specifies the cell.
 @return A rectangle in wich the cell is placed.
 */
- (CGRect)frameForCalendarCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.section / self.numberOfColumns;
    NSInteger column = indexPath.section % self.numberOfColumns;
    
    CGFloat spacingX = self.collectionView.bounds.size.width -
    self.itemInsets.left -
    self.itemInsets.right -
    (self.numberOfColumns * self.itemSize.width);
    
    if (self.numberOfColumns > 1) spacingX = spacingX / (self.numberOfColumns - 1);
    
    CGFloat originX = floorf(self.itemInsets.left + (self.itemSize.width + spacingX) * column);
    
    CGFloat originY = floor(self.itemInsets.top +
                            (self.itemSize.height + self.interItemSpacingY) * row);       
    
    return CGRectMake(originX, originY, self.itemSize.width, self.itemSize.height);
}

/** Returns the number of rows in collection view.
 @return The value of rows in collection view.
 */
-(NSInteger)getRowCount{
    
    NSInteger rowCount = [self.collectionView numberOfSections] / self.numberOfColumns;
    // make sure we count another row if one is only partially filled
    if ([self.collectionView numberOfSections] % self.numberOfColumns) rowCount++;
    
    return rowCount;
}

/**---------------------------------------------------------------------------------------
 * @name Gettingt the Collection View Information
 *  ---------------------------------------------------------------------------------------
 */
/** Returns the width and height of the collection view's content.
 @return The width and height of the collection view's content.
 */
- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}


@end
