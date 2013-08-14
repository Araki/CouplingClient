//
//  PFUserModel.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFUserModel.h"
#import "NSDictionary+Extension.h"

//User
#define kPFDefaultNickname					@""
#define kPFDefaultFacebookId				@""
#define kPFDefaultEmail                     @""
#define kPFDefaultIntroduction              @""

@implementation PFUserModel
@synthesize id, nickname, facebook_id, email, introduction, gender, age, blood_type, proportion, school, industry, job, income, holiday, status;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.id             = -1;
		self.nickname       = kPFDefaultNickname;
		self.facebook_id    = kPFDefaultFacebookId;
		self.email          = kPFDefaultEmail;
        self.introduction   = kPFDefaultIntroduction;
	}
	return self;
}


- (id)initWithDictionary:(NSDictionary *)aDictionary
{
	self = [self init];
	if (self != nil) {
		self.id             = [[aDictionary objectForKey:@"id"] intValue];
		self.nickname       = [aDictionary stringValueForKey:@"nickname" defaultValue:kPFDefaultNickname];
		self.facebook_id    = [aDictionary stringValueForKey:@"facebook_id" defaultValue:kPFDefaultFacebookId];
		self.email          = [aDictionary stringValueForKey:@"email" defaultValue:kPFDefaultEmail];
		self.introduction   = [aDictionary stringValueForKey:@"introduction" defaultValue:kPFDefaultIntroduction];
		self.gender         = [aDictionary intValueForKey:@"gender" defaultValue:0];
		self.age            = [aDictionary intValueForKey:@"age" defaultValue:0];
		self.blood_type     = [aDictionary intValueForKey:@"blood_type" defaultValue:0];
        self.proportion     = [aDictionary intValueForKey:@"proportion" defaultValue:0];
		self.school         = [aDictionary intValueForKey:@"school" defaultValue:0];
		self.industry       = [aDictionary intValueForKey:@"industry" defaultValue:0];
        self.job            = [aDictionary intValueForKey:@"job" defaultValue:0];
        self.income         = [aDictionary intValueForKey:@"income" defaultValue:0];
        self.holiday        = [aDictionary intValueForKey:@"holiday" defaultValue:0];
	}
	PFCLog(PFLOG_CAT_MODEL_PARSER, @"DATAMODEL-PARSE\n%@", self);	// FOR DEBUG
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@ :%p>\n id: %d\n nickname: %@\n facebook_id: %@\n email:%@\n introduction:%@\n gender:%d\n age:%d\n blood_type:%d\n proportion:%d\n school:%d\n industry:%d\n job:%d\n income:%d\n holiday:%d\n",
			NSStringFromClass([self class]),self, self.id, self.nickname, self.facebook_id, self.email, self.introduction, self.gender, self.age, self.blood_type, self.proportion, self.school, self.industry, self.job, self.income, self.holiday];
}

@end
