//
//  PFProfileTableView.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFProfileTableHeaderView.h"

@protocol PFProfileTableViewDelegate;

@interface PFProfileTableView : UITableView <UITableViewDelegate, UITableViewDataSource, PFProfileTableViewHeaderDelegate>

//Delegate
@property (nonatomic, assign) id <PFProfileTableViewDelegate> profileTableViewDelegate;

- (void)initUserWithData:(NSDictionary *)userDict;

@end

@protocol PFProfileTableViewDelegate <NSObject>

@optional
- (void)showTalkView:(PFProfile *)user;
- (void)showPictures:(PFProfile *)user;

@end