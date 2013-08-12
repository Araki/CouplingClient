//
//  PFProfileTableHeaderView.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfileTableHeaderView.h"
#import "PSImageDownloader.h"
#import "PFHTTPConnector.h"

@implementation PFProfileTableHeaderView
{
    //表示データ
    NSDictionary *userData;
    //プロフィール画像
    UIImageView *profileImageView;
    //最終ログインボタン
    UILabel *lastLoginLabel;
    //写真ボタン
    UIButton *pictureButton;
    //名前
    UILabel *nameLabel;
    //年齢,住所
    UILabel *ageLabel;
    //お気に入りボタン
    UIButton *favoriteButton;
    //いいねボタン
    UIButton *likeButton;
    //ユーザID
    NSString *targetID;
    //
    NSArray *favcommandary;
    NSArray *likecommandary;
    //お気に入りステータス 0:未 1:済
    int fav_status;
    //いいね！ステータス 0:未 1:済 2:フレンド
    int like_status;
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

- (void)initView
{
    //プロフィール画像
    profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 320)];
    [self addSubview:profileImageView];
    //最終ログインボタン
    lastLoginLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 260, 90, 25)];
    [lastLoginLabel setBackgroundColor:[UIColor clearColor]];
    [lastLoginLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [lastLoginLabel setTextColor:[UIColor blackColor]];
    [lastLoginLabel setText:@"２４時間以内"];
    [self addSubview:lastLoginLabel];
    //写真ボタン
    pictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pictureButton setImage:[UIImage imageNamed:@"button_pictures_of_profile.png"] forState:UIControlStateNormal];
    [pictureButton setFrame:CGRectMake(5, 290, 47, 20)];
    [pictureButton addTarget:self action:@selector(showPicture) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pictureButton];
    //名前
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 325, 250, 20)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];
    [nameLabel setText:@"大橋 由美"];
    [self addSubview:nameLabel];
    //年齢
    ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 345, 250, 20)];
    [ageLabel setBackgroundColor:[UIColor clearColor]];
    [ageLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
    [ageLabel setText:@"22歳 新宿区"];
    [self addSubview:ageLabel];
    //お気に入りボタン
    favoriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [favoriteButton setFrame:CGRectMake(20, 370, 100, 30)];
    [favoriteButton addTarget:self action:@selector(addFavorite) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:favoriteButton];
    //イイネボタン
    likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [likeButton setFrame:CGRectMake(130, 365, 170, 35)];
    [likeButton addTarget:self action:@selector(like) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:likeButton];
}

- (void)initViewWithUser:(NSDictionary *)user
{
    userData = [NSDictionary dictionaryWithDictionary:user];
    targetID = [userData objectForKey:@"id"];
    
    [self changeFavoriteState:0];
    [self changeLikeState:0];
    
    favcommandary = [NSArray arrayWithObjects:kPFCommendFavoritesCreate,kPFCommendFavoritesDelete ,nil];
    likecommandary = [NSArray arrayWithObjects:kPFCommendLikesCreate,kPFCommendLikesDelete ,nil];
    
    //プロフィール画像
    //NSString *imageUrl = [[[user objectForKey:@"images"] objectAtIndex:0] objectForKey:@"url"];
    //TODO: 画像のURLが死んでいるので今は仮の画像
    //仮URL: http://huhennews.net/images/pro/m3391-4223-12040109-2.jpg
    NSString *imageUrl = @"http://huhennews.net/images/pro/m3391-4223-12040109-2.jpg";
    [[PSImageDownloader sharedInstance] getImage:imageUrl
                                      onComplete:^(UIImage *image, NSString *url, NSError *error) {
                                          if (error == nil)
                                          {
                                              if ([imageUrl isEqualToString:url])
                                              {
                                                  [profileImageView setImage:image];
                                              }
                                          }
                                      }];
    //名前
    [nameLabel setText:[userData objectForKey:@"nickname"]];
    
    //写真枚数
    NSString *picture = [NSString stringWithFormat:@"写真%d枚",[[user objectForKey:@"images"] count]];
    [pictureButton setTitle:picture forState:UIControlStateNormal];
    
    [self checkUser];
}


- (void)checkUser
{
    PFUser *user = [PFUser currentUser];
    //フレンド判定
    [self checkFriend:user];
    //お気に入り判定
    [self checkFavorite:user];
}

