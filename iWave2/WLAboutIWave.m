//
//  WLAboutIWave.m
//  iWave2
//
//  Created by Marco Lorenz on 03.05.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLAboutIWave.h"

@implementation WLAboutIWave

/**---------------------------------------------------------------------------------------
 * @name Initialization
 *  ---------------------------------------------------------------------------------------
 */
 /** To initialize a new object immediately after memory for it has been allocated.
 @return An initialized object.
 */
-(id)init{ 
    self = [super init];
    if(self){
        
    [self initWithValues];
        
    }
    return self;
}

/** Setting the properties of the model during init. */
-(void)initWithValues{
    self.name = @"iWave";
    self.version = @"Version 1.0";
    self.copyrigth = @"© 2013 sidion";
    self.description = @"Das ist die erste Version von iWave. \nHier kannst du wie in Karibik bekannt, \ndeinen Urlaub beantragen!";
    self.image = [[UIImage alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Sidion-iWave-144px" ofType:@"png"]];
}

@end
