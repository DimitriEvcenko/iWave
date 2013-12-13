//
//  WLConstants.h
//  iWave2
//
//  Created by Marco Lorenz on 22.04.13.
//  Copyright (c) 2013 Marco Lorenz. All rights reserved.
//

#import <Foundation/Foundation.h>


/** This class contents all the constants used in iWave.
 Expecially constants that are defined in wave intranet are declared here to define keys or url reqests.
 A description of the constants is not possible with the current version of documentation.
 */
@interface WLConstants : NSObject

//Rest-Urls
extern NSString *const BASE_URL;
extern NSString *const LOGIN_URL;
extern NSString *const REQUEST_VACATION_URL;
extern NSString *const VACATION_INFORMATION_URL;
extern NSString *const REQUEST_USER_PROFILE_URL;
extern NSString *const VACATION_DEMAND_LIST_URL;
extern NSString *const USER_VACATION_INFORMATION_URL;
extern NSString *const DECIDE_VACATION_URL;
extern NSString *const DELETE_VACATION_URL;

//Restservice-Descriptions
extern NSString *const LOGIN_DESCRIPTION;
extern NSString *const REQUEST_VACATION_DESCRIPTION;
extern NSString *const VACATION_INFORMATION_DESCRIPTION;
extern NSString *const USER_PROFILE_DESCRIPTION;
extern NSString *const VACATION_DEMAND_LIST_DESCRIPTION;
extern NSString *const USER_VACATION_INFORMATION_DESCRIPTION;
extern NSString *const DECIDE_VACATION_DESCRIPTION;
extern NSString *const DELETE_VACATION_DESCRIPTION;

//Restmapping - Constants
extern NSString *const USERNAME;
extern NSString *const PASSWORD;
extern NSString *const USERID;
extern NSString *const STATUS;
extern NSString *const LOCALE;
extern NSString *const TOKEN;
extern NSString *const STARTDATE;
extern NSString *const ENDDATE;
extern NSString *const COMMENT;
extern NSString *const DEMANDTYPE;
extern NSString *const VACATIONID;
extern NSString *const VACATIONSTATUS;

//VacationDemandType
extern NSString *const VD_HOLIDAY;
extern NSString *const VD_PARENTALLEAVE;
extern NSString *const VD_SEMINAR;
extern NSString *const VD_FLEXITIME;
extern NSString *const VD_SABBATICAL;

//VacationDemandStatus
extern NSString *const VS_PENDING;
extern NSString *const VS_REJECTED;
extern NSString *const VS_APPROVED;
extern NSString *const VS_NOTSEND;
extern NSString *const VS_TEAM;
extern NSString *const VS_TEAM_INDIRECT;

//Notifications
extern NSString *const TUTORIAL_NOTIFICATION;
extern NSString *const DESIGN_NOTIFICATION;
extern NSString *const NO_TOKEN_NOTIFICATION;

//App Count
extern int const APP_COUNT;

//the MiniApps
typedef enum {
    SETTINGS = 0,
    VACATION = 1,
    MARKETPLACE = 2
} MiniAppIndex;

//Designs
typedef enum {
    SIDION_LIGHT = 0,
    SIDION_DARK = 1,
    SIDION_BLUE = 2,
    SIDION_SAND
} AppDesigns;

//Usability
typedef enum {
    BUTTONS = 0,
    GESTURES = 1,
    BOTH = 2
} AppUsabilty;

//Settings
typedef enum {
    LOGIN_SETTINGS = 0,
    PROFILE_SETTINGS = 1,
    TEAM_SETTINGS = 2
} AppSettings;

typedef enum {
    NOTHING = -1,
    USABILITY = 0,
    DESIGN = 1
} SettingsChoise;

@end
