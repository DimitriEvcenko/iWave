//
//  WLVacationDetailEditViewController.h
//  iWave2
//
//  Created by Alexander Eiselt on 22.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

/** This Controller handles the splitt view on vacation tab view controller.
 The view shows the details for vacation demands in a splitt view and is shown in a container.
 */
@interface WLVacationDetailEditViewController : UIViewController

/** The container the detail splitt view is displayed in. */
@property (strong, nonatomic) IBOutlet UIView *container;

/** The splitt view shown in the container. */
@property (strong, nonatomic) UISplitViewController *splittViewEmbedded;
@end
