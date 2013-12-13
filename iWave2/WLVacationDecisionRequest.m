//
//  WLVacationDecisionRequest.m
//  iWave2
//
//  Created by Marco Lorenz on 24.07.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationDecisionRequest.h"

@implementation WLVacationDecisionRequest

/** Creates and returns a new vacation decision request. 
 Initial the decision state is pending. 
 @return An instance of vacation decision request. */
-(id)init{
    
    self = [super init];
    if(self){
        self.vacationId = @0;
        self.locale = [[NSLocale alloc]initWithLocaleIdentifier:[[[NSBundle mainBundle]preferredLocalizations]objectAtIndex:0]];
        self.status = VS_PENDING;
        self.token = @"";
    }
    return self;
}

@end
