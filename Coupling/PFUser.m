//
//  PFUser.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFUser.h"
#import "PFUserModel.h"
#import "PFError.h"
//#import "PFSessionModel.h"
//#import "PFUserManager.h"
#import "PFLogger.h"
#import "PFGlobal.h"
//#import "PFMiscUtil.h"
//#import "PNSettingManager.h"

#define kPNOfflineGuestAccount							@"PLAYER"
#define kPNDefaultGradeName								@""

//user cache data paths
#define	kPNUsersUserNameCache							@"PN_USER_USERNAME_CACHE"
#define	kPNUsersFullNameCache							@"PN_USER_FULLNAME_CACHE"
#define	kPNUsersCountrycodeCache						@"PN_USER_COUNTRYCODE_CACHE"
#define	kPNUsersIconURLCache							@"PN_USER_ICONURL_CACHE"
#define kPNUsersGuestCache								@"PN_USER_ISGUEST_CACHE"
#define	kPNUsersSecuredCache							@"PN_USER_ISSECURED_CACHE"
#define kPNUsersUserIDCache								@"PN_USER_USERID_CACHE"
#define kPNUsersExternalIDCache							@"PN_USER_EXTERNALID_CACHE"

#define kPNJSONBoolTrue @"true"
#define kPNJSONBoolFalse @"false"

static PFUser	*p_currentUser	= nil;
static int		p_dedupCounter	= 1;

@implementation PFUser

@synthesize userId,sessionId,publicSessionId,gameId,sessionCreatedAt;
@synthesize udid,username,fullname,status,gradeName,countryCode;
@synthesize iconURL,twitterId,facebookId;
@synthesize isGuest,isSecured,isLinkTwitter;
@synthesize iconType,externalId, email;
@synthesize isFollowed, isFollowing;
@synthesize birthdate, blurb, city, friendsCount, gender, mixiId;


//- (NSString*)displayName {
//    if (fullname != nil && [fullname length] > 1) {
//        NSCharacterSet* allowedCharacterSet = [PNSettingManager sharedObject].allowedCharacterSetForDisplayName;
//        if (allowedCharacterSet) {
//            NSString* trimmedFullname = [fullname stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//            if ([trimmedFullname rangeOfCharacterFromSet:[allowedCharacterSet invertedSet]].location != NSNotFound) {
//                return username;
//            } else {
//                return fullname;
//            }
//        } else {
//            return fullname;
//        }
//    } else {
//        return username;
//    }
//}

+(PFUser*) currentUser
{
	@synchronized(self) {
        if (p_currentUser == nil) {
//			p_currentUser.udid = [PFMiscUtil udid];
            p_currentUser.udid = [UIDevice currentDevice].identifierForVendor;
			p_currentUser = [PFUser loadFromCache];
        }
    }
	return p_currentUser;
}


- (id) init
{
	self = [super init];
	if (self != nil) {
		self.isGuest                    = YES;
		self.isSecured                  = NO;
	}
	return  self;
}

- (id)initWithDataModel:(PFUserModel *)model
{
    self = [super initWithDataModel:model];
    if (self != nil) {
        [self updateFieldsFromUserModel:model];
    }
    return self;
}

- (void)updateFieldsFromUserModel:(PFUserModel *)aModel
{
	if (aModel.id) self.userId = [NSString stringWithFormat:@"%d", aModel.id];
	if (aModel.username) self.username = aModel.username;
	if (aModel.fullname) self.fullname = aModel.fullname;
	if (aModel.country) self.countryCode = aModel.country;
	if (aModel.icon_url) self.iconURL = aModel.icon_url;
    
	if (self.isGuest == YES) self.isGuest = aModel.is_guest;
	if (self.isSecured == NO) self.isSecured = aModel.is_secured;
	
    self.facebookId = aModel.facebook_id;
    self.twitterId = aModel.twitter_id;
	
	if ([aModel.icon_used isEqualToString:@"twitter"]) { iconType = PNUserIconTypeTwitter; }
    else if ([aModel.icon_used isEqualToString:@"facebook"]) { iconType = PNUserIconTypeFacebook; }
    else if ([aModel.icon_used isEqualToString:@"pankia"]) { iconType = PNUserIconTypePankia; }
	else if ([aModel.icon_used isEqualToString:@"mixi"]) { iconType = PNUserIconTypeMixi; }
	else {
        iconType = PNUserIconTypeDefault;
        self.iconURL = nil;
	}
    
	if (aModel.externalId != nil) self.externalId = aModel.externalId;
	if (aModel.email != nil) self.email = aModel.email;
    
    self.isFollowing = aModel.is_following;
    self.isFollowed = aModel.is_followed;
    
    // GW only
    self.birthdate = aModel.birthdate;
    self.blurb = aModel.blurb;
    self.city = aModel.city;
    self.friendsCount = aModel.friends_count;
    self.gender = aModel.gender;
    self.mixiId = aModel.mixi_id;
}

