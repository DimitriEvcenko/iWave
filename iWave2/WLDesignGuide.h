//
//  WLDesignGuide.h
//  iWave2
//
//  Created by Marco Lorenz on 07.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The design guide protocol should concentrate special design changes in every view controler in one method.
 Changes in design should be managed with this protocol.*/
@protocol WLDesignGuide <NSObject>

/** ---------------------------------------------------------------
 * @name Do the Design
 *-----------------------------------------------------------------
 */
/** The adapt style method should be called in every view controller to do additional design to the app style
 @see WLAppStyle*/
-(void)adaptStyle;

@optional
/** ---------------------------------------------------------------
 * @name Change the Design
 *-----------------------------------------------------------------
 */
/** The did change design method should be called when design settings have changed.
 It is called by notification named DESIGN_NOTIFICATION.
 @see CommonSettings*/
//-(void)didChangeDesign;

@end
