//
//  PFUserModel.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFUserModel.h"
#import "NSDictionary+GetterExt.h"

//User
#define kPNDefaultUsername					@""
#define kPNDefaultFullName					@""
#define kPNDefaultCountry					@"--"
#define kPNDefaultIconURL					@""
#define kPNDefaultTwitterID					@""
#define kPNIsGuest							YES
#define PNIsSecured							NO
#define kPNIsFollowing						NO
#define kPNIsBlocking						NO

@implementation PFUserModel
@synthesize id = _id, username = _username, fullname = _fullname, country = _country, icon_url = _icon_url;
@synthesize is_guest = _is_guest, is_secured = _is_secured, twitter_id = _twitter_id, facebook_id = _facebook_id;
@synthesize is_following = _is_following, is_followed, relationships = _relationships, is_blocking = _is_blocking;
@synthesize icon_used, email;
@synthesize externalId, informationDictionary;
@synthesize birthdate, blurb, city, friends_count, gender, mixi_id;

- (id) init
{
	self = [super init];
	if (self != nil) {
		self.id             = -1;
		self.username       = kPNDefaultUsername;
		self.fullname       = kPNDefaultFullName;
		self.country        = kPNDefaultCountry;
		self.icon_url       = kPNDefaultIconURL;
		self.relationships  = [NSArray array];
		self.is_guest       = kPNIsGuest;
		self.is_secured     = PNIsSecured;
		self.is_following   = kPNIsFollowing;
		self.is_blocking    = NO;
		self.icon_used      = @"default";
        self.profileImages  = [NSMutableArray array];
	}
	return self;
}


- (id)initWithDictionary:(NSDictionary *)aDictionary
{
	self = [self init];
	if (self != nil) {
		self.id             = [[aDictionary objectForKey:@"id"] intValue];
		self.username       = [aDictionary stringValueForKey:@"username" defaultValue:kPNDefaultUsername];
		self.fullname       = [aDictionary stringValueForKey:@"fullname" defaultValue:kPNDefaultFullName];
		self.country        = [aDictionary stringValueForKey:@"country" defaultValue:kPNDefaultCountry];
		self.icon_url       = [aDictionary stringValueForKey:@"icon_url" defaultValue:kPNDefaultIconURL];
		self.is_guest       = [aDictionary boolValueForKey:@"is_guest" defaultValue:kPNIsGuest];
		self.is_secured     = [aDictionary boolValueForKey:@"is_secured" defaultValue:PNIsSecured];
		self.is_following   = [aDictionary boolValueForKey:@"is_following" defaultValue:kPNIsFollowing];
        self.is_followed    = [aDictionary boolValueForKey:@"is_followed" defaultValue:NO];
		self.is_blocking    = [aDictionary boolValueForKey:@"is_blocking" defaultValue:kPNIsBlocking];
		self.externalId     = [aDictionary stringValueForKey:@"external_id" defaultValue:@""];
        self.email          = [aDictionary stringValueForKey:@"email" defaultValue:nil];
		self.informationDictionary = aDictionary;
        
        if ([aDictionary hasObjectForKey:@"facebook"]) {
            self.facebook_id = [[aDictionary objectForKey:@"facebook"] objectForKey:@"id"];
        }
        
		if ([aDictionary hasObjectForKey:@"twitter"]) {
            self.twitter_id = [[aDictionary objectForKey:@"twitter"] objectForKey:@"id"];
		}
		self.icon_used = [aDictionary stringValueForKey:@"icon_used" defaultValue:@"default"];
        
        // GW only
        if ([aDictionary hasObjectForKey:@"mixi"]) {
            self.mixi_id = [[aDictionary objectForKey:@"mixi"] objectForKey:@"id"];
        }
        self.birthdate      = [aDictionary stringValueForKey:@"birthdate" defaultValue:@""];
        self.blurb          = [aDictionary stringValueForKey:@"blurb" defaultValue:@""];
        self.city           = [aDictionary stringValueForKey:@"city" defaultValue:@""];
        self.friends_count  = [aDictionary intValueForKey:@"friends_count" defaultValue:0];
        self.gender         = [aDictionary stringValueForKey:@"gender" defaultValue:@""];
	}
	PFCLog(PFLOG_CAT_MODEL_PARSER, @"DATAMODEL-PARSE\n%@", self);	// FOR DEBUG
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@ :%p>\n id: %d\n username: %@\n fullname: %@\n country:%@\n icon_url:%@\n twitter_id:%@\n is_guest:%d\n is_secured:%d\n is_following:%d\n is_blocking:%d\n relationships:%p",
			NSStringFromClass([self class]),self,_id, _username, _fullname, _country, _icon_url, _twitter_id, _is_guest, _is_secured, _is_following, _is_blocking, _relationships];
}

@end
