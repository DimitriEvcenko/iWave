//
//  WLNewsViewController.m
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLNewsViewController.h"
#import "NewsMessages.h"
#import "CommonSettings.h"
#import "WLAppDelegate.h"


@interface WLNewsViewController ()
/**------------------------------------------------------------------------
 * @name Handle Animation.
 *-------------------------------------------------------------------------
 */
/** The current point describes the center of the news view during pan gesture. */
@property CGPoint currentPoint;

/** The origin point is the center the news view should always return to after doing animation. */
@property CGPoint originPoint;

@end

@implementation WLNewsViewController


/**---------------------------------------------------------------------------------------
 * @name Managing the View
 *  ---------------------------------------------------------------------------------------
 */
/** Doing some additional configuration on viewDidLoad. */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self adaptStyle];
        
    self.messages = [NewsMessages MR_findByAttribute:@"userId" withValue:session.sessionUserId];
    self.pageControl.numberOfPages = [self.messages count];
    self.selectedPage = 0;
    
    if([self.messages count]==0){
        self.pageControl.numberOfPages =1;
        
        return;
    }
    
    [self showMessage];
    
}

/**---------------------------------------------------------------------------------------
 * @name Responding to View Events
 *  ---------------------------------------------------------------------------------------
 */
/** Setting the origin point on view appearance.
 @param animated True when view did appear animated.
 */
-(void)viewDidAppear:(BOOL)animated{    
    self.originPoint = self.view.center;
}

/**------------------------------------------------------------------------
 * @name Display the Messages.
 *-------------------------------------------------------------------------
 */
/** Displaying the selected message in the controls. */
-(void)showMessage{
    
    if([self.messages count]==0)
        return;
    
    self.pageControl.currentPage = self.selectedPage;
    
    NewsMessages *theMessage = (NewsMessages*)[self.messages objectAtIndex:self.selectedPage];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    self.dateText.text = [dateFormatter stringFromDate:theMessage.receivedDate];
    self.contentText.text = theMessage.msgText;
    
    theMessage.alreadyRead = [[NSNumber alloc] initWithBool:YES];
}


/** On changing the selected page control, the displayed message is changed.
 @param sender The page control that ahs been changed.
 */
- (IBAction)pageControlChanged:(id)sender {
    self.selectedPage = self.pageControl.currentPage;
    [self showMessage];
}

/** On panning over the view messages can be changed animated.
 @param sender A pan gesture recognizer to describe the pan gesture.
 */
- (IBAction)panNews:(UIPanGestureRecognizer *)sender {
    
    CGPoint translation = [sender translationInView:self.view];
    self.currentPoint = CGPointMake(sender.view.center.x + translation.x, sender.view.center.y);
    
    if(sender.state == UIGestureRecognizerStateEnded)
    {
        if(self.originPoint.x < self.currentPoint.x)
           [self completeAnimationToRight:YES];
        else
            [self completeAnimationToRight:NO];
    }
    else{
        //set new Point for Translation
        sender.view.center = self.currentPoint;
        [sender setTranslation:CGPointMake(0, 0) inView:self.view];
    }
}

/**------------------------------------------------------------------------
 * @name Handle Animation.
 *-------------------------------------------------------------------------
 */
/** This methods checks if a thresholdvalue on moving the news view is achieved.
 If it is the method finishes a started animation. Otherwise it removes the news view to origin.
 
 The threshold value is achieved, when the collectionView is moved half of the news views width.
 
 @param right Yes if the animation should finish to the rigth side.
 */
-(void)completeAnimationToRight: (bool)right{
    
    CGFloat distance = self.originPoint.x - self.currentPoint.x;
    CGFloat thresholdValue = self.originPoint.x*2./2.;
    
    //check the Animationdirection
    if(right)
        distance *= -1;
    
    //threshold Value?
    bool completeAnimation = (distance > thresholdValue);
    
    //reset Animation, when not existing Message selected
    if((right && self.selectedPage == 0)||(!right && self.selectedPage == [self.messages count]-1))
        completeAnimation = false;
    
    if(!completeAnimation){
        //reset to StartView
        [UIView animateWithDuration: 0.5 animations:^{
            [self.view setCenter:self.originPoint];
        }];
    }
    else{        
        if(right){
            self.selectedPage--;
            CGPoint newCurrent = CGPointMake(0 - self.originPoint.x, self.currentPoint.y);
            self.currentPoint = newCurrent;
        }
        else{
            self.selectedPage++;
            CGPoint newCurrent = CGPointMake(3*self.originPoint.x, self.currentPoint.y);
            self.currentPoint = newCurrent;
        }
        [self.view setCenter:self.currentPoint];
        //insert new Message
        
        [UIView animateWithDuration: 0.5 animations:^{
            [self.view setCenter:self.originPoint];
        }];
        
        [self showMessage];
    }
}

#pragma mark - Design Protocol
/**---------------------------------------------------------------------------------------
 * @name Designing the View
 *  ---------------------------------------------------------------------------------------
 */
/** This Method handles special designed controls on news view controller */
-(void) adaptStyle{
    CommonSettings *cSettings = [CommonSettings MR_findFirst];
    
    int design = [cSettings.design intValue];
    
    //redraw table View
    [self.tableView setBackgroundView:nil];
    self.tableView.backgroundView = [[UIView alloc]init];
    self.tableView.backgroundView.backgroundColor = [WLColorDesign getMainBackgroundColor:design];
        
    self.dateText.backgroundColor = [WLColorDesign getSecondBackgroundColor:design];
}

@end
