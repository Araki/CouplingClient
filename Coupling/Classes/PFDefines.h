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
    Profile_BloodType,      // 血液型
    Profile_Body,           // 体型
    Profile_Education,      // 学歴
    Profile_Occupation,     // 職業
    Profile_Income = 10,    // 年収
    Profile_Holiday,        // 休日
}kPFProfileTitleList;

//-----相手検索条件-----//
#define kPFSearchConditionNum   13

typedef enum {
    Condition_Age = 0,        // 年齢
    Condition_Introduction,   // 自己紹介文
    Condition_People,         // 合コン参加人数
    Condition_Day,            // 合コン参加曜日
    Condition_Time,           // 合コン参加時間
    Condition_GoconAge,       // 合コン参加年齢
    Condition_Location,       // 開催希望場所
    Condition_Body,           // 体型
    Condition_Education,      // 学歴
    Condition_Occupation,     // 職業
    Condition_Income,         // 年収
    Condition_Holiday,        // 休日
    Condition_LastLoginData   // 最終ログイン日
}kPFConditionTitleList;