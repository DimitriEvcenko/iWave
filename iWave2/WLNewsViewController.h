//
//  WLNewsViewController.h
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <UIKit/UIKit.h>

/** The news view controller deisplays news messages user gets from login response.
 Page Control and a pan gesture recognizer enable the navigation throug the different messages.
 */
@interface WLNewsViewController : UITableViewController <WLDesignGuide>

/**------------------------------------------------------------------------
 * @name Managing the Messages.
 *-------------------------------------------------------------------------
 */
/** An array that contains all of the users messages. */
@property NSArray *messages;

/** The index of the selected page in the messages array. */
@property (nonatomic) int selectedPage;

/**------------------------------------------------------------------------
 * @name Display the Messages.
 *-------------------------------------------------------------------------
 */
/** The page control displays the amount of messages an the displayed message. */
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/** The textfield the receiving of a message is displayed. */
@property (weak, nonatomic) IBOutlet UITextField *dateText;

/** The content of the message is shown in the content text view. */
@property (weak, nonatomic) IBOutlet UITextView *contentText;


/**------------------------------------------------------------------------
 * @name Change displayed Messages.
 *-------------------------------------------------------------------------
 */
/** On changing the selected page control, the displayed message is changed.
 @param sender The page control that ahs been changed.
 */
- (IBAction)pageControlChanged:(id)sender;

/** On panning over the view messages can be changed animated.
 @param sender A pan gesture recognizer to describe the pan gesture.
 */
- (IBAction)panNews:(UIPanGestureRecognizer *)sender;

@end
