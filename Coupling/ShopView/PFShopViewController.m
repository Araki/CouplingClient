 //
//  PFShopViewController.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/10/12.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFShopViewController.h"
#import "TapjoyConnect.h"
#import "PFHTTPConnector.h"

@interface PFShopViewController ()

@end

@implementation PFShopViewController
{
    BOOL isLoading;
}

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
    //ここでいいね数・ポイント数を更新
    PFUser *user = [PFUser currentUser];
    [self.pointLabel setText:[NSString stringWithFormat:@"%d",user.points]];
    [self.likeLabel setText:[NSString stringWithFormat:@"%d",user.likePoints]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions
- (IBAction)buyPoints:(id)sender
{
    //ポイント購入画面へ
    
}

- (IBAction)showTapjoy:(id)sender
{
    //[TapjoyConnect showOffersWithViewController:self];
}

- (IBAction)changeLike:(id)sender
{
    if (isLoading) return;
    
    UIButton *btn = (UIButton *)sender;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"いいねを交換しますか？" delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"購入", nil];
    [alertView setTag:btn.tag];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        int buyPoints;
        int cost;
        if (alertView.tag == 0)
        {//いいねx1
            cost = 1;
            buyPoints = 1;
        }
        else if (alertView.tag == 1)
        {//いいねx5
            cost = 5;
            buyPoints = 5;
        }
        else if (alertView.tag == 2)
        {//いいねx5
            cost = 10;
            buyPoints  = 10;
        }
        
        if ([[PFUser currentUser] points] < cost)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"ポイントが足りません" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        //ポイント・いいね数変更
        [[PFUser currentUser] setPoints:[[PFUser currentUser] points] - cost];
        [[PFUser currentUser] setLikePoints:[[PFUser currentUser] likePoints] + buyPoints];
        [[PFUser currentUser] saveToCacheAsCurrentUser];
        //更新
        PFUser *user = [PFUser currentUser];
        [self.pointLabel setText:[NSString stringWithFormat:@"%d",user.points]];
        [self.likeLabel setText:[NSString stringWithFormat:@"%d",user.likePoints]];
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
        [dict setObject:user.sessionId forKey:@"session_id"];
        [dict setObject:[NSString stringWithFormat:@"%d",cost] forKey:@"amount"];
        //購入処理
        isLoading = YES;
        [PFHTTPConnector requestWithCommand:kPFCommendPointsConsume
                                     params:dict
                                  onSuccess:^(PFHTTPResponse *response) {
                                      [PFHTTPConnector requestWithCommand:kPFCommendLikePointsAdd
                                                                onSuccess:^(PFHTTPResponse *response) {
                                                                    isLoading = NO;
                                                                } onFailure:^(NSError *error) {
                                                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"購入に失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                                                    [alert show];
                                                                    isLoading = NO;
                                                                    
                                                                    //ポイント・いいね数変更
                                                                    [[PFUser currentUser] setPoints:[[PFUser currentUser] points] + cost];
                                                                    [[PFUser currentUser] setLikePoints:[[PFUser currentUser] likePoints] - buyPoints];
                                                                    [[PFUser currentUser] saveToCacheAsCurrentUser];
                                                                    //更新
                                                                    PFUser *user = [PFUser currentUser];
                                                                    [self.pointLabel setText:[NSString stringWithFormat:@"%d",user.points]];
                                                                    [self.likeLabel setText:[NSString stringWithFormat:@"%d",user.likePoints]];
                                                                }];
                                  } onFailure:^(NSError *error) {
                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"購入に失敗しました。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                                      [alert show];
                                      isLoading = NO;
                                      
                                      //ポイント・いいね数変更
                                      [[PFUser currentUser] setPoints:[[PFUser currentUser] points] + cost];
                                      [[PFUser currentUser] setLikePoints:[[PFUser currentUser] likePoints] - buyPoints];
                                      [[PFUser currentUser] saveToCacheAsCurrentUser];
                                      //更新
                                      PFUser *user = [PFUser currentUser];
                                      [self.pointLabel setText:[NSString stringWithFormat:@"%d",user.points]];
                                      [self.likeLabel setText:[NSString stringWithFormat:@"%d",user.likePoints]];
                                  }];
    }
}

@end
