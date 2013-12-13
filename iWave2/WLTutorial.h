//
//  WLTutorial.h
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLTutorialArrow.h"

/** The Tutorial class handles the tutorial for iWaves MiniApp Carribean.
 The Tutorial contains different steps and hello messages. 
 The View shown by the Tutorial is independend from the current view controller.
 */
@interface WLTutorial : NSObject{
    UIInterfaceOrientation _orientation;
    CGPoint _arrowPoint;
    CGPoint _arrowPointLandscape;
    CGPoint _arrowPointPortrait;
    CGPoint _textPoint;
    CGFloat _arrowAngel;
    CGFloat _length;
    int _step;
    BOOL _isStarted;
}

/**------------------------------------------------------------------------
 * @name Accessing Tutorial Properties
 *-------------------------------------------------------------------------
 */
/** A getter property to get the information about specific steps in the tutorial. */
@property (strong, nonatomic, getter = getDescription) NSString *description;


/**------------------------------------------------------------------------
 * @name Configure the Shared Tutorial Instance
 *-------------------------------------------------------------------------
 */
/** Return the shared instance of tho tutorial object
 @return The shared tutorial instance*/
+(WLTutorial*)sharedTutorial;

/**------------------------------------------------------------------------
 * @name Greetings to the User
 *-------------------------------------------------------------------------
 */
/** Display the greetings to the user. 
 @param orientation The device orientation to set the display to the rigth position. */
-(void)sayHelloToUserWith:(UIInterfaceOrientation)orientation;

/**------------------------------------------------------------------------
 * @name Doing the Tutorial
 *-------------------------------------------------------------------------
 */
/** Doing the next tutorial step. Specific display of tutorial arrow and text is done.
 @see WLTutorialArrow 
 @see doLastStep
 @see stepBack
 @see abortTutorial */
-(void)doNextStep;

/** Doing the last tutorial step. Specific display of tutorial arrow and text is done.
 @see WLTutorialArrow
 @see doNextStep
 @see stepBack
 @see abortTutorial */
-(void)doLastStep;

/** Doing one step back in the tutorial. Specific display of tutorial arrow and text is done.
@see WLTutorialArrow
 @see doNextStep
 @see doLastStep
 @see abortTutorial */
-(void)stepBack;

/** Doing all the things to end the tutorial. Remove arrow and text, update core date. 
 @see WLTutorialArrow
 @see FirstLaunch */
-(void)endTutorial;

/** Doing the abort step in the tutorial. After showing the abort text endTutorial is called.
 @see doNextStep
 @see doLastStep
 @see stepBack
 @see endTutorial */
-(void)abortTutorial;

/**---------------------------------------------------------------------------------------
 * @name Responding to View Rotation Events
 *  ---------------------------------------------------------------------------------------
 */
/** Change position of arrow and text on orientation changes. 
 @param orientation The orientation the tutorial elements should be shown. */
-(void)didChangeDeviceOrientationTo:(UIInterfaceOrientation)orientation;


@end
