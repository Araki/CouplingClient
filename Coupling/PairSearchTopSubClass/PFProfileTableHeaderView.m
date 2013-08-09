//
//  PFProfileTableHeaderView.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfileTableHeaderView.h"
#import "PSImageDownloader.h"

@implementation PFProfileTableHeaderView
{
    UIImageView *profileImageView;
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
    profileImageView = [[UIImageView alloc] initWithFrame:self.frame];
    [self addSubview:profileImageView];
}

- (void)initViewWithUser:(NSDictionary *)user
{
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
    
    
    //TODO: いいねとかおく
    
    
}


@end
