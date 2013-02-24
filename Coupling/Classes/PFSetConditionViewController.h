//
//  PFSetConditionViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#define kPFSearchConditionNum   17
typedef enum {
    Age = 0,
    Address,
    Introduction,
    HomeTown,
    BloodType,
    Height,
    Body,
    Education,
    Occupation,
    Income,
    Holiday = 10,
    Hobbies,
    Personality,
    Roommate,
    Tabaco,
    Alcohol,
    LastLoginData
}kPFConditionList;

#import <UIKit/UIKit.h>

@interface PFSetConditionViewController : UITableViewController

@end
