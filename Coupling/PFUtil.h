//
//  PFUtil.h
//  Coupling
//
//  Created by tsuchimoto on 13/02/24.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define kPFBackGroundColor RGB(222, 220, 200)
#define kPFCommonBackGroundColor RGB(247.0, 245.0, 230.0)

@interface PFUtil : NSObject

+ (NSArray *)prefectures;
+ (NSArray *)bloodTypes;
+ (NSArray *)heights;
+ (NSArray *)bodyShapes;
+ (NSArray *)schoolBackgrounds;
+ (NSArray *)jobs;
+ (NSArray *)incomes;
+ (NSArray *)dayOff;
+ (NSArray *)hobbies;
+ (NSArray *)personalities;
+ (NSArray *)roommates;
+ (NSArray *)smoking;
+ (NSArray *)alcohol;
+ (NSArray *)searchConditionTitles;
+ (NSArray *)introductions;
+ (NSArray *)lastLogines;

// top bar button
+ (UIButton *)slideMenuBarButton;
+ (UIButton *)searchConditionBarButton;
+ (UIButton *)notififcationBarButton;
//+ (UIButton *)myPageStatusBarButtonWithStatus:(NSInteger)status;
+ (UIButton *)addPictureButton;

@end
