//
//  WLVacationTypeViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 03.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLVacationDemandProtocol.h"

/** The vacation type view controller shows a table in wich all possible vacartion demand types are displayed in different cells.
 Only one cell can be selected. Change of selection can be delegated to parent view.
 The view controller is used to change vacation demand status in WLVacationDetailViewController.
 */
@interface WLVacationTypeViewController : UITableViewController <WLDesignGuide, WLVacationDemandProtocol>

/**--------------------------------------------------------
 *@name Handle the Delegate
 *---------------------------------------------------------
 */
/** The delegate to handle changes on selection in table view. */
@property (strong, nonatomic) id<WLVacationDemandProtocol> delegate;

@end
