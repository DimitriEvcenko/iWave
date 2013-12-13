//
//  WLMappingHelper.m
//  iWave2
//
//  Created by Marco Lorenz on 24.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import "WLMappingHelper.h"


@implementation WLMappingHelper


/**---------------------------------------------------------
 * @name Map the received data to NSDictionary
 *----------------------------------------------------------
 */
/** Creates a base response dictionary for mapping rest kit mapping result to base response
 @return A base response dictionary.
 @see WLBaseResponse*/
+(NSDictionary*)createBaseResponseDictionary{
    return @{
             @"errorMessagesList" : @"errMsgs",
             @"infoMessagesList" : @"infoMsgs",
             @"warningMessagesList" : @"warningMsgs",
             TOKEN: TOKEN,
             };

}

/** Creates a login response dictionary for mapping rest kit mapping result to login response
 @return A login response dictionary.
 @see WLLoginResponse*/
+(NSDictionary *)createLoginResponseDictionary{
    
    NSMutableDictionary *output =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    NSDictionary *additional = @{
             @"loginName" : @"loginName",
             @"emailAddress" : @"email",
             @"displayName" : @"displayName",
             @"userId" : @"userId",
             @"newsMessages" : @"newsMsgs",
             };
    [output addEntriesFromDictionary:additional];
    
    return output;
}

/** Creates an user profile response dictionary for mapping rest kit mapping result to user profile response
 @return An user profile response dictionary.
 @see WLUserProfileResponse*/
+(NSDictionary *)createUserProfileResponseDicitionary{
    NSMutableDictionary *output =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    
    NSDictionary *additional = @{
                                 @"firstName" : @"firstName",
                                 @"lastName" : @"lastName",
                                 @"displayName" : @"displayName",
                                 @"shortName" : @"shortName",
                                 @"department" : @"department",
                                 @"phoneNumber": @"phoneNumber",
                                 @"emailAddress":@"email",
                                 @"manager":@"manager",
                                 USERID: USERID,
                                 @"teamMates":@"teamMates",
                                 @"directReports":@"directReports",
                                 @"otherUserReports":@"otherUserReports",
                                 };
    [output addEntriesFromDictionary:additional];
    
    return output;
}

/** Creates a vacation demand list response dictionary for mapping rest kit mapping result to vacation demand list response
 @return A vacation demand list response dictionary.
 @see WLvacationDemandListResponse*/
+(NSDictionary *)createVacationDemandListResponseDicitionary{
   
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    
    NSDictionary *additional = @{
                                 @"vacationDemands" : @"vacationDemands",
                                 };
    [dict addEntriesFromDictionary:additional];
    
    return dict;
}

/** Creates a vacation decision response dictionary for mapping rest kit mapping result to vacation decision response
 @return A vacation decision response dictionary.
 @see WLVacationDecisionResponse*/
+(NSDictionary *)createVacationDecisionResponseDicionary{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    
    NSDictionary *additional = @{
                                 @"decisionMade" : @"decisionMade",
                                 };
    [dict addEntriesFromDictionary:additional];
    
    return dict;
}

/** Creates a vacation delete response dictionary for mapping rest kit mapping result to vacation delete response
 @return A vacation delete response dictionary.
 @see WLVacationDeleteResponse*/
+(NSDictionary *)createVacationDeleteResponseDicionary{
    
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    
    NSDictionary *additional = @{
                                 @"isVacationDeleted" : @"isVacationDeleted",
                                 };
    [dict addEntriesFromDictionary:additional];
    
    return dict;
}

/** Creates a vacation demand response dictionary for mapping rest kit mapping result to vacation demand response
 @return A vacation demand response dictionary.
 @see WLVacationDemandResponse*/
+(NSDictionary *)createVacationDemandResponseDicionary{
    NSMutableDictionary *dict =[[NSMutableDictionary alloc]initWithDictionary:[self createBaseResponseDictionary]];
    
    NSDictionary *additional = @{
                                 VACATIONID : VACATIONID,
                                 };
    [dict addEntriesFromDictionary:additional];
    
    return dict;
}


