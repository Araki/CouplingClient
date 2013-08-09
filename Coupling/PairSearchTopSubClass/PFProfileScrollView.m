//
//  PFProfileScrollView.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfileScrollView.h"
#import "PFProfileTableView.h"

@implementation PFProfileScrollView
{
    //ユーザ情報配列
    NSMutableArray *usersArray;
    //表示TableView
    PFProfileTableView *leftTableView;
    PFProfileTableView *centerTableview;
    PFProfileTableView *rightTableView;
    //表示カウント
    int currentPage;
    //表示フラグ
    BOOL isShow;
    BOOL isScroll;
}

#pragma mark - Init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initView];
    }
    return self;
}

- (void)initView
{
    //初期化
    usersArray  = [NSMutableArray arrayWithCapacity:0];
    currentPage = 0;
    //ScrollView
    [self setPagingEnabled:YES];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setDelegate:self];
    [self setContentSize:CGSizeMake(320 * 3, self.frame.size.height)];
    [self setContentOffset:CGPointMake(320 * 1, 0)];
    
    //TableView初期化
    leftTableView   = [[PFProfileTableView alloc] initWithFrame:CGRectMake(0  , 0, 320, self.frame.size.height)];
    centerTableview = [[PFProfileTableView alloc] initWithFrame:CGRectMake(320, 0, 320, self.frame.size.height)];
    rightTableView  = [[PFProfileTableView alloc] initWithFrame:CGRectMake(640, 0, 320, self.frame.size.height)];
    [self addSubview:leftTableView];
    [self addSubview:centerTableview];
    [self addSubview:rightTableView];
        
    [leftTableView   setHidden:YES];
    [centerTableview setHidden:YES];
    [rightTableView  setHidden:YES];
    
}

#pragma mark - Self Methods
- (void)initUserWithData:(NSArray *)users
{
    if (usersArray == users) return;
    if ([users count] == 0)
    {
        [self setScrollEnabled:NO];
        return;
    }
    
    [self setScrollEnabled:YES];
    
    currentPage = 0;
    isShow = YES;
    
    usersArray = [NSMutableArray arrayWithArray:users];
    
    [self setViews];
}

- (void)addUserWithData:(NSArray *)users
{
    
    
}

- (void)resetData
{
    usersArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)setViews
{
    //表示ページが端っこであれば
    if (currentPage == 0)
    {
        isShow = YES;
        
        [leftTableView initUserWithData:[usersArray objectAtIndex:currentPage]];
        [leftTableView setHidden:NO];
        
        [centerTableview initUserWithData:[usersArray objectAtIndex:currentPage + 1]];
        [centerTableview setHidden:NO];
        
        [rightTableView setHidden:YES];
        
        [self setContentSize:CGSizeMake(320 * 2, self.frame.size.height)];
        [self setContentOffset:CGPointMake(0, 0)];
    }
    else if (currentPage == [usersArray count] - 1)
    {
        isShow = NO;
        
        [leftTableView initUserWithData:[usersArray objectAtIndex:currentPage - 1]];
        [leftTableView setHidden:NO];
        
        [centerTableview initUserWithData:[usersArray objectAtIndex:currentPage]];
        [centerTableview setHidden:NO];
        
        [rightTableView setHidden:YES];
        
        [self setContentSize:CGSizeMake(320 * 2, self.frame.size.height)];
        [self setContentOffset:CGPointMake(320, 0)];
    }
    else
    {
        isShow = NO;
        
        //表示view
        [centerTableview initUserWithData:[usersArray objectAtIndex:currentPage]];
        [centerTableview setHidden:NO];
        
        //非表示view
        [leftTableView initUserWithData:[usersArray objectAtIndex:currentPage -1]];
        [leftTableView setHidden:NO];
        
        [rightTableView initUserWithData:[usersArray objectAtIndex:currentPage + 1]];
        [rightTableView setHidden:NO];
    
        [self setContentSize:CGSizeMake(320 * 3, self.frame.size.height)];
        [self setContentOffset:CGPointMake(320, 0)];
    }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    
    if (x == 0)
    {
        //左にスクロール
        if (!isShow)
        {
            currentPage --;
            [self setViews];
        }
    }
    else if (x == 640)
    {
        //右にスクロール
        currentPage ++;
        [self setViews];
        
    }else if (x == 320)
    {
        if (isShow)
        {
            currentPage ++;
            [self setViews];
        }
    }
}


@end
