//
//  PFProfileTableHeaderView.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFProfile.h"

@protocol PFProfileTableViewHeaderDelegate; 

@interface PFProfileTableHeaderView : UIView

//Delagte
@property (nonatomic, assign) id <PFProfileTableViewHeaderDelegate> headerViewDelegate;

- (void)initViewWithUser:(NSDictionary *)user;

@end

@protocol PFProfileTableViewHeaderDelegate <NSObject>

@optional
- (void)showPictures;
- (void)showTalkPage;

@end
