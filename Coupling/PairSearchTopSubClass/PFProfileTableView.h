//
//  PFProfileTableView.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFProfileTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

- (void)initUserWithData:(NSDictionary *)userDict;

@end
