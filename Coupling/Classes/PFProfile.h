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
    single = 0,         // 1人暮らし
    withFamiry,         // 親や兄弟と同居
    withRoommate,       // ルームメイトと同居
    otherRoommateType,  // その他
}kRoommate;

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
    notSmoking = 0, // 吸わない
    sometimesSmoke, // 時々吸う
    smoke           // 吸う
}kSmoking;

typedef enum {
    cantDrink = 0,      // 飲めない
    canDrinkButDislike, // 飲めるが好きではない
    drinkSocially,      // 付き合い程度に飲む
    loveDrink,          // 大好き
}kAlcohol;

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

@property (nonatomic, assign) NSInteger     birthPlace;     // 出身地：都道府県コード番号順に順ずる
@property (nonatomic, assign) NSInteger     prefecture;     // 県??：都道府県コード番号順に順ずる

@property (nonatomic, assign) kRoommate     roommate;       // ルームメイト
@property (nonatomic, assign) NSInteger     height;         // 身長
@property (nonatomic, assign) kProportion   proportion;     // 体型
@property (nonatomic, assign) kBLoodType    bloodType;      // 血液型

@property (nonatomic, assign) NSInteger     marialHistory; // TODO:仕様確認
@property (nonatomic, assign) NSInteger     marriageTime;  // TODO:仕様確認

@property (nonatomic, assign) kSmoking      smoking;        // タバコ
@property (nonatomic, assign) kAlcohol      alcohol;        // お酒

@property (nonatomic, assign) NSInteger     job;            // 仕事の種類：PFUtilのjobsにひもづく
@property (nonatomic, copy)   NSString *    jobDescription; // 仕事についての詳細
@property (nonatomic, copy)   NSString *    workPlace;      // 職場
@property (nonatomic, assign) kIncomType    income;         // 収入
@property (nonatomic, assign) kSchoolBackGround schoolBackGoround;  // 最終学歴
@property (nonatomic, assign) kHoliday      holiday;        // 休日：PFUtilのdayoffと紐づく
@property (nonatomic, assign) NSInteger     sociability;    // 社交性：personalitiesとひもづく
@property (nonatomic, copy)   NSString *    dislike;        // 嫌いな物

@property (nonatomic, retain) NSArray *     characters;     // 性格
@property (nonatomic, retain) NSArray *     hobbies;        // 趣味
@property (nonatomic, retain) NSArray *     specialities;   // 特技
@property (nonatomic, retain) NSArray *     images;         // PFImageModelが配列ではいっている


@property (nonatomic, strong) NSDate *      createdAt;
@property (nonatomic, strong) NSDate *      updatedAt;


@end
