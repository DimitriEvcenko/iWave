//
//  WLCalendarViewLayout.h
//  iWave2
//
//  Created by Marco Lorenz on 06.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

/** In this class the layout for the iWave calendar is defined.
 The calendar is build as a collection view and has several cells. The cells do have the same size and are the items in the layout.
 To define an item it has properties like itemInsets or itemSize.
 To define the position of the items in the collection view properties like interIntemSpacing and numberOfColums are needed.
 The layout depends on the size of the collection view so it is designed flexible to each size. So changes of size and orientation can be handled easily with the calendar layout class.
 @see WLCalendarVC
 */
@interface WLCalendarViewLayout : UICollectionViewLayout

/**---------------------------------------------------------------------------------------
 * @name Managing the Items in Collection View
 *  ---------------------------------------------------------------------------------------
 */
/** The insets every item/ cell should have */
@property (nonatomic) UIEdgeInsets itemInsets;

/** The size of every item/ cell in collection view. */
@property (nonatomic) CGSize itemSize;

/**---------------------------------------------------------------------------------------
 * @name Positioning the Items in Collection View
 *  ---------------------------------------------------------------------------------------
 */
/** Tis property defines the space in y-axis between two items/ cells. */
@property (nonatomic) CGFloat interItemSpacingY;

/** The number of colums represent the weeks in the calendar. It has an influence on itemSize and items position in collection view. */
@property (nonatomic) NSInteger numberOfColumns;

@end
