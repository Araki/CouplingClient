//
//  PFPairSearchProfileViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFScrollingProfilePageViewController.h"

@interface PFPairSearchProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *outletProfileImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *outletProfileScrollView;
@property (strong, nonatomic) PFScrollingProfilePageViewController *scrollingProfileView;// スクロールするプロフィールページ

@property (weak,nonatomic) NSDictionary *user_dic;
@end
