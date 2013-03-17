//
//  PFPairSearchViewDeckController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchViewDeckController.h"
#import "PairSearchLeftViewController.h"
#import "PairSearchCenterViewController.h"
#import "PFMyPageTopPageViewController.h"
#import "PFMyProfilePageViewController.h"

@interface PFPairSearchViewDeckController ()

@end

@implementation PFPairSearchViewDeckController

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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    PairSearchLeftViewController *leftController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchLeftViewController"];
    PairSearchCenterViewController *centerController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchCenterViewController"];
    
    self = [super initWithCenterViewController:centerController
                            leftViewController:leftController];
    if (self) {
        // Add any extra init code here
    }
    return self;
}

/*
 * SlideMenuのボタンに合わせて画面を入れ替える
 */
- (void)changeCenterViewWithSlideMenuIndex:(NSInteger)index
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    // slide menu で選んだ画面のviewController
    UIViewController *viewController = nil;
    switch (index) {
        case PairSearch:
            if ([self.centerController isKindOfClass:[PairSearchCenterViewController class]]) {
                return;
            }
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchCenterViewController"];
            break;
        case MyPage:
            if ([self.centerController isKindOfClass:[PFMyPageTopPageViewController class]]) {
                return;
            }
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFMyPageTopPageViewController"];
            break;
        case Profile:
            if ([self.centerController isKindOfClass:[PFMyProfilePageViewController class]]) {
                return;
            }
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFMyProfilePageViewController"];
            break;
        case Shop:
            
            break;
        case Setting:
            
            break;
        case Notification:
            
            break;
        case Invite:
            
            break;
        case Help:
            
            break;
        case TermsOfUse:
            
            break;
        case ContactUs:
            
            break;
        default:
            
            break;
    }
    if (viewController) {
        __block PFPairSearchViewDeckController *selfInBlock = self;
        [self setLeftLedge:-40 completion:^(BOOL finished){
            selfInBlock.centerController = viewController;
            [selfInBlock closeLeftView];
            selfInBlock.leftLedge = 40;
        }];
    }
}

// フリックでスライドメニューがでないようにする。スクロールビューのため
- (void)panned:(UIPanGestureRecognizer *)panner
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
