//
//  WLTutorial.m
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLTutorial.h"
#import "WLAppDelegate.h"
#import "WLMainCollectionViewController.h"
#import "WLCalendarVC.h"
#import "FirstLaunch.h"
#import "VacationDemand.h"
#import "User.h"
#import "WLCalendarOperations.h"

#define APP_WINDOW  (((WLAppDelegate *)[[UIApplication sharedApplication] delegate]).window)


@implementation WLTutorial

@synthesize description = _description;

static WLTutorial *_sharedTutorial;

/**------------------------------------------------------------------------
 * @name Configure the Shared Tutorial Instance
 *-------------------------------------------------------------------------
 */
/** Return the shared instance of tho tutorial object
 @return The shared tutorial instance*/
+(WLTutorial*)sharedTutorial{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedTutorial = [[WLTutorial alloc]init];
        _sharedTutorial.description = [NSString stringWithFormat:@"%@%@\n\n%@",NSLocalizedString(@"HelloUser", @""),session.displayName, NSLocalizedString(@"GettingStarted", @"")];
    });
    return _sharedTutorial;
}

/**------------------------------------------------------------------------
 * @name Greetings to the User
 *-------------------------------------------------------------------------
 */
/** Display the greetings to the user.
 @param orientation The device orientation to set the display to the rigth position. */
-(void)sayHelloToUserWith:(UIInterfaceOrientation)orientation{
    
    NSDate *today =[[NSDate alloc]init];
    
    _orientation = orientation;
    _step = 1;
    
    _textPoint = [self center];
    
    //Change Description after/ in Vacation, After long time without login and after initial login
    FirstLaunch *firstLaunch = [FirstLaunch MR_findFirst];
    
    if(!firstLaunch){
        firstLaunch = [FirstLaunch MR_createInContext:[NSManagedObjectContext MR_contextForCurrentThread]];
        firstLaunch.isFirstLaunch = [NSNumber numberWithBool:YES];
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    }
    
    NSString *hello = NSLocalizedString(@"HelloUser", @"");
    hello = [hello stringByReplacingOccurrencesOfString:@"{0}" withString:session.displayName];
    
    if([firstLaunch.isFirstLaunch boolValue])
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"GettingStarted", @"")];
    else if([WLCalendarOperations isVacationDay:today])
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"VacationInVacation", @"")];
    else if([WLCalendarOperations dateIsWeekAfterVacation:today])
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"GreatVacationQuestion", @"")];
    else if([WLCalendarOperations dateIsWeekBeforeVacation:today])
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"GreatVacationWishes", @"")];
    else if([WLCalendarOperations daysSinceLastLogin:today]>180)
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"HalfYearWithoutiWave", @"")];
    else if([WLCalendarOperations daysSinceLastLogin:today]>60)
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"OneMonthWithoutiWave", @"")];
    else if([WLCalendarOperations daysSinceLastLogin:today]>14)
        _description = [NSString stringWithFormat:@"%@\n\n%@",hello, NSLocalizedString(@"OneWeekWithoutiWave", @"")];
    else
         _description = [NSString stringWithFormat:@"%@",hello];
    
    [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:5.0];
}


/**------------------------------------------------------------------
 * @name Doing the Tutorial
 *-------------------------------------------------------------------
 */
/** Starts the tutorial when greetings ended by user.
 @param orientation The orientation the tutorial elements should be shown.
 */
