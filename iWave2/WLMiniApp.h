//
//  WLMiniApp.h
//  iWave2
//
//  Created by Marco Lorenz on 25.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** This class describes the model of an available mini app in iWave. 
 A mini app contains one functionality of wave. An object of this class describes the name and a navigation image of the mini app.
 In the current state of development there are two mini apps:
 
    - Base App
    - Vacation App
 
 */
@interface WLMiniApp : NSObject

/**---------------------------------------------------------------------------------------
 * @name Managing Mini Apps Properties
 *  ---------------------------------------------------------------------------------------
 */
/** The displayed name of the mini app. */
@property (nonatomic, strong) NSString *name;

/** The displayed image of the mini app. */
@property (nonatomic, strong) UIImage *image;


/**---------------------------------------------------------------------------------------
 * @name Creating a Mini App
 *  ---------------------------------------------------------------------------------------
 */
/** Creates a mini app object with a number. The used numbers are limited to the number of developed mini apps.
 The number is defined in WLConstants.
 @param number The defined number of the mini app.
 @see WLConstants
 @return A mini app object.
 */
+(WLMiniApp *) createWithNumber: (int)number;

@end
