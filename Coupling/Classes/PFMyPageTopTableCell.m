//
//  PFMyPageTopTableCell.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyPageTopTableCell.h"
#import "PSImageDownloader.h"
#import "PFHTTPConnector.h"

@implementation PFMyPageTopTableCell
{
    NSDictionary *user;
    kPFMyPageSortType state;
    BOOL isFavorite;
    BOOL isLike;
}

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.backgroundColor = kPFBackGroundColor;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)initView
{
    
}

#pragma mark - Self Methods
- (void)initCellWithData:(NSDictionary *)userData withShowType:(kPFMyPageSortType)type
{
    user = userData;
    state = type;
    //ユーザ名
    self.outletUserNameLabel.text = [[userData objectForKey:@"profile"] objectForKey:@"nickname"];
    //ユーザ歳
    self.outletUserAgeLabel.text = [NSString stringWithFormat:@"%@歳",[[userData objectForKey:@"profile"] objectForKey:@"age"]];
    //ユーザ居住地
    self.outletUserAddressLabel.text = [NSString stringWithFormat:@"%@",[[PFUtil prefectures] objectAtIndex:[[[userData objectForKey:@"profile"] objectForKey:@"prefecture"] intValue]]];
    //仮写真
    //NSString *imageUrl = [[[[userData objectForKey:@"profile"] objectForKey:@"images"] objectAtIndex:0] objectForKey:@"url"];
    NSString *imageUrl = @"http://huhennews.net/images/pro/m3391-4223-12040109-2.jpg";
    [[PSImageDownloader sharedInstance] getImage:imageUrl
                                      onComplete:^(UIImage *image, NSString *url, NSError *error) {
                                          if (error == nil)
                                          {
                                              if ([imageUrl isEqualToString:url])
                                              {
                                                  [self.outletUserPictureImage setImage:image];
                                              }
                                          }
                                      }];
    //いいね判定
    if (type == SortTyp_GoodFromPartner)
    {
        //いいねされている
        [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_be_liked"] forState:UIControlStateNormal];
        [self checkLike];
    }
    else if (type == SortTyp_GoodFromMe)
    {
        //いいねした
        [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_liked"] forState:UIControlStateNormal];
    }
    else if (type == SortTyp_CanTalk)
    {
        //トーク
        [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_talk"] forState:UIControlStateNormal];
    }
    else
    {
        //TODO: 仮の画像
        [self.outletStatusButton setImage:[UIImage imageNamed:@"button_like"] forState:UIControlStateNormal];
        [self checkLike];
    }
    //お気に入り判定
    if (type == SortTyp_Favorite)
    {
        //お気に入りにいれている
        isFavorite = YES;
        [self.outletFavoriteButton setTitle:@"★" forState:UIControlStateNormal];
    }
    else
    {
        isFavorite = NO;
        [self.outletFavoriteButton setTitle:@"☆" forState:UIControlStateNormal];
    }
    [self checkFavorite];
}

#pragma mark - IBActions
- (IBAction)favorite:(id)sender
{
    PFUser *current = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:current.sessionId, [user objectForKey:@"id"],nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    
    if (isFavorite)
    {
        //お気に入り解除        
        [PFHTTPConnector postWithCommand:kPFCommendFavoritesDelete
                                  params:params onSuccess:^(PFHTTPResponse *response) {
                                      NSString *status = [[response jsonDictionary] valueForKey:@"status"];
                                      if([status isEqualToString:@"ok"] || [status isEqualToString:@"OK"])
                                      {
                                          dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                          dispatch_async(mainQueue, ^{
                                              isFavorite = NO;
                                              [self.outletFavoriteButton setTitle:@"☆" forState:UIControlStateNormal];
                                          });
                                      }
                                  } onFailure:^(NSError *error) {
                                      NSLog(@"@@@@@ connection Error: %@", error);
                                  }];
    }
    else
    {
        //お気に入り登録
        [PFHTTPConnector postWithCommand:kPFCommendFavoritesCreate
                                  params:params onSuccess:^(PFHTTPResponse *response) {
                                      NSString *status = [[response jsonDictionary] valueForKey:@"status"];
                                      if([status isEqualToString:@"ok"] || [status isEqualToString:@"OK"])
                                      {
                                          dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                          dispatch_async(mainQueue, ^{
                                              isFavorite = YES;
                                              [self.outletFavoriteButton setTitle:@"★" forState:UIControlStateNormal];
                                          });
                                      }
                                  } onFailure:^(NSError *error) {
                                      NSLog(@"@@@@@ connection Error: %@", error);
                                  }];
    }
}

- (IBAction)changeState:(id)sender
{
    if (state == SortTyp_CanTalk)
    {
        //トーク画面へ
        [self.myPageTopTableCellDelegate showTalkView:user];
    }
    else if (state == SortTyp_GoodFromMe)
    {
        //なにもしない
    }
    else
    {
        //いいね動作
        PFUser *current = [PFUser currentUser];
        if (current.likePoints == 0)
        {
            //いいねできない
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ" message:@"いいね数が不足しています" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            NSString *message = [NSString stringWithFormat:@"残り%dいいね！です。本当にいいねしていいですか？",[current likePoints]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"確認" message:message delegate:self cancelButtonTitle:@"キャンセル" otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
}

#pragma mark - Check User
- (void)checkLike
{
    PFUser *current = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:current.sessionId, [user objectForKey:@"id"],nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id",nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesShow params:params onSuccess:^(PFHTTPResponse *response) {
        NSString *status = [[response jsonDictionary] valueForKey:@"status"];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if([status isEqualToString:@"OK"] || [status isEqualToString:@"ok"])
            {
                //いいね済み
                if (state == SortTyp_GoodFromPartner)
                {
                    state = SortTyp_CanTalk;
                    [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_talk"] forState:UIControlStateNormal];
                }
                else
                {
                    state = SortTyp_GoodFromMe;
                    [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_liked"] forState:UIControlStateNormal];
                }
            } 
        });
        
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)checkFavorite
{
    PFUser *current = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:current.sessionId, [user objectForKey:@"id"],nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendFavoritesShow params:params onSuccess:^(PFHTTPResponse *response) {
        NSString *status = [[response jsonDictionary] valueForKey:@"status"];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if([status isEqualToString:@"OK"] || [status isEqualToString:@"ok"]) {
                //お気に入り済み
                isFavorite = YES;
                [self.outletFavoriteButton setTitle:@"★" forState:UIControlStateNormal];
            } else {
                isFavorite = NO;
                [self.outletFavoriteButton setTitle:@"☆" forState:UIControlStateNormal];
            }
        });
    } onFailure:^(NSError *error) {
    }];
}

#pragma mark - UIAlerView Deleate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        //いいねを行う
        PFUser *current = [PFUser currentUser];
        NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:current.sessionId, [user objectForKey:@"id"],nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
        
        [PFHTTPConnector postWithCommand:kPFCommendLikesCreate
                                  params:params onSuccess:^(PFHTTPResponse *response) {
                                      NSString *status = [[response jsonDictionary] valueForKey:@"status"];
                                      if([status isEqualToString:@"OK"] || [status isEqualToString:@"ok"]) {
                                          dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                          dispatch_async(mainQueue, ^{
                                              //いいね消費
                                              NSInteger likePoint = [[PFUser currentUser] likePoints];
                                              likePoint --;
                                              [[PFUser currentUser] setLikePoints:likePoint];
                                              [[PFUser currentUser] saveToCacheAsCurrentUser];
                                              if (state == SortTyp_GoodFromPartner)
                                              {
                                                  state = SortTyp_CanTalk;
                                                  [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_talk"] forState:UIControlStateNormal];
                                              }
                                              else
                                              {
                                                  state = SortTyp_GoodFromMe;
                                                  [self.outletStatusButton setImage:[UIImage imageNamed:@"tag_liked"] forState:UIControlStateNormal];
                                              }
                                          });
                                      }
                                  } onFailure:^(NSError *error) {
                                      NSLog(@"@@@@@ connection Error: %@", error);
                                  }];
    }
}

@end
