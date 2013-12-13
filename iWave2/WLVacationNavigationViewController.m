//
//  WLVacationNavigationViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 23.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationNavigationViewController.h"
#import "CommonSettings.h"
#import "WLTutorial.h"
#import "VacationDemand.h"
#import "WLMappingHelper.h"
#import "WLLoginResponse.h"
#import "WLAppDelegate.h"
#import "VacationDemandStatus.h"
#import "WLVacationDemandListItem.h"

@interface WLVacationNavigationViewController ()

@end

@implementation WLVacationNavigationViewController


/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing design on view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adaptStyle];
    [self.navigationController setNavigationBarHidden:NO];
}

/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method defines the appearance of the headers in the tab bar.
*/
-(void)adaptStyle{
    CommonSettings *commonSettings = [CommonSettings MR_findFirst];
    
    int design = [commonSettings.design intValue];
   
    NSDictionary *textAttributes = @{NSFontAttributeName: [WLColorDesign getFontNormal:design withSize:8.]};
    
    UITabBarItem *secondItem = [self.tabBar.items lastObject];
    [secondItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    secondItem.title = NSLocalizedString(@"Demand",@"");
    secondItem.imageInsets = UIEdgeInsetsZero;
    
    [((UIViewController*)[[self viewControllers] objectAtIndex:1]).view subviews];
    
    [super setTitel:NSLocalizedString(@"Vacation", @"Vacation") withDesign:design];
}

-(void)doLogout:(id)sender{
    [[WLTutorial sharedTutorial] abortTutorial];
    [super doLogout:sender];
}

-(void)showAbout:(id)sender{
    [[WLTutorial sharedTutorial] abortTutorial];
    [super showAbout:sender];
}

-(void)showNews:(id)sender{
    [[WLTutorial sharedTutorial] abortTutorial];
    [super showNews:sender];
}

@end