- (void)checkFriend:(PFUser *)user
{    
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, targetID,nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendFriendsShow params:params onSuccess:^(PFHTTPResponse *response) {
        NSString *status = [[response jsonDictionary] valueForKey:@"status"];
        
        if([status isEqual:@"OK"]) {
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                //フレンド済み
                [self changeFavoriteState:2];
            });
        } else {
            [self checkLike:user];
        }
        
    } onFailure:^(NSError *error) {
        //NSLog(@"@@@@@ connection Error: %@", error);
    }];

}

- (void)checkFavorite:(PFUser *)user
{
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, targetID,nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendFavoritesShow params:params onSuccess:^(PFHTTPResponse *response) {
        NSString *status = [[response jsonDictionary] valueForKey:@"status"];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if([status isEqual:@"OK"]) {
                //お気に入り済み
                [self changeFavoriteState:1];
            } else {
                [self changeFavoriteState:0];
            }
        });
        
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

- (void)checkLike:(PFUser *)user
{
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, targetID,nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id",nil]];
    
    [PFHTTPConnector requestWithCommand:kPFCommendLikesShow params:params onSuccess:^(PFHTTPResponse *response) {
        NSString *status = [[response jsonDictionary] valueForKey:@"status"];
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(mainQueue, ^{
            if([status isEqual:@"OK"]) {
                //いいね済み
                [self changeLikeState:1];
            } else {
                [self changeLikeState:0];
            }
        });
        
    } onFailure:^(NSError *error) {
        NSLog(@"@@@@@ connection Error: %@", error);
    }];
}

#pragma mark - Button Actions
- (void)addFavorite
{
    PFUser *user = [PFUser currentUser];
    NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, targetID,nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
    
    [PFHTTPConnector postWithCommand:[favcommandary objectAtIndex:fav_status]
                              params:params onSuccess:^(PFHTTPResponse *response) {
                                  NSString *status = [[response jsonDictionary] valueForKey:@"status"];
                                  if([status isEqual:@"OK"]) {
                                      dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                      dispatch_async(mainQueue, ^{
                                          [self changeFavoriteState:(fav_status == 1 ? 0 : 1)];
                                      });
                                  }
                              } onFailure:^(NSError *error) {
                                  NSLog(@"@@@@@ connection Error: %@", error);
                              }];
}

- (void)like
{
    if(like_status == 2)
    {
        [self.headerViewDelegate showTalkPage];
    }
    else
    {
        PFUser *user = [PFUser currentUser];
        NSMutableDictionary *params =  [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObjects:user.sessionId, targetID,nil] forKeys:[NSArray arrayWithObjects:@"session_id", @"target_id", nil]];
        
        [PFHTTPConnector postWithCommand:[likecommandary objectAtIndex:like_status]
                                  params:params onSuccess:^(PFHTTPResponse *response) {
                                      NSString *status = [[response jsonDictionary] valueForKey:@"status"];
                                      if([status isEqual:@"OK"]) {
                                          dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                          dispatch_async(mainQueue, ^{
                                              [self changeLikeState:(like_status == 1 ? 0 : 1)];
                                          });
                                      }
                                  } onFailure:^(NSError *error) {
                                      NSLog(@"@@@@@ connection Error: %@", error);
                                  }];
    }}

- (void)showPicture
{
    [self.headerViewDelegate showPictures];
}

#pragma mark - Button State Control
- (void)changeFavoriteState:(int)state
{
    fav_status = state;
    if (state == 0)
    {
        [favoriteButton setImage:[UIImage imageNamed:@"button_favorite.png"] forState:UIControlStateNormal];
    }
    else
    {
        [favoriteButton setImage:[UIImage imageNamed:@"button_favorited.png"] forState:UIControlStateNormal];
    }
}

- (void)changeLikeState:(int)state
{
    like_status = state;
    if (state == 0)
    {
        [likeButton setImage:[UIImage imageNamed:@"button_like.png"] forState:UIControlStateNormal];
    }
    else if (state == 1)
    {
        [likeButton setImage:[UIImage imageNamed:@"button_liked.png"] forState:UIControlStateNormal];
    }
    else if (state == 2)
    {
        [likeButton setImage:[UIImage imageNamed:@"button_talk.png"] forState:UIControlStateNormal];
    }
}

@end
