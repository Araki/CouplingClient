//
//  PFProfileScrollView.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFProfileTableView.h"

@protocol PFProfileScrollViewDelegate;

@interface PFProfileScrollView : UIScrollView <UIScrollViewDelegate, PFProfileTableViewDelegate>

//Delegate
@property (nonatomic, assign) id <PFProfileScrollViewDelegate> profileScrollViewDelegate;

//ユーザ表示
- (void)initUserWithData:(NSArray *)users;
//ユーザ追加読み込み
- (void)addUserWithData:(NSArray *)users;
//View・ユーザ情報の初期化
- (void)resetData;
//追加読み込み
- (void)addUserLoading;

@end

@protocol PFProfileScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(PFProfileScrollView *)scrollView didScrollPage:(int)currentPage;
- (void)showPictures:(PFProfile *)user;
- (void)showTalkPage:(PFProfile *)user;

@end