- (void)socialServiceConnectorDidReceiveTwitterIconURL:(NSString*)twitterIconURL
{
	NSLog(@"didReceiveTwitterURL: %@", twitterIconURL);
}

- (void)updateFieldsFromSessionModel:(PFSessionModel *)model
{
}

+ (PFUser *)user {
	return [[PFUser alloc] init];
}

+ (NSString*)session {
	return [PFUser currentUser].sessionId;
}

+ (int)currentUserId
{
	if ([PFUser currentUser] != nil && [PFUser currentUser].isGuest == NO && [PFUser currentUser].userId != nil) {
		return [[PFUser currentUser].userId intValue];
	} else {
		return 0;
	}
}

+ (int)currentUserIdIncludingGuest
{
	if ([PFUser currentUser] != nil && [PFUser currentUser].userId != nil) {
		return [[PFUser currentUser].userId intValue];
	} else {
		return 0;
	}
}

+ (PFUser *)loadFromCache
{
	PFUser*	cacheUser			= [PFUser user];
	cacheUser.username			= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersUserNameCache];
	cacheUser.username			= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersFullNameCache];
	cacheUser.externalId		= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersExternalIDCache];
	cacheUser.countryCode		= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersCountrycodeCache];
	cacheUser.iconURL			= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersIconURLCache];
	cacheUser.userId			= [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersUserIDCache];
	
	if(!cacheUser.udid){
		cacheUser.udid = [UIDevice currentDevice].identifierForVendor;
	}
	if(!cacheUser.username) {
		double rndNum = arc4random()%100000;
		//p_currentUser.username = [NSString stringWithFormat:@"%@%.0f",[[UIDevice currentDevice] model],rndNum];
		cacheUser.username = [NSString stringWithFormat:@"%@%.0f",kPNOfflineGuestAccount,rndNum];
	}
	if (!cacheUser.countryCode) {
		cacheUser.countryCode = kPNCountryCodeDefault;
	}
	
	NSString* is_guest;
    is_guest = [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersGuestCache];
	if (is_guest != nil) {
		cacheUser.isGuest		= [is_guest boolValue];
	}
	else {
		cacheUser.isGuest = YES;
	}
	
	NSString* is_secured;
    is_secured = [[NSUserDefaults standardUserDefaults] stringForKey:kPNUsersGuestCache];
	if (is_secured) {
		cacheUser.isSecured		= [is_secured boolValue];
	}
	else {
		cacheUser.isSecured = NO;
	}
	if (cacheUser.gradeName == nil) {
		cacheUser.gradeName = kPNDefaultGradeName;
	}
	
	return cacheUser;
}

/**
 そのユーザの情報をカレントユーザとしてNSUserDefaultsに保存します。
 そうすることで、次回起動時にインターネットに接続されていない状況でもユーザ情報を復元することができます。
 */
- (void)saveToCacheAsCurrentUser{
	[[NSUserDefaults standardUserDefaults] setObject:self.username			forKey:kPNUsersUserNameCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.fullname			forKey:kPNUsersFullNameCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.externalId			forKey:kPNUsersExternalIDCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.countryCode		forKey:kPNUsersCountrycodeCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.iconURL			forKey:kPNUsersIconURLCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.userId			forKey:kPNUsersUserIDCache];
	
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.isGuest]				forKey:kPNUsersGuestCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",self.isSecured]			forKey:kPNUsersSecuredCache];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)dedupCounter {
    @synchronized(self) {
        return p_dedupCounter;
    }
}

