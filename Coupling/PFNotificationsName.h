//
//  PFNotificationsName.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#ifndef Coupling_PFNotificationsName_h
#define Coupling_PFNotificationsName_h

// [HTTP Request]
#define kPFNotificationHTTPRequestToServerIsSent				@"PNNotificationHTTPRequestToServerIsSent"
#define kPFNotificationFailedToConnectToInternet				@"PNNotificationFailedToConnectToInternet"

// [Achievement]
#define kPFNotificationAchievementUnlockedInLocalDatabase		@"PNNotificationAchievementUnlockedInLocalDatabase"
#define kPFNotificationAchievementUnlockedInServerDatabase		@"PNNotificationAchievementUnlockedInServerDatabase"

// [Leaderboard]
#define kPFNotificationLeaderboardPostScoreFailed				@"PNNotificationLeaderboardPostScoreFailed"

// [TCP]
#define kPFNotificationConnectionEstablished					@"PNNotificationConnectionEstablished"
#define kPFNotificationConnectionDisconnected					@"PNNotificationConnectionDisconnected"

// [Session]
#define kPFNotificationSessionBecameInvalid						@"PNNotificationSessionBecameInvalid"

// [Visit]
#define kPFNotificationRequestForVisitingUser					@"PNNotificationRequestForVisitingUser"

// [WelcomeBack]
#define kPFNotificationGettingInfoForWelcomeBackMessageDone		@"PNNotificationGettingInfoForWelcomeBackMessageDone"

// [Dashboard]
#define kPFNotificationDashboardWillDisappear					@"PNNotificationDashboardWillDisappear"
#define kPFNotificationDashboardDidDisappear					@"PNNotificationDashboardDidDisappear"
#define kPFNotificationDashboardDidBecomeReady					@"PNNotificationDashboardDidBecomeReady"
#define kPFNotificationDashboardDidGetCustomBackgroundImageURL	@"PNNotificationDashboardDidGetCustomBackgroundImageURL"
#define kPFNotificationDashboardDidGetNavigationTitle			@"PNNotificationDashboardDidGetNavigationTitle"
#define kPFNotificationDashboardDidFinishLoadingPage			@"PNNotificationDashboardDidFinishLoadingPage"

// [View]
#define kPFNotificationModalViewClosed							@"kPFNotificationModalViewClosed"

// [User]
#define kPFNotificationUserUpdated								@"PNNotificationUserUpdated"

// [Login]
#define kPFNotificationUserDidLogin								@"PNNotificationUserDidLogin"
#define kPFNotificationUserDidLogout							@"PNNotificationUserDidLogout"
#define kPNManagerFinishLoginNotification						@"PNManagerFinishLoginNotification"

// [Feature Available]
#define kPFNotificationItemOwnershipDownloaded					@"PNNotificationItemOwnershipDownloaded"
#define kPFNotificationAchievementUnlocksDownloaded				@"PNNotificationAchievementUnlocksDownloaded"
#define kPFNotificationLeaderboardScoresDownloaded				@"PNNotificationLeaderboardScoresDownloaded"

// [Purchase]
#define kPFNotificationInAppPurchasingDidFinishOldTransaction	@"kPFNotificationInAppPurchasingDidFinishOldTransaction"


#endif
