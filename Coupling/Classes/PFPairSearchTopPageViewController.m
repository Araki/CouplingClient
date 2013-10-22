//
//  PFPairSearchTopPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchTopPageViewController.h"
#import "IIViewDeckController.h"
#import "PFSetConditionViewController.h"
#import "PFTalkPageViewController.h"
#import "PFUser.h"
#import "PFCommands.h"
#import "PFHTTPConnector.h"
#import "PFProfileScrollView.h"
#import "PFLoginBonusViewController.h"
#import "PFShopViewController.h"

@interface PFPairSearchTopPageViewController ()

@property (assign) BOOL pageControlUsed;
@property (assign) NSUInteger page;
@property (assign) BOOL rotating;
@property (strong) NSMutableArray *controllers;

@end

@implementation PFPairSearchTopPageViewController
{
    PFProfileScrollView *profileScrollView;
    //表示データ
    NSArray *dataArray;
    //page
    int page;
    //ボーナスView
    PFLoginBonusViewController *bonusView;
    //検索画面
    PFSetConditionViewController *conditionView;
    //ショップView
    PFShopViewController *shopView;
}
@synthesize pageControlUsed = _pageControlUsed;
@synthesize page = _page;
@synthesize rotating = _rotating;
@synthesize controllers = _controllers;

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)initView
{
    profileScrollView = [[PFProfileScrollView alloc] initWithFrame:CGRectMake(0, 44, 320, self.view.frame.size.height - 44)];
    [profileScrollView setProfileScrollViewDelegate:self];
    [self.view addSubview:profileScrollView];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //初期化
    [self initView];
    
    //User情報
    page = 0;
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId,nil] forKeys: [NSArray arrayWithObjects:@"session_id", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendUsersList params:params onSuccess:^(PFHTTPResponse *response) {
        NSDictionary *jsonObject = [response jsonDictionary];
        if([jsonObject objectForKey:@"users"]) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                page ++;
                //ScrollView初期化
                [profileScrollView initUserWithData:[jsonObject objectForKey:@"users"]];
                dataArray = [NSArray arrayWithArray:[jsonObject objectForKey:@"users"]];
            });
        }
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    //ログインボーナス判定
    if ([PFUtil isLoginBonus])
    {
        [self showBonusView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload
{
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - PFProfileScrollView Delegate
- (void)showTalkPage:(PFProfile *)user
{
    [self.navigationController pushViewController:[PFTalkPageViewController new] animated:YES];
}

- (void)showPictures:(PFProfile *)user
{
    
}

- (void)showLikeShop
{
    //いいね数交換ページへ遷移
    shopView = [[PFShopViewController alloc] initWithNibName:@"PFShopViewController" bundle:nil];
    [shopView.view setFrame:self.view.bounds];
    [shopView.view setAlpha:0];
    [shopView.closeButton addTarget:self action:@selector(hideShopView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shopView.view];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [shopView.view setAlpha:1];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideShopView
{
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [shopView.view setAlpha:0];
                     }
                     completion:^(BOOL finished){
                         [shopView.view removeFromSuperview];
                     }];
}

- (void)scrollView:(PFProfileScrollView *)scrollView didScrollPage:(int)currentPage
{
    if ([dataArray count] == 0 || currentPage == 0 || currentPage == 1 ) return;
    
    NSLog(@"page == %d count == %d",currentPage,[dataArray count]);
    
    //ScrollViewのページ遷移Delegate
    if ([dataArray count] - 2 == currentPage)
    {
        //最終ページまでいったので追加読み込み処理
        [scrollView addUserLoading];
        PFUser *user = [PFUser currentUser];
        NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, [NSString stringWithFormat:@"%d",page], @"25",nil] forKeys: [NSArray arrayWithObjects:@"session_id", @"page", @"per",nil]];
        [PFHTTPConnector requestWithCommand:kPFCommendUsersList params:params onSuccess:^(PFHTTPResponse *response) {
            NSDictionary *jsonObject = [response jsonDictionary];
            if([jsonObject objectForKey:@"users"]) {
                dispatch_queue_t mainQueue = dispatch_get_main_queue();
                dispatch_async(mainQueue, ^{
                    page ++;
                    //ScrollView初期化
                    [profileScrollView addUserWithData:[jsonObject objectForKey:@"users"]];
                    NSMutableArray *joinArray = [NSMutableArray arrayWithArray:dataArray];
                    [joinArray addObjectsFromArray:[jsonObject objectForKey:@"users"]];
                    dataArray = [NSArray arrayWithArray:joinArray];
                });
            }
        } onFailure:^(NSError *error) {
            NSLog(@"@@@@@ connection Error: %@", error);
        }];
    }
}

#pragma mark - IBAction
- (IBAction)actionNotificationButton:(UIButton *)sender
{
    NSLog(@"Notifivation");
}

- (IBAction)moveConditionView:(id)sender
{
    if (conditionView == nil)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        conditionView = [storyboard instantiateViewControllerWithIdentifier:@"PFSetConditionViewController"];
        [conditionView setSetConditionViewControllerDelegate:self];
    }
    [self.navigationController pushViewController:conditionView animated:YES];
}

#pragma mark - SetConditionView Delegate
- (void)setSearchCondition:(NSArray *)searchArray
{
    //TODO: 検索条件指定で検索
    
}

#pragma mark - Bonus View
- (void)showBonusView
{
    bonusView = [[PFLoginBonusViewController alloc] initWithNibName:@"PFLoginBonusViewController" bundle:nil];
    [bonusView.view setFrame:self.view.bounds];
    [bonusView.view setAlpha:0];
    [bonusView.doneButton addTarget:self action:@selector(hideBonusView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bonusView.view];
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [bonusView.view setAlpha:1];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideBonusView
{
    [UIView animateWithDuration:0.5f
                     animations:^{
                         [bonusView.view setAlpha:0];
                     }
                     completion:^(BOOL finished){
                         [bonusView.view removeFromSuperview];
                     }];
}

@end