/**---------------------------------------------------------
 * @name Map NSDictionary to Objects
 *----------------------------------------------------------
 */
/** This method maps a dictionary to a vacation demand list item.
 @param dictionary The dictionary wiht the propertys and values for the vacation demand list object.
 @return A vacation demand list item.
 */
+(WLVacationDemandListItem *)vacationDemandListItemFromDictionary:(NSDictionary*)dictionary{
    
    WLVacationDemandListItem *item = [[WLVacationDemandListItem alloc]init];
    
    item.userDisplayName = (NSString*)[dictionary objectForKey:@"userDisplayName"];
    item.id = (NSNumber*)[dictionary objectForKey:@"id"];
    item.startDate = [[dictionary objectForKey:@"startDate"] doubleValue];
    item.endDate = [[dictionary objectForKey:@"endDate"] doubleValue];
    item.comment = (NSString*)[dictionary objectForKey:COMMENT];
    item.status = (NSString*)[dictionary objectForKey:STATUS];
    item.demandType = (NSString*)[dictionary objectForKey:@"demandType"];
    item.department = (NSString*)[dictionary objectForKey:@"department"];
    
    return item;
}

/**---------------------------------------------------------
 * @name Map Requests to NSDictionary
 *----------------------------------------------------------
 */
/** Creates a postable dicitonary from base request.
 @param request the base request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary*)postParasmeterFromBaseRequest:(WLBaseRequest *)request{
    return @{
             TOKEN : request.token,
             LOCALE : request.locale.localeIdentifier
             };
    
}

/** Creates a postable dicitonary from user profile request.
 @param request The user profile request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromUserProfileRequest:(WLUserProfileRequest *)request{
    NSMutableDictionary *output = [[NSMutableDictionary alloc]initWithDictionary:[self postParasmeterFromBaseRequest:request]];
    
    NSDictionary *additional = @{
                                 USERID : request.userId
                                 };
    [output addEntriesFromDictionary:additional];
    
    return output;
}

/** Creates a postable dicitonary from vacation demand request.
 @param request The vacation demand request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDemandRequest:(WLVacationDemandRequest *)request{
	
    NSMutableDictionary *output = [[NSMutableDictionary alloc]initWithDictionary:[self postParasmeterFromBaseRequest:request]];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd/MM/yyyy"];
    
    NSString *startDate = [formatter stringFromDate:request.startDate];
    NSString *endDate = [formatter stringFromDate:request.endDate];
    
    if(!request.comment)
        request.comment = @"";
    
    NSDictionary *additional = [NSMutableDictionary dictionaryWithDictionary: @{
                                    USERID : request.userId,
                                    STARTDATE : startDate,
                                    ENDDATE: endDate,
                                    COMMENT: request.comment,
                                    DEMANDTYPE: request.demandType.name,
                                   }];
    
    if(request.vacationId)
       [output addEntriesFromDictionary:@{VACATIONID:request.vacationId}];
    
    [output addEntriesFromDictionary:additional];
    
    return output;
}

/** Creates a postable dicitonary from vacation decision request.
 @param request The vacation decision request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDecisionRequest:(WLVacationDecisionRequest *)request{
    
    NSMutableDictionary *output = [[NSMutableDictionary alloc]initWithDictionary:[self postParasmeterFromBaseRequest:request]];
    
    NSDictionary *additional = @{
                                 VACATIONID : request.vacationId,
                                 STATUS : request.status,
                                 };
    [output addEntriesFromDictionary:additional];
    
    return output;

    
}

/** Creates a postable dicitonary from vacation delete request.
 @param request The vacation delete request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDeleteRequest:(WLVacationDeleteRequest *)request
{
    NSMutableDictionary *output = [[NSMutableDictionary alloc]initWithDictionary:[self postParasmeterFromBaseRequest:request]];
    
    NSDictionary *additional = @{
                                 VACATIONID : request.vacationId,
                                 VACATIONSTATUS: request.vacationStatus
                                 };
    [output addEntriesFromDictionary:additional];
    
    return output;
}
@end
