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
    [self.tableView setBackgroundColor:kPFBackGroundColor];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MessageTableViewController methods

- (BubbleMessageStyle)messageStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // メッセージの吹出しのスタイルを指定する
    return BubbleMessageStyleIncoming;
//    return BubbleMessageStyleOutgoing;
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"testtetst";
}

- (void)sendPressed:(UIButton *)sender withText:(NSString *)text
{
    
}

#pragma mark - Table Views delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

@end
