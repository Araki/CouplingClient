//
//  PFUtil.m
//  Coupling
//
//  Created by tsuchimoto on 13/02/24.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFUtil.h"

@implementation PFUtil

+ (NSArray *)prefectures
{
    return [NSArray arrayWithObjects:@"北海道",
    @"青森県",
    @"岩手県",
    @"宮城県",
    @"秋田県",
    @"山形県",
    @"福島県",
    @"群馬県",
    @"栃木県",
    @"茨城県",
    @"埼玉県",
    @"千葉県",
    @"東京都",
    @"神奈川県",
    @"新潟県",
    @"富山県",
    @"石川県",
    @"福井県",
    @"山梨県",
    @"長野県",
    @"岐阜県",
    @"静岡県",
    @"愛知県",
    @"三重県",
    @"滋賀県",
    @"京都府",
    @"大阪府",
    @"兵庫県",
    @"奈良県",
    @"和歌山県",
    @"鳥取県",
    @"島根県",
    @"岡山県",
    @"広島県",
    @"山口県",
    @"徳島県",
    @"香川県",
    @"愛媛県",
    @"高知県",
    @"福岡県",
    @"佐賀県",
    @"長崎県",
    @"熊本県",
    @"大分県",
    @"宮崎県",
    @"鹿児島県",
    @"沖縄県", nil];
}

+ (NSArray *)bloodTypes
{
    return [NSArray arrayWithObjects:@"A", @"B", @"O", @"AB", nil];
}

+ (NSArray *)bodyShapes
{
    return [NSArray arrayWithObjects:@"スリム（細め)", @"やや細め", @"普通", @"グラマー", @"筋肉質" , @"ややぽっちゃり", @"ぽっちゃり", @"太め", nil];
}

+ (NSArray *)schoolBackgrounds
{
    return [NSArray arrayWithObjects:@"高校卒", @"大学卒", @"短大卒", @"専門学校卒", @"大学院卒", @"その他", nil];
}

+ (NSArray *)jobs
{
    return [NSArray arrayWithObjects:@"会社員", @"医師", @"弁護士", @"公認会計士", @"経営者・役員", @"公務員", @"事務員", @"大手商社", @"外資金融", @"大手企業", @"大手外資", @"マスコミ・広告", @"クリエイター", @"IT関連", @"パイロット", @"客室乗務員", @"芸能・モデル", @"アパレル・ショップ", @"アナウンサー", @"イベントコンパニオン", @"受付", @"秘書", @"看護師", @"保育士", @"自由業", @"学生", @"その他", nil];
}

+ (NSArray *)incomes
{
    return [NSArray arrayWithObjects:@"200万円未満", @"200万円～400万円", @"400万円～600万円", @"600万円～800万円", @"800万円～1000万円", @"1000万円～1500万円", @"1500万円以上", nil];
}

+ (NSArray *)dayOff
{
    return [NSArray arrayWithObjects:@"土日", @"シフト制", @"なし", @"その他", nil];
}

+ (NSArray *)introductions
{
    return @[@"記入あり", @"記入なし"];
}


+ (NSArray *)lastLogines
{
    return @[@"24時間以内", @"3日以内", @"1週間以内", @"1ヶ月以内", @"1ヶ月以上"];
}

+ (NSArray *)searchConditionTitles
{
    return @[@"年齢",
             @"住所",
             @"自己紹介文",
             @"血液型",
             @"体型",
             @"学歴",
             @"職業",
             @"年収",
             @"休日",
             @"最終ログイン日"];
}

+ (NSArray *)profileTitles
{
    return @[@"ニックネーム",
             @"誕生日",
             @"住所",
             @"自己紹介文",
             @"血液型",
             @"体型",
             @"学歴",
             @"職業",
             @"年収",
             @"休日"];
}

+ (NSArray *)myPageSortList
{
    return @[@"お互い",
             @"相手から",
             @"自分から",
             @"お気に入り"];
}

// top bar button
+ (UIButton *)slideMenuBarButton
{
    return [PFUtil buttonWithName:@"button_slide_menu.png" rect:CGRectMake(0, 0, 28, 28)];
}

+ (UIButton *)searchConditionBarButton
{
    return [PFUtil buttonWithName:@"button_search_filter.png" rect:CGRectMake(0, 0, 63, 26)];
}

+ (UIButton *)notififcationBarButton
{
    return [PFUtil buttonWithName:@"button_notification.png" rect:CGRectMake(0, 0, 28, 28)];
}

+ (UIButton *)backButton
{
    return [PFUtil buttonWithName:@"button_back.png" rect:CGRectMake(0, 0, 28.5, 28.5)];
}
/*
+ (UIButton *)myPageStatusBarButtonWithStatus:(NSInteger)status
{
    
}
*/
+ (UIButton *)addPictureButton
{
    return [PFUtil buttonWithName:@"button_add_picture.png" rect:CGRectMake(0, 0, 73, 26)];
}

+ (UIButton *)buttonWithName:(NSString *)name rect:(CGRect)rect
{
    UIImage *buttonImage = [UIImage imageNamed:name];
    UIButton *barButton = [[UIButton alloc] initWithFrame:rect];
    [barButton setImage:buttonImage forState:UIControlStateNormal];
    return barButton;
}

+ (BOOL)is4inch
{
    if ([[UIScreen mainScreen] bounds].size.height >= 568.0f)
    {
        return YES;
    }
    return NO;
}

@end
