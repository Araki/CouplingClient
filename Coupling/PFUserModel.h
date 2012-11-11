//
//  PFUserModel.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFDataModel.h"

/**
 @brief ユーザに関するJSONから作られる構造体
 */
@interface PFUserModel : PFDataModel {
	NSInteger _id;
	NSString* _username;
	NSString* _fullname;
	NSString* _country;
	NSString* _icon_url;
	BOOL _is_guest;
	BOOL _is_secured;
	NSString *_twitter_id;
    NSString *_facebook_id;
	BOOL _is_following;
    BOOL is_followed;
	BOOL _is_blocking;
	NSArray *_relationships;
	NSString* icon_used;
    NSString* email;
    
    // GW only
    NSString *birthdate, *blurb, *city, *gender, *mixi_id; // GW only
    int friends_count;
}

@property (assign, nonatomic) NSInteger id;
@property (retain, nonatomic) NSString *username, *fullname, *country, *icon_url, *twitter_id, *facebook_id;
@property (assign, nonatomic) BOOL is_guest, is_secured, is_following, is_blocking, is_followed;
@property (retain, nonatomic) NSArray *relationships;
@property (retain, nonatomic) NSString* icon_used;
@property (retain, nonatomic) NSDictionary* informationDictionary;
@property (retain, nonatomic) NSString* externalId;
@property (retain, nonatomic) NSString* email;

// GW only
@property (retain, nonatomic) NSString *birthdate, *blurb, *city, *gender, *mixi_id;
@property (assign, nonatomic) int friends_count;
@end
