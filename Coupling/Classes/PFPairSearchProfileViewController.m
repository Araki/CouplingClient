//
//  PFPairSearchProfileViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchProfileViewController.h"
#import "PFTalkPageViewController.h"

@interface PFPairSearchProfileViewController ()

@end

@implementation PFPairSearchProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // スクロールするプロフィールページ
        self.profileScrollPageViewcontroller = [[PFPairSearchProfileScrollViewController alloc] initWithNibName:@"PFPairSearchProfileScrollViewController" bundle:nil];
        
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // スクロールするプロフィールページのパラメータ設定
    float width = self.profileScrollPageViewcontroller.view.frame.size.width;
    float height = self.profileScrollPageViewcontroller.view.frame.size.height;
    [self addChildViewController:self.profileScrollPageViewcontroller];
    [self.outletProfileScrollView setContentSize:CGSizeMake(width, height)];
    [self.outletProfileScrollView addSubview:self.profileScrollPageViewcontroller.view];
    
	// テスト用
    UIImage *image = [UIImage imageNamed:@"test_imgres.jpeg"];
    [self.outletProfileImageView setImage:image];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOutletProfileImageView:nil];
    [self setOutletProfileScrollView:nil];
    [super viewDidUnload];
}
@end
