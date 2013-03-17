//
//  PFPairSearchProfileViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFPairSearchProfileScrollViewController.h"

@interface PFPairSearchProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *outletProfileImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *outletProfileScrollView;
@property (strong, nonatomic) PFPairSearchProfileScrollViewController *profileScrollPageViewcontroller;// スクロールするプロフィールページ

@end
