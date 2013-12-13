//
//  WLMappingHelper.h
//  iWave2
//
//  Created by Marco Lorenz on 24.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "WLLoginResponse.h"
#import "NewsMessages.h"
#import "WLVacationDemandRequest.h"
#import "WLVacationDemandListItem.h"
#import "WLVacationDecisionRequest.h"
#import "WLVacationDeleteRequest.h"
#import "WLUserProfileRequest.h"

/** This class helps to map the different API models to a format that makes communication with wave intranet possible.
 Both plattforms are using Key-Value pairs to send data. So NSDictionary is the format to send and to recieve data.
 There are two big parts in this class:
 
    1. Mapping received JSON-Strings to NSDictionary
    2. Mapping any Request to NSDictionary
 
 The third part: Mapping dictionarys to Objects is real small because of difficulites with creating NSManagedObjects from dictionary
 
 
 */
@interface WLMappingHelper : NSObject

/**---------------------------------------------------------
 * @name Map the received data to NSDictionary
 *----------------------------------------------------------
 */
/** Creates a base response dictionary for mapping rest kit mapping result to base response
 @return A base response dictionary.
 @see WLBaseResponse*/
+(NSDictionary *)createBaseResponseDictionary;

/** Creates a login response dictionary for mapping rest kit mapping result to login response
 @return A login response dictionary.
 @see WLLoginResponse*/
+(NSDictionary *)createLoginResponseDictionary;

/** Creates an user profile response dictionary for mapping rest kit mapping result to user profile response
 @return An user profile response dictionary.
 @see WLUserProfileResponse*/
+(NSDictionary *)createUserProfileResponseDicitionary;

/** Creates a vacation demand list response dictionary for mapping rest kit mapping result to vacation demand list response
 @return A vacation demand list response dictionary.
 @see WLVacationDemandListResponse*/
+(NSDictionary *)createVacationDemandListResponseDicitionary;

/** Creates a vacation decision response dictionary for mapping rest kit mapping result to vacation decision response
 @return A vacation decision response dictionary.
 @see WLVacationDecisionResponse*/
+(NSDictionary *)createVacationDecisionResponseDicionary;

/** Creates a vacation delete response dictionary for mapping rest kit mapping result to vacation delete response
 @return A vacation delete response dictionary.
 @see WLVacationDeleteResponse*/
+(NSDictionary *)createVacationDeleteResponseDicionary;

/** Creates a vacation demand response dictionary for mapping rest kit mapping result to vacation demand response
 @return A vacation demand response dictionary.
 @see WLVacationDemandResponse*/
+(NSDictionary *)createVacationDemandResponseDicionary;

/**---------------------------------------------------------
 * @name Map NSDictionary to Objects
 *----------------------------------------------------------
 */
/** This method maps a dictionary to a vacation demand list item.
 @param dictionary The dictionary wiht the propertys and values for the vacation demand list object.
 @return A vacation demand list item.
 */
+(WLVacationDemandListItem *)vacationDemandListItemFromDictionary:(NSDictionary*)dictionary;

/**---------------------------------------------------------
 * @name Map Requests to NSDictionary
 *----------------------------------------------------------
 */
/** Creates a postable dicitonary from base request.
 @param request The base request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary*)postParasmeterFromBaseRequest:(WLBaseRequest *)request;

/** Creates a postable dicitonary from user profile request.
 @param request The user profile request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromUserProfileRequest:(WLUserProfileRequest *)request;

/** Creates a postable dicitonary from vacation demand request.
 @param request The vacation demand request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDemandRequest:(WLVacationDemandRequest *)request;

/** Creates a postable dicitonary from vacation decision request.
 @param request The vacation decision request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDecisionRequest:(WLVacationDecisionRequest *)request;

/** Creates a postable dicitonary from vacation delete request.
 @param request The vacation delete request to post.
 @return A dictionary containing properties and values of the request. */
+(NSDictionary *)postParameterFromVacationDeleteRequest:(WLVacationDeleteRequest *)request;


@end
