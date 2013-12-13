//
//  WLVacationDetailEditViewController.m
//  iWave2
//
//  Created by Alexander Eiselt on 22.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationDetailEditViewController.h"

@interface WLVacationDetailEditViewController ()

@end

@implementation WLVacationDetailEditViewController

/** Handling the configuration of the view controller in view did load. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureSubViews];
}

/**---------------------------------------------------------------------------------------
 * @name Configure the View
 *  ---------------------------------------------------------------------------------------
 */
/** This method adds the required view controllers to the container. */
-(void)configureSubViews{
    
    self.splittViewEmbedded = [[self storyboard]instantiateViewControllerWithIdentifier:@"splitView"];
    
    [self.container addSubview:self.splittViewEmbedded.view];
    
    [self sizeSubviews];
}

/** This method changes the size of views added to container to match to its size.
 @see configureSubViews
 */
-(void)sizeSubviews{
    
    CGFloat width = self.container.frame.size.width;
    CGFloat height = self.container.frame.size.height;
    
    self.splittViewEmbedded.view.frame = CGRectMake(0, 0, width, height);
    
    self.splittViewEmbedded.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}


@end
