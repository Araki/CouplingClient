//
//  PFError.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#define PairfulErrorDomain @"PairfulErrorDomain"
#define PairfulServerErrorDomain @"PairfulServerErrorDomain"

typedef enum {
	PFErrorNone = 0,
	PFErrorInvalidArgument = 1,
	PFErrorServerTimeout = 2,
    PFErrorOAuthLoginFailure = 3,
	PFErrorOAuthNotLoggedIn = 4,
    
	PFErrorResourceCopyFailed = 30,
	PFErrorResourceValidationFailed = 31,
	
	PFErrorNativeRequestSuspending = 40,
	
	PFErrorLocalLeaderboardNotFound = 50,
	PFErrorLocalLeaderboardScoreIgnored = 51,
	PFErrorLocalLeaderboardHighscoreUpdateNotneeded = 52,
	PFErrorLocalLeaderboardSynchronizationFailed = 53,
	
	PFErrorItemItemNotFound = 60,
	PFErrorItemCannotAcquireItem = 61,
	PFErrorItemCannotAcquireCoins = 62,
	PFErrorItemCannotConsumeItem = 63,
	PFErrorItemOwnershiPFotFound = 64,
	PFErrorItemNotFound = 65,
	
	PFErrorGoogleContactsManagerBadAuthentication = 70,
	
	PFErrorSessionManagerSessionIDNotFound = 80,
	
	PFErrorFacebookPostFailed = 90,
	PFErrorFacebookAlreadyPosted = 91,
	PFErrorFacebookLoginFailed = 92,
	
	PFErrorMixiProfileAcquireFailed = 100,
	
	PFErrorLocalFileStorageWriteToFileFailed = 110,
	
	PFErrorStoreObserverTransactionCreateFailed = 120,
	
	PFErrorUserManagerServiceNotFound = 130,
	PFErrorUserManagerDefaultUserIconNotFound = 131,
	
	PFErrorHTTPResponceError = 140,
	
	PFErrorAsyncDownloadCancelled = 150,
	
	PFErrorStoreManagerMerchandiseNotFound = 160,
	PFErrorStoreManagerItemNotFound = 161,
	PFErrorStoreManagerNoProducts = 162,
	PFErrorStoreManagerTransactionNotRestored = 163,
	PFErrorStoreManagerProductNotFoundInAppStore = 164,
	PFErrorStoreManagerCannotMakePayments = 165,
	PFErrorStoreManagerMaxedOut = 166,
	
	PFErrorTwitterErrorFromServer = 170,
	PFErrorTwitterProfileImageURLNotFound = 171,
	PFErrorTwitterUnknownError = 172,
	
	// match
	
	PFErrorGKSessionJoinRoomFailed = 200,
	PFErrorGKSessionStartMatchFailed = 201,
	
	PFErrorInternetMatchInvalidState = 210,
	
	PFErrorGlobalMatchStartFailed = 220,
	PFErrorGlobalMatchUnlockRoomFailed = 221,
	PFErrorGlobalMatchTypeUnavaliable = 222,
    
    PFErrorPairingFailed = 230,
    PFErrorPairingTooHighRTT = 231,
    PFErrorPairingTimeout = 232,
	
	// networks
	
	PFErrorNotConnectedToInternet = 300,
	
	PFErrorTCPConnectionFailed = 301,
	
	PFErrorGameManagerInvalidObjectType = 310,
	
	PFErrorAchievementRequestUserIsGuest = 320,
	
	// status code
	PFErrorStatusCodeBadRequest = 1400,
	PFErrorStatusCodeNodeFound = 1404,
	PFErrorStatusCodeUnprocessableEntity = 1422,
	PFErrorStatusCodeInternalServerError = 1500,
	PFErrorStatusCodeServiceUnavailable = 1503,
	
	// server
    PFServerErrorInvalidSession = 2000,
	PFServerErrorAlreadyExists = 2001,
	PFServerErrorNotAllowed = 2002,
    PFServerErrorNotFound = 2003,
	PFServerErrorExternalError = 2004,
	PFServerErrorInvalidCredentials = 2005,
    
	PFErrorUnknownError = 10000
} PFErrorCode;

@interface PFError : NSError

+ (id)errorWithCode:(PFErrorCode)code userInfo:(NSDictionary *)info;
+ (NSError *)errorFromResponse:(NSString *)response;
- (NSDictionary *)jsonDictionary;

@end
