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

//user cache data paths
#define kPFUsersUserIDCache								@"PF_USER_USERID_CACHE"
#define kPFUsersSessionIDCache							@"PF_USER_SESSIONID_CACHE"
#define	kPFUsersNicknameCache							@"PF_USER_NICKNAME_CACHE"
#define	kPFUsersFacebookIdCache							@"PF_USER_FACEBOOKID_CACHE"
#define	kPFUsersEmailCache                              @"PF_USER_EMAIL_CACHE"
#define	kPFUsersIntroductionCache                       @"PF_USER_INTRODUCTION_CACHE"
#define	kPFUsersGenderCache                             @"PF_USER_GENDER_CACHE"
#define	kPFUsersAgeCache                                @"PF_USER_AGE_CACHE"
#define	kPFUsersBloodTypeCache                          @"PF_USER_BLOODTYPE_CACHE"
#define	kPFUsersProportionCache                         @"PF_USER_PROPORTION_CACHE"
#define	kPFUsersSchoolCache                             @"PF_USER_SCHOOL_CACHE"
#define	kPFUsersIndustryCache                           @"PF_USER_INDUSTRY_CACHE"
#define	kPFUsersJobCache                                @"PF_USER_JOB_CACHE"
#define	kPFUsersIncomeCache                             @"PF_USER_INCOME_CACHE"
#define	kPFUsersHolidayCache                            @"PF_USER_HOLIDAY_CACHE"
#define	kPFUsersStatusCache                             @"PF_USER_STATUS_CACHE"

#define kPNJSONBoolTrue @"true"
#define kPNJSONBoolFalse @"false"

static PFUser	*p_currentUser	= nil;
static int		p_dedupCounter	= 1;

@implementation PFUser

@synthesize userId;
@synthesize sessionId;
@synthesize udid;
@synthesize nickname;
@synthesize facebookId;
@synthesize email;
@synthesize introduction;
@synthesize gender;
@synthesize age;
@synthesize bloodType;
@synthesize proportion;
@synthesize school;
@synthesize industry;
@synthesize job;
@synthesize income;
@synthesize holiday;
@synthesize status;

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
	if (aModel.nickname) self.nickname = aModel.nickname;
	if (aModel.facebook_id) self.facebookId = aModel.facebook_id;
	if (aModel.email) self.email = aModel.email;
	if (aModel.introduction) self.introduction = aModel.introduction;
	self.gender = aModel.gender;
    self.age = aModel.age;
    self.bloodType = aModel.blood_type;
    self.proportion = aModel.proportion;
    self.school = aModel.school;
    self.industry = aModel.industry;
    self.job = aModel.job;
    self.income = aModel.income;
    self.holiday = aModel.holiday;
    self.status = aModel.status;
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
	if ([PFUser currentUser] != nil && [PFUser currentUser].userId != nil) {
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
	cacheUser.userId			= [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersUserIDCache];
	cacheUser.sessionId			= [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersSessionIDCache];
	cacheUser.nickname			= [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersNicknameCache];
	cacheUser.facebookId		= [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersFacebookIdCache];
	cacheUser.email             = [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersEmailCache];
	cacheUser.introduction      = [[NSUserDefaults standardUserDefaults] stringForKey:kPFUsersIntroductionCache];
	cacheUser.gender            = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersGenderCache];
	cacheUser.age               = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersAgeCache];
	cacheUser.bloodType         = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersBloodTypeCache];
	cacheUser.proportion        = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersProportionCache];
	cacheUser.school            = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersSchoolCache];
	cacheUser.industry          = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersIndustryCache];
	cacheUser.job               = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersJobCache];
	cacheUser.income            = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersIncomeCache];
	cacheUser.holiday           = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersHolidayCache];
	cacheUser.status            = [[NSUserDefaults standardUserDefaults] integerForKey:kPFUsersStatusCache];
	
	if(!cacheUser.udid){
		cacheUser.udid = [UIDevice currentDevice].identifierForVendor;
	}
    
	return cacheUser;
}

