//
//  PFGroup.h
//  Coupling
//
//  Created by Ryo Kamei on 13/05/18.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFProfile.h"

@interface PFGroup : PFDataModel

@property (nonatomic, retain) PFProfile *   leader; // グループのリーダー
@property (nonatomic, retain) NSArray *     friends; // リーダーの友達, PFProfileが入っている。
@property (nonatomic, copy)   NSString *    area;
@property (nonatomic, copy)   NSString *    relationship;
@property (nonatomic, copy)   NSString *    request;
@property (nonatomic, assign) NSInteger     headCount;
@property (nonatomic, assign) NSInteger     maxAge;
@property (nonatomic, assign) NSInteger     minAge;
@property (nonatomic, assign) NSInteger     status;
@property (nonatomic, assign) NSInteger     targetAgeRange;
@property (nonatomic, assign) NSInteger     userId;
@property (nonatomic, retain) NSDate *      openingHour;

@end
