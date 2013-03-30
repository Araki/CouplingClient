//
//  PFTalkPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTalkPageViewController.h"

@interface PFTalkPageViewController ()

@end

@implementation PFTalkPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
    [self setBackgroundColor:kPFBackGroundColor];
    // トークする相手の名前をタイトルにする
    self.title = @"Messages";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - JSMessageViewController Delegate

- (JSMessagesViewTimestampPolicy)timestampPolicyForMessagesView
{
    // time stamps のオプション
    return JSMessagesViewTimestampPolicyAll;
}

- (JSBubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // メッセージの吹出しのスタイルを指定する
    return JSBubbleMessageStyleIncomingDefault;
}

- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPathにtime stamp を表示させるかどうか
    return YES;
}

// sendボタンを押してメッセージを送る
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    // messageをpostする必要あり
    
}

#pragma mark - JSMessageViewController DataSource
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"testtetst";
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NSDate date];
}

#pragma mark - Table Views delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

@end