-(void)startTutorialWith:(UIInterfaceOrientation)orientation{
    _step = 2;
    _orientation = orientation;
    _arrowAngel = 63;
    _arrowPointPortrait = CGPointMake(360, 220);
    _arrowPointLandscape = CGPointMake(360, 220);
    [self setTheArrowPoint];
    _length = 80.;
    _isStarted = true;
    _description = NSLocalizedString(@"FirstStep", @"");
    _textPoint = CGPointMake(360, 360);
    [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:1];
    _step = 3;
    sleep(0.5);
    [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
   
}

/** Doing the next tutorial step. Specific display of tutorial arrow and text is done.
 @see WLTutorialArrow
 @see doLastStep
 @see stepBack
 @see abortTutorial */
-(void)doNextStep{
    
    FirstLaunch *firstLaunch = [FirstLaunch MR_findFirst];
    
    if(_isStarted){
        switch (_step) {
            case 1:
            case 2:
            case 3:
                //first Vacation cell
                _description = NSLocalizedString(@"SecondStep", @"");
                _textPoint = CGPointMake(550, 400);
                _arrowPointPortrait = CGPointMake(240, 750);
                _arrowPointLandscape = CGPointMake(250, 560);
                [self setTheArrowPoint];
                _arrowAngel = -35.0;
                _length = 120.;
                [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:1];
                [[WLTutorialArrow sharedTutorialArrow] showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
                _step = 4;
                break;
            case 4:
                //second Vacation cell
                _description = NSLocalizedString(@"ThirdStep", @"");
                _textPoint = CGPointMake(550, 400);
                _arrowPointPortrait = CGPointMake(580, 750);
                _arrowPointLandscape = CGPointMake(750, 560);
                [self setTheArrowPoint];
                _arrowAngel = 35.0;
                _length = 180.;
                [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:1];
                [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
                _step = 5;
                break;
            case 5:
                //Change Vacation Type
                _description = NSLocalizedString(@"FourthStep", @"");
                _textPoint = CGPointMake(200, 380);
                _arrowPointPortrait = CGPointMake(580, 310);
                _arrowPointLandscape = CGPointMake(720, 190);
                [self setTheArrowPoint];
                _arrowAngel = 95.0;
                _length = 120.;
                [[WLTutorialArrow sharedTutorialArrow] removeArrowAnimated:NO];
                [[WLTutorialArrow sharedTutorialArrow] removeTextAnimated:NO];
                [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:0.2];
                [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
                _step = 6;
                break;
            case 6:
                //Write comment
                _arrowPointPortrait = CGPointMake(580, 500);
                _arrowPointLandscape = CGPointMake(720, 350);
                [self setTheArrowPoint];
                _arrowAngel = -65.0;
                _length = 160.;
                [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
                _step = 7;
                break;
            case 7:
                //Demand for vacation
                _description = NSLocalizedString(@"LastStep", @"");
                _textPoint = CGPointMake(200, 380);
                _arrowPointPortrait = CGPointMake(620, 240);
                _arrowPointLandscape = CGPointMake(750, 120);
                [self setTheArrowPoint];
                _arrowAngel = 85.0;
                _length = 80.;
                [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:0.2];
                [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:_orientation length:_length];
                _step = 8;
                break;
            case 8:
                [self doLastStep];
            default:
                [self endTutorial];
                break;
        }
    }
    else{
        if([firstLaunch.isFirstLaunch boolValue]){
            //doing the Tutorial
            [self startTutorialWith:_orientation];
        }
        else{
            //end the Tutorial
            [self endTutorial];
        }
    }
   
}

/** Doing the last tutorial step. Specific display of tutorial arrow and text is done.
 @see WLTutorialArrow
 @see doNextStep
 @see stepBack
 @see abortTutorial */
-(void)doLastStep{
    //Demand for vacation
    
    if(_isStarted){
        _description = NSLocalizedString(@"TutorialFinished", @"");
    _textPoint = CGPointMake(550, 380);
    [[WLTutorialArrow sharedTutorialArrow] removeArrowAnimated:NO];
    [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:0.2];
    _step = 9;
    }
}

/** Doing one step back in the tutorial. Specific display of tutorial arrow and text is done.
 @see WLTutorialArrow
 @see doNextStep
 @see doLastStep
 @see abortTutorial */
-(void)stepBack{
    
    if(_isStarted){
        
        _step -= 2;
        
        _step = _step < 0 ? 0 : _step;
        
        [self doNextStep];
        
    }
}

/** Doing all the things to end the tutorial. Remove arrow and text, update core date.
 @see WLtutorialArrow
 @see FirstLaunch */
-(void)endTutorial{
    
    _isStarted = false;
    [[WLTutorialArrow sharedTutorialArrow] removeTextAnimated:NO];
    [[WLTutorialArrow sharedTutorialArrow] removeArrowAnimated:NO];
    
    FirstLaunch *firstLaunch = [FirstLaunch MR_findFirst];
    
    firstLaunch.isFirstLaunch = [NSNumber numberWithBool: NO];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
}

/** Doing the abort step in the tutorial. After showing the abort text endTutorial is called.
 @see doNextStep
 @see doLastStep
 @see stepBack
 @see endTutorial */
-(void)abortTutorial{
    //Abort text
    if(_isStarted){
        
        if(_step==9)
           [self endTutorial];
        else{
            _description = NSLocalizedString(@"TutorialAbort", @"");
            _textPoint = CGPointMake(550, 380);
            [[WLTutorialArrow sharedTutorialArrow] removeArrowAnimated:NO];
            [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:0.2];
        
            [self endTutorial];
        
            UIAlertView *aView = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"AbortHeader", @"Abort message") message:_description delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
            [aView show];
        }
    }
    else if([[WLTutorialArrow sharedTutorialArrow]isDisplayedText]){
        [self endTutorial];
    }

}

/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** Change position of arrow and text on orientation changes.
 @param orientation The orientation the tutorial elements should be shown. */
-(void)didChangeDeviceOrientationTo:(UIInterfaceOrientation)orientation{
    
    _orientation = orientation;
    
    if([[WLTutorialArrow sharedTutorialArrow] isDisplayedArrow]){
        [self setTheArrowPoint];

            [[WLTutorialArrow sharedTutorialArrow]showArrowInWindow:APP_WINDOW atPoint:_arrowPoint atAngle:_arrowAngel inOrientation:orientation length:_length];
    }
    
    if(_description&&[[WLTutorialArrow sharedTutorialArrow] isDisplayedText]){
            [[WLTutorialArrow sharedTutorialArrow] showTextInWindow:APP_WINDOW atPoint:_textPoint inOrientation:_orientation withText:_description andDuration:0];
    }
    
    if(_step == 9)
        [self endTutorial];
}

/** Setting the arrow startpoint in dependency to the device orientation. */
-(void)setTheArrowPoint{
    switch (_orientation) {
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:
            _arrowPoint = _arrowPointLandscape;
            break;
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:
            _arrowPoint = _arrowPointPortrait;
            break;
    }

}

/**---------------------------------------------------------------------------------------
 * @name Some Screen Stuff
 *  ---------------------------------------------------------------------------------------
 */
/** Get the screen center for the tutorial orientation property.
 Therefor the coordinate system is fixed in the upper left corner of the device. 
 X-axis is always to the right and y-axis is always to the bottom.
 @return The center point in the screen. */
-(CGPoint)center{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    if( UIInterfaceOrientationIsLandscape(_orientation))
        return CGPointMake(screenBounds.size.height/2., screenBounds.size.width/2.);
    
    return CGPointMake(screenBounds.size.width/2., screenBounds.size.height/2.);
}
@end
