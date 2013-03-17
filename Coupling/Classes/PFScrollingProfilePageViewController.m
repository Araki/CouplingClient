//
//  PFScrollingProfilePageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/21.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFScrollingProfilePageViewController.h"

@interface PFScrollingProfilePageViewController ()

@end

@implementation PFScrollingProfilePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionOpenFacebook:(id)sender {
    NSLog(@"openfacebook");
}

- (IBAction)actionViewingFacebookPage:(id)sender {
    NSLog(@"viewingFacebook");
}

- (IBAction)actionFavorite:(id)sender {
    NSLog(@"favorite");
}

// いいねボタンかトークボタンが押されたときのアクション
- (IBAction)actionLikeOrTalk:(UIButton *)sender {
    NSLog(@"likeOrTalk");
    // 一時的にトークページへのみ遷移する
    [self.delegate showTalkPage];
}

@end
