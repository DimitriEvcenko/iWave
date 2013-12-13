//
//  WLMainCollectionViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLMainCollectionVIewLayout.h"
#import "WLNavigationViewController.h"

/** The main collection view comtroller handles navigation through iWaves mini apps.
 Additional it is the start view controller for the tutroial.
 That tutorial can work without failure, the view controller should only be left with segue.
 */
@interface WLMainCollectionViewController : WLNavigationViewController <UICollectionViewDelegate>

/**--------------------------------------------------------
 *@name Doing the Layout
 *---------------------------------------------------------
 */
/** This is the instance of the collection views layout. */
@property (weak, nonatomic) IBOutlet WLMainCollectionVIewLayout *componentsLayout;

/**--------------------------------------------------------
 *@name Doing the Tutorial
 *---------------------------------------------------------
 */
/** The tap gesture recognizer to handle tap events on collection view.*/
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tutorialTaps;

/** Tap action on tapping on the collection view.
 This action initializes the next step of the tutorial. After doing this the tutorialTabs is enabled. 
@param sender The tap gesture recognizer that caused the tap event.
 */
- (IBAction)tapOnView:(UITapGestureRecognizer *)sender;

@end
