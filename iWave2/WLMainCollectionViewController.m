//
//  WLMainCollectionViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLMainCollectionViewController.h"
#import "WLMainCell.h"
#import "WLMiniApp.h"
#import "User.h"
#import "WLAppDelegate.h"
#import "WLUserProfileResponse.h"
#import "LoginSettings.h"
#import "VacationDemand.h"
#import "VacationDemandStatus.h"
#import "VacationDemandType.h"
#import "WLVacationDemandListItem.h"
#import "WLMappingHelper.h"
#import "VacationDemandLocal.h"
#import "Teammate.h"
#import "WLVacationRest.h"
#import "WLTutorial.h"
#import "FirstLaunch.h"

@interface WLMainCollectionViewController ()

/**-------------------------------------------------------------------------------------
 * @name The iWave MiniApps
 *---------------------------------------------------------------------------------------
 */
/** An array of all mini apps that are deveoped in IWave */
@property (nonatomic, strong) NSMutableArray *components;

@end

@implementation WLMainCollectionViewController

/**-------------------------------------------------------------------------------------
 * @name Responding to View Events
 *---------------------------------------------------------------------------------------
 */
/** Doing some configuration before showing the main menu.
 @param animated If YES, the view is being added to the window using an animation.
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [super adaptStyle];
    self.componentsLayout.orientation = self.interfaceOrientation;
    [self.collectionView reloadData];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationItem setHidesBackButton:YES];
}

/**-------------------------------------------------------------------------------------
 * @name Managing the View
 *---------------------------------------------------------------------------------------
 */
/** Doing some basic configuration on the controller after loding. */
- (void)viewDidLoad
{
    if(UIInterfaceOrientationIsLandscape(self.interfaceOrientation))
        self.componentsLayout.orientation = self.interfaceOrientation;
    
    [super viewDidLoad];
    
    
    self.collectionView.delegate = self;
    
    //[self.navigationController setNavigationBarHidden:NO];
    //[self.navigationItem setHidesBackButton:YES];
        
    self.components = [NSMutableArray array];
    
    //Mini-Apps erstellen!!!
    for (NSInteger i = 0; i < APP_COUNT; i++){
        
        WLMiniApp *app = [WLMiniApp createWithNumber:i];
        [self.components addObject:app];
    }
    
    [self.collectionView registerClass:[WLMainCell class]forCellWithReuseIdentifier:MainCellIdentifier];
    
       
    [[WLTutorial sharedTutorial]sayHelloToUserWith:self.interfaceOrientation];
    [super adaptStyle];

}

#pragma mark - Collection View

/**-----------------------------------------------------------------------------------
 * @name Collection View: Getting Item and Section Metrics
 *  ----------------------------------------------------------------------------------
 */
/** Determines the number of sections in the collection view by counting the available mini apps.
 @param collectionView The collectioView requesting this information.
 @return The number of sections in collectionView.
 */
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.components.count;
}

/** Asks the data source for the number of items in the specified section. (required)
 @param collectionView The collectioView requesting this information.
 @param section An index number identifying a section in collectionView. This index value is 0-based.
 @return The number of rows in section. (Always 1)
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

/**-----------------------------------------------------------------------------------
 * @name Getting Views for Items
 *  ----------------------------------------------------------------------------------
 */
/** Asks the data source for the cell that corresponds to the specified item in the collection view. (required)
 The mini app object is displayed in the cell.
 @param collectionView The collectioView requesting this information.
 @param indexPath The index path that specifies the location of the item.
 @return A configured cell object.
 @see WLMainCell
 @see WLMiniApp
 */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLMainCell *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:MainCellIdentifier forIndexPath:indexPath];
        
    WLMiniApp *app = self.components[indexPath.section];
    
    mainCell.imageView.image = [app image];
    mainCell.nameLabel.text = [app name];

    CGPoint point = [collectionView convertPoint:collectionView.frame.origin toView:[[UIApplication sharedApplication]keyWindow]];
    [mainCell createAccessibilityLabelWithOrigin:point andInterfaceOrientation:self.interfaceOrientation];

    //[mainCell adaptStyle];
    
    NSLog(@"Create MiniApp: %@ on Cellnr.: %i",[app name], indexPath.section);
    
    return mainCell;
}

#pragma mark - Responding to View Rotation Events
/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** Sent to the view controller before the user interface rotates. Layout and tutorial elements are adapted.
 @param toInterfaceOrientation The new orientation of the user interface.
 @param duration The duration of the pending rotation, measured in seconds.
 */
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                duration:(NSTimeInterval)duration
{
    self.componentsLayout.orientation = toInterfaceOrientation;
    [[WLTutorial sharedTutorial] didChangeDeviceOrientationTo:toInterfaceOrientation];
}

/** Sent to the view controller after the user interface rotates.
 Collection view is reloaded.
 @param fromInterfaceOrientation The old orientation of the user interface.
 */
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.collectionView reloadData];
}

#pragma mark - Managing the Selected Cells
/**---------------------------------------------------------------------------------------
 * @name Managing the Selected Cells
 *  ---------------------------------------------------------------------------------------
 */
/** Called when a mini app cell is selected. Handling the segue to perform.
 @param collectionView The collection view object that is notifying you of the selection change.
 @param indexPath The index path of the cell that was selected.
 */
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int nu = indexPath.section;
    
    switch (nu) {
        case SETTINGS:
            [self performSegueWithIdentifier:@"showSettings" sender:self];
            break;
        case VACATION:
            [self performSegueWithIdentifier:@"showVacation" sender:self];
            break;
        case MARKETPLACE:
            [self performSegueWithIdentifier:@"showMarketplace" sender:self];
            break;
        default:
            NSLog(@"No App defined yet!");
            break;
    }    
}

#pragma - mark Doing the Tutorial
/**--------------------------------------------------------
 *@name Doing the Tutorial
 *---------------------------------------------------------
 */
/** On preparing to leave the view controller tutorial is continued or aborted when already started.
 @param segue The segue object containing information about the view controllers involved in the segue.
 @param sender The object, that initiated the segue.
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showVacation"])
        [[WLTutorial sharedTutorial] doNextStep];
    else
        [[WLTutorial sharedTutorial] abortTutorial];
}

/** On start this method is called. It says hello to user and starts the tutorial if session is the first launch. */
-(void)doTutorialFromBeginning{
    
    [self.myPopOver dismissPopoverAnimated:YES];
    [[WLTutorial sharedTutorial] sayHelloToUserWith:self.interfaceOrientation];
    self.tutorialTaps.enabled = true;
}

/** Tap action on tapping on the collection view.
 This action initializes the next step of the tutorial. After doing this the tutorialTabs is enabled.
 @param sender The tap gesture recognizer that caused the tap event.
 */
- (IBAction)tapOnView:(UITapGestureRecognizer *)sender {
    
    [[WLTutorial sharedTutorial] doNextStep];
    self.tutorialTaps.enabled = false;
}
@end
