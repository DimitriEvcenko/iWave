//
//  WLSettingsModel.m
//  iWave2
//
//  Created by Marco Lorenz on 08.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLSettingsModel.h"
#import "User.h"
#import "WLAppDelegate.h"


@implementation WLSettingsModel

@synthesize settings;

/**---------------------------------------------------------------------------------------
 * @name Initiakize a Settings Model
 *  ---------------------------------------------------------------------------------------
 */
/** Doing the initialization of a model.
 @return An object from type setting model.
 */
-(id)init{
    self= [super init];
    if(self){
        [self setTheSettings];
    }
    return self;
}

/**---------------------------------------------------------------------------------------
 * @name Getting Setting Descriptons
 *  ---------------------------------------------------------------------------------------
 */
/** The settings array contains two strings for the two different settings options. */
-(void)setTheSettings{
    
    User *user = [User MR_findFirstByAttribute:USERID withValue:session.sessionUserId];
    
    settings = [NSMutableArray arrayWithObjects:NSLocalizedString(@"LoginSettings", @"LoginSettings"),
                NSLocalizedString(@"ProfileSettings", @"ProfileSettings"),
                user.department, nil ];
}

/** The design settings array contains all strings to describe desing options.
 @return An array containing the string to describe designs. */
+(NSArray*)setTheDesginSettings{    
    return [NSMutableArray arrayWithObjects:NSLocalizedString(@"SidionLight", @"SidionLight"),
                NSLocalizedString(@"SidionDark", @"SidionDark"),
                NSLocalizedString(@"SidionBlue", @"SidionBlue"),
                NSLocalizedString(@"SidionSand", @"SidionSand"),nil];
}

/** The usability settings array contains all strings to describe usability options.
 @return An array containing the string to describe usability. */
+(NSArray*)setTheUsabilitySettings{
    return [NSMutableArray arrayWithObjects:NSLocalizedString(@"Buttons", @"Buttons"),
                NSLocalizedString(@"Gestures", @"Gestures"),
                NSLocalizedString(@"ButtonsAndGestures", @"ButtonsAndGestures"),nil];
}

@end