/**
 そのユーザの情報をカレントユーザとしてNSUserDefaultsに保存します。
 そうすることで、次回起動時にインターネットに接続されていない状況でもユーザ情報を復元することができます。
 */
- (void)saveToCacheAsCurrentUser{
	[[NSUserDefaults standardUserDefaults] setObject:self.userId		forKey:kPFUsersUserIDCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.sessionId		forKey:kPFUsersSessionIDCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.nickname		forKey:kPFUsersNicknameCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.facebookId	forKey:kPFUsersFacebookIdCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.email         forKey:kPFUsersEmailCache];
	[[NSUserDefaults standardUserDefaults] setObject:self.introduction  forKey:kPFUsersIntroductionCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.gender] forKey:kPFUsersGenderCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.age] forKey:kPFUsersAgeCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.bloodType] forKey:kPFUsersBloodTypeCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.proportion] forKey:kPFUsersProportionCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.school] forKey:kPFUsersSchoolCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.industry] forKey:kPFUsersIndustryCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.job] forKey:kPFUsersJobCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.income] forKey:kPFUsersIncomeCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.holiday] forKey:kPFUsersHolidayCache];
	[[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d", self.status] forKey:kPFUsersStatusCache];
	
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
#define JSONBOOL(value) (value ? kPNJSONBoolTrue : kPNJSONBoolFalse)
    NSDictionary *fields = [NSDictionary dictionaryWithObjectsAndKeys:
                            userId ? userId : @"", @"user_id",
                            sessionId ? sessionId : @"", @"session_id",
                            nickname ? nickname : @"", @"nick_name",
                            facebookId ? facebookId : @"", @"facebook_id",
                            email ? email : @"", @"email",
                            introduction ? introduction : @"", @"introduction",
                            gender, @"gender",
                            age, @"age",
                            bloodType, @"blood_type",
                            proportion, @"proportion",
                            school, @"school",
                            industry, @"industry",
                            job, @"job",
                            income, @"income",
                            holiday, @"holiday",
                            status, @"status", nil];
#undef JSONBOOL
    return fields;
}

- (NSDictionary*)jsonRepresentation {
#define JSONBOOL(value) (value ? kPNJSONBoolTrue : kPNJSONBoolFalse)
#define JSONString(value) (value ? value : @"")
#define JSONInt(value) ([NSString stringWithFormat:@"%d", value])
#define EXTService(value) (value ? [NSDictionary dictionaryWithObject:value forKey:@"id"] : [NSNull null])
    NSMutableDictionary* dic = [NSMutableDictionary dictionary];
    [dic setObject:JSONString(self.userId) forKey:@"id"];
    [dic setObject:JSONString(self.sessionId) forKey:@"session_id"];
    [dic setObject:JSONString(self.nickname) forKey:@"nickname"];
    [dic setObject:JSONString(self.facebookId) forKey:@"facebook_id"];
    [dic setObject:JSONString(self.email) forKey:@"email"];
    [dic setObject:JSONString(self.introduction) forKey:@"introduction"];
    [dic setObject:JSONInt(self.gender) forKey:@"gender"];
    [dic setObject:JSONInt(self.age) forKey:@"age"];
    [dic setObject:JSONInt(self.bloodType) forKey:@"blood_type"];
    [dic setObject:JSONInt(self.proportion) forKey:@"proportion"];
    [dic setObject:JSONInt(self.school) forKey:@"school"];
    [dic setObject:JSONInt(self.industry) forKey:@"industry"];
    [dic setObject:JSONInt(self.job) forKey:@"job"];
    [dic setObject:JSONInt(self.income) forKey:@"income"];
    [dic setObject:JSONInt(self.holiday) forKey:@"holiday"];
    [dic setObject:JSONInt(self.status) forKey:@"status"];
#undef JSONString
#undef JSONInt
#undef EXTService
#undef JSONBOOL
    
    return dic;
}

@end
