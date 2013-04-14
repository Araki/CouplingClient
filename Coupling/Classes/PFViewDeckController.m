//
//  PFViewDeckController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFViewDeckController.h"
#import "PFSlideMenuPageViewController.h"
#import "PFPairSearchTopPageViewController.h"
#import "PFMyPageTopPageViewController.h"
#import "PFMyProfilePageViewController.h"
#import "PFShopPageViewController.h"

@interface PFViewDeckController ()

@end

@implementation PFViewDeckController

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
    PFSlideMenuPageViewController *leftController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchLeftViewController"];
    PFPairSearchTopPageViewController *centerController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchCenterViewController"];
    
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
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchCenterViewController"];
            break;
        case MyPage:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFMyPageTopPageViewController"];
            break;
        case Profile:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFMyProfilePageViewController"];
            break;
        case Shop:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFShopPageViewController"];
            break;
        case Setting:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFSettingPageViewController"];
            break;
        case Announcement:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFAnnouncementPageViewController"];
            break;
        case Invite:
            
            break;
        case Help:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFHelpPageViewController"];
            break;
        case TermsOfUse:
            viewController = [storyboard instantiateViewControllerWithIdentifier:@"PFTermsOfUsePageViewController"];
            break;
        case ContactUs:
            
            break;
        default:
            
            break;
    }
    if (viewController) {
        __block PFViewDeckController *selfInBlock = self;
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
