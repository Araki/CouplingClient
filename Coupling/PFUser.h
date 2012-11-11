//
//  PFUser.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFModel.h"

@class PFUserModel;
@class PFSessionModel;

#define kPNCountryCodeDefault       @"COUNTRY_CODE_NONE"

typedef enum {
	PNUserIconTypeDefault,
    PNUserIconTypePankia,
	PNUserIconTypeTwitter,
	PNUserIconTypeFacebook,
	PNUserIconTypeMixi
} PNUserIconType;

/**
 * PFUser class manages information about user.
 */
@interface PFUser : PFModel {
	// Sessions.
	NSString	*userId;
	NSString	*sessionId;
	NSString	*publicSessionId;
	NSString	*gameId;
    NSDate      *sessionCreatedAt;
	
	// UserInfos.
//	NSString	*udid;
	NSUUID      *udid;
	NSString	*username;
    NSString    *fullname;
	NSString	*status;
	NSString	*countryCode;
	NSString	*iconURL;
	NSString	*twitterId;
    NSString	*facebookId;
	BOOL		isGuest;
	BOOL		isSecured;
	BOOL		isLinkTwitter;
	PNUserIconType	iconType;
	NSString		*externalId;
    NSString    *email;
    BOOL        isFollowing;
    BOOL        isFollowed;
    
    // GW only
    NSString *birthdate, *blurb, *city, *gender, *mixiId;
    int friendsCount;
}

/**
 * A string value that represents ID of user. (read-only)
 */
@property(retain) NSString* userId;
@property(retain) NSString* sessionId;
@property(retain) NSString* publicSessionId;
@property(retain) NSString* gameId;
@property(retain) NSDate* sessionCreatedAt;

@property(retain) NSUUID* udid;
@property(retain) NSString* username;
@property(retain) NSString* fullname;
@property(retain) NSString* status;
@property(retain) NSString* gradeName;
@property(retain) NSString* countryCode;
@property(retain) NSString* iconURL;

/**
 * The twitter ID of user. (read-only)
 */
@property(retain) NSString* twitterId;

/**
 * The facebook ID of user. (read-only)
 */
@property(retain) NSString* facebookId;

/**
 * The mixi ID of user. (read-only)
 */
@property(retain) NSString* mixiId;

@property(nonatomic, assign) BOOL isGuest;

/**
 * The sum of all achievement points. (read-only)
 */
@property(nonatomic, assign) BOOL isSecured;
@property(nonatomic, assign) BOOL isLinkTwitter;
@property(nonatomic, assign) PNUserIconType iconType;
@property(retain) NSString* externalId;
@property(retain) NSString* email;
@property(assign) BOOL isFollowed, isFollowing;

/**
 * A string value that represents name to display.
 * If user is not registered yet, this property has auto-generated username (ex. guest12345).
 * Otherwise, full name. (read-only)
 */
@property (readonly) NSString* displayName;

// GW only
@property (retain) NSString *birthdate, *blurb, *city, *gender;
@property (assign) int friendsCount;

/**
 * Returns the PNUser instance that represents current user.
 */
+ (PFUser *)currentUser;
+ (PFUser *)user;
+ (int)currentUserId;
+ (int)currentUserIdIncludingGuest;
+ (int)dedupCounter;
+ (int)countUpDedupCounter;
+ (PFUser *)loadFromCache;
//- (BOOL)isSecuredOrLinked;

- (void)updateFieldsFromUserModel:(PFUserModel *)aModel;
- (void)updateFieldsFromSessionModel:(PFSessionModel *)model;
- (void)saveToCacheAsCurrentUser;

- (NSDictionary *)dictionaryRepresentation;
- (NSDictionary*)jsonRepresentation;

@end
