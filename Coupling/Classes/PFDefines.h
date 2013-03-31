//
//  PFDefines.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/31.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//


//-----プロフィール-----//
#define kPFProfileTitleListNum   17

typedef enum {
    Profile_NickName = 0,   // ニックネーム
    Profile_Birthdate,      // 誕生日
    Profile_Address,        // 居住地
    Profile_Introduction,   // 自己紹介文
    Profile_HomeTown,       // 出身地
    Profile_BloodType,      // 血液型
    Profile_Height,         // 身長
    Profile_Body,           // 体型
    Profile_Education,      // 学歴
    Profile_Occupation,     // 職業
    Profile_Income = 10,    // 年収
    Profile_Holiday,        // 休日
    Profile_Hobbies,        // 趣味・活動
    Profile_Personality,    // 性格
    Profile_Roommate,       // 同居人
    Profile_Tabaco,         // タバコ
    Profile_Alcohol,        // お酒
}kPFProfileTitleList;

//-----相手検索条件-----//
#define kPFSearchConditionNum   17

typedef enum {
    Condition_Age = 0,        // 年齢
    Condition_Address,        // 居住地
    Condition_Introduction,   // 自己紹介文
    Condition_HomeTown,       // 出身地
    Condition_BloodType,      // 血液型
    Condition_Height,         // 身長
    Condition_Body,           // 体型
    Condition_Education,      // 学歴
    Condition_Occupation,     // 職業
    Condition_Income,         // 年収
    Condition_Holiday = 10,   // 休日
    Condition_Hobbies,        // 趣味・活動
    Condition_Personality,    // 性格
    Condition_Roommate,       // 同居人
    Condition_Tabaco,         // タバコ
    Condition_Alcohol,        // お酒
    Condition_LastLoginData   // 最終ログイン日
}kPFConditionTitleList;