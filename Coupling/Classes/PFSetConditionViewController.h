//
//  PFSetConditionViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#define kPFSearchConditionNum   17
typedef enum {
    Age = 0,        // 年齢
    Address,        // 居住地
    Introduction,   // 自己紹介文
    HomeTown,       // 出身地
    BloodType,      // 血液型
    Height,         // 身長
    Body,           // 体型
    Education,      // 学歴
    Occupation,     // 職業
    Income,         // 年収
    Holiday = 10,   // 休日
    Hobbies,        // 趣味・活動
    Personality,    // 性格
    Roommate,       // 同居人
    Tabaco,         // タバコ
    Alcohol,        // お酒
    LastLoginData   // 最終ログイン日
}kPFConditionList;

#import <UIKit/UIKit.h>
#import "PFActionSheet.h"

@interface PFSetConditionViewController : UITableViewController <PFActionSheetDelegate>

@property (strong, nonatomic) PFActionSheet *actionSheet;
@property (strong, nonatomic) NSIndexPath *currentPath;

@end
