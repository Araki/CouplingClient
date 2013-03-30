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
    
    
    //--------dummy data----------
    PFTalkDataModel *data1 = [[PFTalkDataModel alloc] init];
    data1.isFromUser = NO;
    data1.message = @"it's partner's first message";
    data1.timeStamp = [NSDate date];
    PFTalkDataModel *data2 = [[PFTalkDataModel alloc] init];
    data2.isFromUser = YES;
    data2.message = @"it's my first message";
    data2.timeStamp = [NSDate date];
    self.talkDataArray = [NSMutableArray array];
    [self.talkDataArray addObject:data1];
    [self.talkDataArray addObject:data2];
    //----------------------------
    
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
    if ([[self.talkDataArray objectAtIndex:indexPath.row] isFromUser]) {
        // ユーザーから
        return JSBubbleMessageStyleOutgoingDefault;
    } else {
        // 相手から
        return JSBubbleMessageStyleIncomingDefault;
    }
}

- (BOOL)hasTimestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // indexPathにtime stamp を表示させるかどうか
    return YES;
}

// sendボタンを押してメッセージを送る
- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    // talkDataArrayにTalkDataModelを追加する
    PFTalkDataModel *data = [[PFTalkDataModel alloc] init];
    data.isFromUser = YES;
    data.message = text;
    data.timeStamp = [NSDate date];
    
    [self.talkDataArray addObject:data];
    // messageをpostする必要あり
    
    
    [self finishSend];
}

#pragma mark - JSMessageViewController DataSource
- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.talkDataArray objectAtIndex:indexPath.row] message];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[self.talkDataArray objectAtIndex:indexPath.row] timeStamp];
}

#pragma mark - Table Views delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.talkDataArray.count;
}

@end
