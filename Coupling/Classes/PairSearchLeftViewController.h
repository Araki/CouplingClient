//
//  PairSearchLeftViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPFSlideMenuHeight      36
#define kPFSlideMenuButtonTag   1000
typedef enum {
    PairSearch = 0,
    MyPage,
    Profile,
    Shop,
    Setting,
    Notification,
    Invite,
    Help,
    TermsOfUse,
    ContactUs
}kPFSlideMenuList;

@interface PairSearchLeftViewController : UITableViewController

@end
