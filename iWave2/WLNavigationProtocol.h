//
//  WLNavigationProtocol.h
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The navigation protocol is created to define base navigation in iWave application.
 Base navigation means the possibility to use some functionality from every view.
 */
@protocol WLNavigationProtocol <NSObject>

/**--------------------------------------------------------
 * @name Doing Base Navigation
 *  --------------------------------------------------------
 */
/** Called to do the logout and moving to login view controller.
 @param sender A logout bar button item.
 */
-(void)doLogout:(id)sender;

/** Called to show the about view controller as popover.
 @param sender A show about bar button item.
 @see WLAboutViewController
 */
-(void)showAbout:(id)sender;

/** Called to show the news view controller as popover.
 @param sender A news messages bar button item.
 @see WLNewsViewController
 */
-(void)showNews:(id)sender;

@end
