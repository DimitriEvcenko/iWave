//
//  WLAppStyle.h
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** The class to define the applications appearance.
*/
@interface WLAppStyle : NSObject

/**--------------------------------------------------------------
*@name Designing the Application
*----------------------------------------------------------------
*/
/** The mehtod to design the appearance of controls in the application.

This method is used like a css file and called on launching the application.
*/
+(void)applyStyle;

@end