+(int)countUpDedupCounter
{
    @synchronized(self) {
        p_dedupCounter++;
        return p_dedupCounter;
	}
}

- (NSDictionary *)dictionaryRepresentation
{
    NSString *iconTypeName;
    
    switch (iconType) {
        case PNUserIconTypePankia:
            iconTypeName = @"pankia";
            break;
        case PNUserIconTypeTwitter:
            iconTypeName = @"twitter";
            break;
        case PNUserIconTypeFacebook:
            iconTypeName = @"facebook";
            break;
        default:
            iconTypeName = @"default";
            break;
    }
    
#define JSONBOOL(value) (value ? kPNJSONBoolTrue : kPNJSONBoolFalse)
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            userId ? userId : @"", @"user_id",
                            sessionId ? sessionId : @"", @"session_id",
                            publicSessionId ? publicSessionId : @"", @"public_session_id",
//                            sessionCreatedAt ? [PNMiscUtil stringFromDate:sessionCreatedAt] : @"", @"session_created_at",
                            gameId ? gameId : @"", @"game_id",
                            username ? username : @"", @"username",
                            fullname ? fullname : @"", @"fullname",
                            email ? email : @"", @"email",
                            status ? status : @"", @"status",
                            gradeName ? gradeName : @"", @"grade_name",
                            countryCode ? countryCode : @"", @"country_code",
                            iconURL ? iconURL : @"", @"icon_url",
                            twitterId ? twitterId : @"", @"twitter_id",
                            facebookId ? facebookId : @"", @"facebook_id",
                            JSONBOOL(isGuest), @"is_guest",
                            JSONBOOL(isSecured), @"is_secured",
//                            JSONBOOL([self isSecuredOrLinked]), @"is_secured_or_linked",
                            self.displayName, @"display_name",
                            JSONBOOL(isFollowed), @"is_followed",
                            JSONBOOL(isFollowing), @"is_following",
                            iconTypeName, @"icon_type", nil];
#undef JSONBOOL
    return fields;
}

- (NSDictionary*)jsonRepresentation {
#define JSONBOOL(value) (value ? kPNJSONBoolTrue : kPNJSONBoolFalse)
#define JSONString(value) (value ? value : @"")
#define JSONInt(value) ([NSString stringWithFormat:@"%d", value])
#define EXTService(value) (value ? [NSDictionary dictionaryWithObject:value forKey:@"id"] : [NSNull null])
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:JSONString(self.username) forKey:@"username"];
    [dic setObject:JSONString(self.gender) forKey:@"gender"];
    [dic setObject:JSONString(self.fullname) forKey:@"fullname"];
    [dic setObject:JSONString(self.countryCode) forKey:@"country"];
    [dic setObject:JSONString(self.iconURL) forKey:@"icon_url"];
    [dic setObject:JSONInt(self.friendsCount) forKey:@"friends_count"];
    
    NSString* iconTypeString = nil;
    switch (self.iconType) {
        case PNUserIconTypeFacebook:
            iconTypeString = @"facebook";
            break;
        case PNUserIconTypeTwitter:
            iconTypeString = @"twitter";
            break;
        case PNUserIconTypePankia:
            iconTypeString = @"pankia";
            break;
        default:
            iconTypeString = @"default";
            break;
    }
    [dic setObject:JSONString(iconTypeString) forKey:@"icon_used"];
    [dic setObject:EXTService(self.facebookId) forKey:@"facebook"];
    [dic setObject:EXTService(self.twitterId) forKey:@"twitter"];
    [dic setObject:EXTService(self.mixiId) forKey:@"mixi"];
    
    [dic setObject:JSONString(birthdate) forKey:@"birthdate"];
    [dic setObject:JSONString(blurb) forKey:@"blurb"];
    [dic setObject:JSONString(city) forKey:@"city"];
    
    [dic setObject:JSONString(userId) forKey:@"id"];
    
    [dic setObject:JSONBOOL(self.isFollowed) forKey:@"is_followed"];
    [dic setObject:JSONBOOL(self.isFollowing) forKey:@"is_following"];
    
#undef JSONString
#undef JSONInt
#undef EXTService
#undef JSONBOOL
    
    return dic;
}

@end
