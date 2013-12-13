//
//  WLSettingsNavigationViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSettingsNavigationViewController.h"
#import "CommonSettings.h"
#import "WLSettingsMasterController.h"

@interface WLSettingsNavigationViewController ()

@end

@implementation WLSettingsNavigationViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeDesign) name:DESIGN_NOTIFICATION object:nil];
}

#pragma mark -Design Protocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Redraw the controls on changes in design. */
-(void)didChangeDesign{
    [super initButtons];
    [self adaptStyle];
}

/** This Method sets the title in navigation bar. */
-(void)adaptStyle{

    [super adaptStyle];
    
    CommonSettings *commonSettings = [CommonSettings MR_findFirst];
    
    int design = [commonSettings.design intValue];
    
    [super setTitel:NSLocalizedString(@"Settings", @"Settings") withDesign:design];
    
}
@end
