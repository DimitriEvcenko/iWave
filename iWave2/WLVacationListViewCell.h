//
//  WLListViewCell.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLTableCellDesignCell.h"
#import "VacationDemand.h"

/** The instance of this class is a single table view cell.
 It is a common cell that displays a vacation demands start and end date and the duration.
 */
@interface WLVacationListViewCell : WLTableCellDesignCell

/**--------------------------------------------------------
 * @name Display a Vacation Demands Duration
 *--------------------------------------------------------
 */
/** The vacation demand that will be displayed in cell. */
@property (weak, nonatomic) VacationDemand *vacationDemand;

@end
