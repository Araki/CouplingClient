//
//  MyPageDataManager.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/11/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    SortTyp_All = 0,
    SortTyp_CanTalk,
    SortTyp_GoodFromPartner,
    SortTyp_GoodFromMe,
    SortTyp_Favorite,
}kPFMyPageSortType;

typedef void (^changeDataHandler)(NSArray *dataArray, kPFMyPageSortType sortType);

@interface MyPageDataManager : NSObject

//インスタンス作成
+ (MyPageDataManager *)sharedManager;

//データきりかえ
- (void)changeDataWithType:(kPFMyPageSortType)sortType onComplete:(changeDataHandler)cHandler;
//追加読み込み
- (void)addLoadDataWithType:(kPFMyPageSortType)sortType onComplete:(changeDataHandler)cHandler;

@end
