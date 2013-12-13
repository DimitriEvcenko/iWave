//
//  WLConstants.m
//  iWave2
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//



@implementation WLConstants

//Rest-Urls
//NSString * const BASE_URL = @"http://wave.sidion.local/rest/rest/";//original
NSString * const BASE_URL = @"http://slwt001:7500/rest/rest/";//testserver
//NSString *const BASE_URL = @"http://192.168.178.30:8080/wave-rest/rest/";//wave local cable
//NSString * const BASE_URL = @"http://wave.sidion.local/rest/rest/";//testserver
//NSString * const BASE_URL = @"http://10.15.37.232:8080/wave-rest/rest";//wave local sWlan
//NSString * const BASE_URL = @"http://169.254.67.166:8080/WaveRestMock/wave-rest/";//wave mock

NSString * const LOGIN_URL = @"login";
NSString * const REQUEST_VACATION_URL = @"requestVacation";
NSString * const VACATION_INFORMATION_URL = @"getVacationInformation";
NSString *const REQUEST_USER_PROFILE_URL = @"getUserProfile";
NSString *const VACATION_DEMAND_LIST_URL = @"requestVacationList";
NSString *const USER_VACATION_INFORMATION_URL = @"userVacationInformation";
NSString *const DECIDE_VACATION_URL = @"decideVacation";
NSString *const DELETE_VACATION_URL = @"deleteVacation";

//Restservice-Descriptions
NSString *const LOGIN_DESCRIPTION = @"Login_Service";
NSString *const REQUEST_VACATION_DESCRIPTION= @"Request_Vacation_Service";
NSString *const VACATION_INFORMATION_DESCRIPTION = @"Vacation_Information_Service";
NSString *const USER_PROFILE_DESCRIPTION = @"User_Profile_Service";
NSString *const VACATION_DEMAND_LIST_DESCRIPTION = @"Vacation_Demand_List_Service";
NSString *const USER_VACATION_INFORMATION_DESCRIPTION = @"User_Vacation_Information_Service";
NSString *const DECIDE_VACATION_DESCRIPTION = @"Decide_Vacation_Service";
NSString *const DELETE_VACATION_DESCRIPTION = @"Delete_Vacation_Service";

//Restmapping - Constants
//Login Service
NSString *const USERNAME = @"userName";
NSString *const PASSWORD = @"passWord";
NSString *const USERID = @"userId";
NSString *const STATUS = @"status";
NSString *const LOCALE = @"locale";
NSString *const TOKEN = @"token";

//Vacation Request Service
NSString *const STARTDATE = @"startDate";
NSString *const ENDDATE = @"endDate";
NSString *const COMMENT = @"comment";
NSString *const DEMANDTYPE = @"demandType";
NSString *const VACATIONID = @"vacationId";
NSString *const VACATIONSTATUS = @"vacationStatus";

//VacationDemandType
NSString *const VD_HOLIDAY = @"HOLIDAY";
NSString *const VD_PARENTALLEAVE = @"PARENTLEAVE";
NSString *const VD_SEMINAR = @"SEMINR";
NSString *const VD_FLEXITIME = @"FLEXTIME";
NSString *const VD_SABBATICAL = @"SABBATICAL";

//VacationDemandStatus
NSString *const VS_PENDING = @"PENDING";
NSString *const VS_REJECTED = @"REJECTED";
NSString *const VS_APPROVED = @"APPROVED";
NSString *const VS_NOTSEND = @"NOTSEND";
NSString *const VS_TEAM = @"TEAMVACATION";
NSString *const VS_TEAM_INDIRECT = @"OTHERREPORTSVACATION";

//Notifications
NSString *const TUTORIAL_NOTIFICATION = @"TutorialNotification";
NSString *const DESIGN_NOTIFICATION = @"DesignNotification";
NSString *const NO_TOKEN_NOTIFICATION = @"NoTokenNotifcation";

//App Count
int const APP_COUNT = 2;

@end
