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
	NSInteger id;
    NSString* nickname;
    NSString* facebook_id;
    NSString* email;
    NSString* introduction;
    NSInteger gender;
    NSInteger age;
    NSInteger blood_type;
    NSInteger proportion;
    NSInteger school;
    NSInteger industry;
    NSInteger job;
    NSInteger income;
    NSInteger holiday;
    NSInteger status;
}

@property (assign, nonatomic) NSInteger id;
@property (retain, nonatomic) NSString *nickname, *facebook_id, *email, *introduction;
@property (assign, nonatomic) NSInteger gender, age, blood_type, proportion, school, industry, job, income, holiday, status;
@property (retain ,nonatomic) NSMutableArray *profileImages; // プロフィール写真リスト(UIImageの配列)

@end
