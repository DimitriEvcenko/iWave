//
//  WLResponseDescriptor.m
//  iWave2
//
//  Created by Marco Lorenz on 20.06.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLResponseDescriptor.h"

#import "WLLoginResponse.h"
#import "WLMappingHelper.h"
#import "WLUserProfileResponse.h"
#import "WLVacationDemandListItem.h"
#import "WLVacationDemandListResponse.h"
#import "WLVacationDecisionResponse.h"
#import "WLVacationDeleteResponse.h"
#import "WLVacationDemandResponse.h"

@implementation WLResponseDescriptor

/** ---------------------------------------------------------------
 * @name Creating Response Descriptors
 *-----------------------------------------------------------------
 */
/** The methods creates an array of all needed response descriptors for iWave application.
 The respoinse descriptor contains the used mapping method and the triggering url-request.
 @return An array containing all needed response descriptors.
 @see WLMappingHelper
 */
+(NSArray*)responseDescritorsAsArray{
    
    NSMutableArray* descriptors = [[NSMutableArray alloc] init];
    
    //conifgure responseDescriptor for LoginResponse
    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[WLLoginResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createLoginResponseDictionary]];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:LOGIN_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    
    //configure responseDescriptor for Userdata
    mapping = [RKObjectMapping mappingForClass:[WLUserProfileResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createUserProfileResponseDicitionary]];
    
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:REQUEST_USER_PROFILE_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    
    //configure responseDescriptor for VacationDemandResponse
    mapping = [RKObjectMapping mappingForClass:[WLVacationDemandResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createVacationDemandResponseDicionary]];
    
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:REQUEST_VACATION_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    
    //configure responseDescriptor for VacationDemandList
    
    mapping = [RKObjectMapping mappingForClass:[WLVacationDemandListResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createVacationDemandListResponseDicitionary]];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:USER_VACATION_INFORMATION_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    
    //configure responseDescriptor for VacationDecision
    
    mapping = [RKObjectMapping mappingForClass:[WLVacationDecisionResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createVacationDecisionResponseDicionary]];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:DECIDE_VACATION_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    
    //configure responseDescriptor for VacationDelete
    
    mapping = [RKObjectMapping mappingForClass:[WLVacationDeleteResponse class]];
    [mapping addAttributeMappingsFromDictionary:[WLMappingHelper createVacationDeleteResponseDicionary]];
    responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping pathPattern:DELETE_VACATION_URL keyPath:nil statusCodes:nil];
    
    [descriptors addObject:responseDescriptor];
    return descriptors;
}
@end
