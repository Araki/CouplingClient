//
//  PFAbstractPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/17.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFAbstractPageViewController.h"
#import "IIViewDeckController.h"

@interface PFAbstractPageViewController ()

@end

@implementation PFAbstractPageViewController

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
    UIImage *image = [UIImage imageNamed:@"bg_header.png"];
    
    if (self.outletNavigationBar != nil)
    {
        // 背景画像を設定する
        [self.outletNavigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    // デフォルトのNavigationBarを使う場合の戻るボタンを設定する。(backBarButtonItemは使わない)
    else
    {
        UIButton *backButton = [PFUtil backButton];
        [backButton addTarget:self action:@selector(popViewControllerAsNavigationController) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        self.navigationItem.leftBarButtonItem = backBarButton;
        // 背景画像を設定する
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        // backBarButtonItemは使わない
        [self.navigationItem setHidesBackButton:YES];
    }
}

- (void)popViewControllerAsNavigationController
{
    if (!self.navigationController.navigationBar.hidden) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSlideMenuBarButton:(id)sender
{
    [self.viewDeckController toggleLeftView];
}

@end
