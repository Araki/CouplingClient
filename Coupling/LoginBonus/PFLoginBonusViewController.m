//
//  PFLoginBonusViewController.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/09/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFLoginBonusViewController.h"

@interface PFLoginBonusViewController ()

@end

@implementation PFLoginBonusViewController

#pragma mark - Init
- (void)initView
{
    //BackGround
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
    //いいね数追加
    [self addLikePoints];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Self Action
- (void)addLikePoints
{
    //いいね数を１増やす
    NSInteger likePoint = [[PFUser currentUser] likePoints];
    likePoint ++;
    [[PFUser currentUser] setLikePoints:likePoint];
    [[PFUser currentUser] saveToCacheAsCurrentUser];
    
    //ラベル反映
    [self.loginBonusLabel setText:[NSString stringWithFormat:@"いいね！所持数 %d",likePoint]];
}

@end
