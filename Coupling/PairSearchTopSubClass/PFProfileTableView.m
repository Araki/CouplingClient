//
//  PFProfileTableView.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfileTableView.h"
#import "PFProfileTableHeaderView.h"
#import "PFProfile.h"
#import "PFProfileTableViewCell.h"

@implementation PFProfileTableView
{
    //ヘッダーView
    PFProfileTableHeaderView *headerView;
    //ユーザ情報
    PFProfile *user;
}

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDelegate:self];
        [self setDataSource:self];
        //初期化
        [self initTableView];
    }
    return self;
}

- (void)initTableView
{
    //ヘッダー
    headerView = [[PFProfileTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, 320, 320 + 80)];
    [headerView setHeaderViewDelegate:self];
    [self setTableHeaderView:headerView];
}

- (void)initUserWithData:(NSDictionary *)userDict
{
    [self setContentOffset:CGPointZero];
    
    if ([userDict objectForKey:@"profile"] == [NSNull null])
    {
        return;
    }
    
    //情報セット
    user = [[PFProfile alloc] initWithDictionary:[userDict objectForKey:@"profile"]];
    //ヘッダーセット
    [headerView initViewWithUser:[userDict objectForKey:@"profile"]];
    
    [self reloadData];
}

#pragma mark - PFProfile HeaderView Delegate
- (void)showPictures
{
    [self.profileTableViewDelegate showPictures:user];
}

- (void)showTalkPage
{
    [self.profileTableViewDelegate showTalkView:user];
}

#pragma mark - UITableView Delegate
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (user != nil)
    {
        return 13;
    }
    else
    {
       return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PFProfileTableViewCell *cell = (PFProfileTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"PFProfileTableViewCell"];
    if (cell == nil)
    {
        cell = [[PFProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PFProfileTableViewCell"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 8 || indexPath.row == 4 || indexPath.row == 5)
    {
        NSString *description = @"";
        if (indexPath.row == 0)
        {
            description = [user introduction];
        }
        CGSize size = [description sizeWithFont:[UIFont fontWithName:@"Helvetica" size:13.0f] constrainedToSize:CGSizeMake(200, 500) lineBreakMode:UILineBreakModeWordWrap];
        if (size.height <= 30)
        {
            if (indexPath.row == 0)
            {
                return 50;
            }
            else
            {
                return 30;
            }
        }
        else
        {
            if (indexPath.row == 0)
            {
                return size.height + 28;
            }
            else
            {
                return size.height + 10;
            }
        }
    }
    else
    {
        return 30;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(PFProfileTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell initCell:user withRow:indexPath.row];
}

@end
