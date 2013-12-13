//
//  FirstLaunch.h
//  iWave2
//
//  Created by Marco Lorenz on 26.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

/** An instance of this class is persisted in core data. On first launch or on replaying the tutorial the only property is set to YES.
 So the object is not bound to a user and it shows if the application is started for the first time.
 */
@interface FirstLaunch : NSManagedObject

/** This number represents a bool value. NO is the normal state in using the app. It is only YES on first lauch or on replaying the tutorial. */
@property (nonatomic, retain) NSNumber * isFirstLaunch;

@end
