//
//  PFShopViewController.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/10/12.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFShopViewController.h"

@interface PFShopViewController ()

@end

@implementation PFShopViewController

#pragma mark - Init
- (void)initView
{
    //BackGround
    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3f]];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //TODO: ここでいいね数・ポイント数を更新
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions
- (IBAction)buyPoints:(id)sender
{

}

- (IBAction)showTapjoy:(id)sender
{

}

- (IBAction)changeLike:(id)sender
{

}

@end
