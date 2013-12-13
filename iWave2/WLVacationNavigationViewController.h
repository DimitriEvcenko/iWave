//
//  WLVacationNavigationViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLNavigationBaseTabBar.h"


/** The vacation navigation view controller handles the calendar view an the vacation detail view as tab view controller.
 In addition to the navigation concept of iWave the controller only defines the appearance of the tab bar items.
 @see WLNavigationProtocol
 */
@interface WLVacationNavigationViewController : WLNavigationBaseTabBar <WLDesignGuide>

@end
