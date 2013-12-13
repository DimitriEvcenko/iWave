//
//  LoginSettings.h
//  iWave2
//
//  Created by Marco Lorenz on 10.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** This class handles the iWave LoginSettings.
 
 This class is to persist in core data. An instance of LoginSettings is a singleton and is overwritten when changed.
 There are three values to make autologin possible. To get login access there are password an userId.
 To determine autologin rememberMe is used.
 */
@interface LoginSettings : NSManagedObject

/**---------------------------------------------------------------------------------------
 * @name Persist the Login Data
 *  ---------------------------------------------------------------------------------------
 */
 /** Password is the users secret login key.
 */
@property (nonatomic, retain) NSString * password;

/** ReamemberMe is a bool value to decide to do autologin with LoginSettings or to show WLLoginViewController.
*/
@property (nonatomic, retain) NSNumber * rememberMe;

/** UserId it the users login name for wave intranet.
*/
@property (nonatomic, retain) NSString * userId;

@end
