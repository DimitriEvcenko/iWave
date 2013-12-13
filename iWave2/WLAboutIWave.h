//
//  WLAboutIWave.h
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Modelclass to show iWaves version details.

Instances are not persisted. Versiondetails are created in init.
*/
@interface WLAboutIWave : NSObject

/**---------------------------------------------------------------------------------------
 * @name IWaves model Information.
 *  ---------------------------------------------------------------------------------------
 */
/** The name of the application: iWave.
*/
@property (nonatomic, strong) NSString *name;

/** The version number of the application.
*/
@property (nonatomic, strong) NSString *version;

/** The applications copyright information.
 */
@property (nonatomic, strong) NSString *copyrigth;

/** The applications description.
 */
@property (nonatomic, strong) NSString *description;

/** The applications displayed image.
*/
@property (nonatomic, strong) UIImage *image;

@end
