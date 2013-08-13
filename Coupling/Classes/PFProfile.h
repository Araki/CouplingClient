//
//  PFProfile.h
//  Coupling
//
//  Created by Ryo Kamei on 13/04/29.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFDataModel.h"
#import "PFMultipleProfileModel.h"
#import "PFImageModel.h"

typedef enum {
    female = 0,
    male,
}kGender;


typedef enum {
    slimProportion = 0,     // 細い
    littleSlimProportion,   // ちょっと細い
    normalProportion,       // 普通
    muscularProportion,     // 筋肉質
    littleChubbyProportion, // ややぽっちゃり
    chubbyProPortion,       // ぽっちゃり
    fatProportion,          // 太っている
}kProportion;

typedef enum {
    typeA = 0,
    typeB,
    typeO,
    typeAB,
}kBLoodType;

typedef enum {
    less200 = 0,
    from200to400,
    from400to600,
    from600to800,
    from800to1000,
    from1000to1500,
    over1500,
}kIncomType;

typedef enum {
    highSchool = 0,     // 高卒
    university,         // 大卒
    juniorCollege,      // 短大卒
    vocationalSchool,   // 専門学校
    graduateSchool      // 大学院卒
}kSchoolBackGround;

typedef enum {
    weekEnd = 0,        // 土日休み
    irregular,          // シフト制（不定休）
    nonHoliday,         // 休みなし
    otherHolidayType,   // その他
}kHoliday;



@interface PFProfile : PFDataModel

@property (nonatomic, copy)   NSString *    type;           // TODO:仕様確認
@property (nonatomic, assign) NSInteger     status;         // ユーザーの進行状況などが入る。詳しい仕様は未定
@property (nonatomic, assign) NSInteger     userId;
@property (nonatomic, assign) NSInteger     groupId;
@property (nonatomic, copy)   NSString *    nickName;       // ニックネーム
@property (nonatomic, copy)   NSString *    introduction;   // 自己紹介
@property (nonatomic, assign) kGender       gender;         // 性別
@property (nonatomic, assign) NSInteger     age;            // 年齢

@property (nonatomic, assign) NSInteger     prefecture;     // 県??：都道府県コード番号順に順ずる

@property (nonatomic, assign) kProportion   proportion;     // 体型
@property (nonatomic, assign) kBLoodType    bloodType;      // 血液型

@property (nonatomic, assign) NSInteger     job;            // 仕事の種類：PFUtilのjobsにひもづく
@property (nonatomic, assign) kIncomType    income;         // 収入
@property (nonatomic, assign) kSchoolBackGround schoolBackGoround;  // 最終学歴
@property (nonatomic, assign) kHoliday      holiday;        // 休日：PFUtilのdayoffと紐づく

@property (nonatomic, retain) NSArray *     characters;     // 性格
@property (nonatomic, retain) NSArray *     specialities;   // 特技
@property (nonatomic, retain) NSArray *     images;         // PFImageModelが配列ではいっている


@property (nonatomic, strong) NSDate *      createdAt;
@property (nonatomic, strong) NSDate *      updatedAt;


@end
