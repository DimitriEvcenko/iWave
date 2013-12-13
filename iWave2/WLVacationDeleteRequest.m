//
//  WLVacationDeleteRequest.m
//  iWave2
//
//  Created by Alexander Eiselt on 08.08.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLVacationDeleteRequest.h"

@implementation WLVacationDeleteRequest

/** Creates and returns a new vacation delete request.
 @return An instance of vacation delete request. */
- (id)init
{
    self = [super init];
    if (self) {
        self.vacationId = @"";
        self.vacationStatus = @"";
        self.token = @"";
        self.locale = [[NSLocale alloc]initWithLocaleIdentifier:[[NSLocale preferredLanguages]objectAtIndex:0]];
    }
    return self;
}
@end
