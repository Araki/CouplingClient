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
    return [NSArray arrayWithObjects:@"A", @"B", @"C", @"O", @"AB", nil];
}

+ (NSArray *)heights
{
    return [NSArray arrayWithObjects:@"130",
            @"131",
            @"132",
            @"133",
            @"134",
            @"135",
            @"136",
            @"137",
            @"138",
            @"139",
            @"140",
            @"141",
            @"142",
            @"143",
            @"144",
            @"145",
            @"146",
            @"147",
            @"148",
            @"149",
            @"150",
            @"151",
            @"152",
            @"153",
            @"154",
            @"155",
            @"156",
            @"157",
            @"158",
            @"159",
            @"160",
            @"161",
            @"162",
            @"163",
            @"164",
            @"165",
            @"166",
            @"167",
            @"168",
            @"169",
            @"170",
            @"171",
            @"172",
            @"173",
            @"174",
            @"175",
            @"176",
            @"177",
            @"178",
            @"179",
            @"180",
            @"181",
            @"182",
            @"183",
            @"184",
            @"185",
            @"186",
            @"187",
            @"188",
            @"189",
            @"190",
            @"191",
            @"192",
            @"193",
            @"194",
            @"195",
            @"196",
            @"197",
            @"198",
            @"199",
            @"200",
            @"201",
            @"202",
            @"203",
            @"204",
            @"205",
            @"206",
            @"207",
            @"208",
            @"209",
            @"210",
            nil];
}

+ (NSArray *)bodyShapes
{
    return [NSArray arrayWithObjects:@"スリム（細め)", @"やや細め", @"普通", @"筋肉質" , @"ややぽっちゃり", @"ぽっちゃり", @"太め", nil];
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

+ (NSArray *)hobbies
{
    return [NSArray arrayWithObjects:@"映画鑑賞", @"スポーツ", @"スポーツ観戦", @"音楽鑑賞", @"カラオケ", @"バンド", @"料理", @"グルメ", @"お酒", @"ショッピング", @"ファッション", @"アウトドア", @"車", @"バイク" @"ドライブ", @"習いごと", @"語学", @"読書", @"漫画" @"テレビ", @"ゲーム", @"インターネット", @"ギャンブル", @"ペット", @"フィットネス", @"株式投資", @"その他", @"特になし", nil];
}

+ (NSArray *)personalities
{
    return [NSArray arrayWithObjects:@"優しい", @"素直", @"誠実", @"明るい", @"社交的", @"人見知り", @"知的", @"ドライ", @"ロマンチスト", @"几帳面", @"穏やか", @"寂しがり", @"負けず嫌い", @"家庭的", @"優柔不断", @"決断力がある", @"天然", @"インドア", @"アウトドア", @"楽観的", @"真面目", @"知的", @"照れ屋", @"いつも笑顔", @"上品", @"落ち着いている", @"謙虚", @"厳格", @"冷静", @"好奇心旺盛", @"家庭的", @"仕事好き", @"責任感がある", @"包容力がある", @"面白い", @"さわやか", @"行動力がある", @"熱い", @"気が利く", nil];
}

+ (NSArray *)introductions
{
    return @[@"記入あり", @"記入なし"];
}


+ (NSArray *)lastLogines
{
    return @[@"24時間以内", @"3日以内", @"1週間以内", @"1ヶ月以内", @"1ヶ月以上"];
}

+ (NSArray *)roommates
{
    return [NSArray arrayWithObjects:@"1人暮らし", @"親や兄弟と同居", @"ルームメイトと同居", @"その他", nil];
}

+ (NSArray *)smoking
{
    return [NSArray arrayWithObjects:@"吸わない", @"時々吸う", @"吸う", nil];
}

+ (NSArray *)alcohol
{
    return [NSArray arrayWithObjects:@"飲めない", @"飲めるが好きではない", @"つきあい程度に飲む", @"大好き", nil];
}

+ (NSArray *)searchConditionTitles
{
    return @[@"年齢",
             @"住所",
             @"自己紹介文",
             @"出身地",
             @"血液型",
             @"身長",
             @"体型",
             @"学歴",
             @"職業",
             @"年収",
             @"休日",
             @"趣味・活動",
             @"性格",
             @"同居人",
             @"タバコ",
             @"お酒",
             @"最終ログイン日"];
}

+ (NSArray *)profileTitles
{
    return @[@"ニックネーム",
             @"誕生日",
             @"住所",
             @"自己紹介文",
             @"出身地",
             @"血液型",
             @"身長",
             @"体型",
             @"学歴",
             @"職業",
             @"年収",
             @"休日",
             @"趣味・活動",
             @"性格",
             @"同居人",
             @"タバコ",
             @"お酒"];
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

@end
