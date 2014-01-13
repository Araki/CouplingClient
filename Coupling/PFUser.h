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

/**
 * PFUser class manages information about user.
 */
@interface PFUser : PFModel {
	// Sessions.
	NSString	*userId;
	NSString	*sessionId;
	
	// UserInfos.
	NSUUID      *udid;
	NSString	*nickname;
    NSString	*facebookId;
    NSString    *email;
    NSString    *introduction;
    NSInteger   prefecture;
    NSInteger   gender;
    NSInteger   age;
    NSInteger   bloodType;
    NSInteger   proportion;
    NSInteger   school;
    NSInteger   industry;
    NSInteger   job;
    NSInteger   income;
    NSInteger   holiday;
    NSInteger   status;
    NSInteger   likePoints;
    NSInteger   points;
}

@property(retain) NSString* userId;
@property(retain) NSString* sessionId;
@property(retain) NSUUID* udid;
@property(retain) NSString* nickname;
@property(retain) NSString* facebookId;
@property(retain) NSString* email;
@property(retain) NSString* introduction;

@property(nonatomic, assign) NSInteger prefecture;
@property(nonatomic, assign) NSInteger gender;
@property(nonatomic, assign) NSInteger age;
@property(nonatomic, assign) NSInteger bloodType;
@property(nonatomic, assign) NSInteger proportion;
@property(nonatomic, assign) NSInteger school;
@property(nonatomic, assign) NSInteger industry;
@property(nonatomic, assign) NSInteger job;
@property(nonatomic, assign) NSInteger income;
@property(nonatomic, assign) NSInteger holiday;
@property(nonatomic, assign) NSInteger status;
@property(nonatomic, assign) NSInteger likePoints;
@property(nonatomic, assign) NSInteger points;


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
