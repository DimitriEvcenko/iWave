//
//  WLTableHeaderLabel.h
//  iWave2
//
//  Created by Marco Lorenz on 12.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The table header label class is used to design headers in table views. 
 Therefore the viewForHeaderInSection: method from table view data source has to be overwritten.
 The returning view in this method should have an object of this class as subview.
 */
@interface WLTableHeaderLabel : UILabel<WLDesignGuide>

@end
