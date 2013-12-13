//
//  WLMainCollectionVIewLayout.h
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const MainCellIdentifier = @"MainCell";

/** In this class the layout for the iWave mainmenu is defined.
The mainmenu is build as a collection view and has several cells. The cells do have the same size and are the items in the layout.
To define an item it has properties like itemInsets or itemSize.
To define the position of the items in the collection view properties like interIntemSpacing and numberOfColums are needed.
@see WLMainCollectionViewController
*/
@interface WLMainCollectionVIewLayout : UICollectionViewLayout

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

/** The number of colums represented in the collection view. */
@property (nonatomic) NSInteger numberOfColumns;

/** The orientation of the layout defines the number of cells in a row. */
@property (nonatomic) UIInterfaceOrientation orientation;

@end
