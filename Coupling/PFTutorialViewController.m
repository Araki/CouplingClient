//
//  PFTutorialViewController.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/09/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTutorialViewController.h"
#import "PFViewDeckController.h"

@interface PFTutorialViewController ()

@end

@implementation PFTutorialViewController

#define IMAGE_COUNT 3

#pragma mark - Init
- (void)initView
{
    //ScrollView
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setDelegate:self];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setBounces:NO];
    //TODO: ここで4inchと3.5インチの画像を振り分けて下さい
    if ([PFUtil is4inch])
    {
         [self.scrollView initImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"test_imgres_2.jpeg"], [UIImage imageNamed:@"test_imgres_2.jpeg"], [UIImage imageNamed:@"test_imgres_2.jpeg"], nil]];
    }
    else
    {
        [self.scrollView initImages:[NSArray arrayWithObjects:[UIImage imageNamed:@"test_imgres_2.jpeg"], [UIImage imageNamed:@"test_imgres_2.jpeg"], [UIImage imageNamed:@"test_imgres_2.jpeg"], nil]];
    }
    //pageControl
    [self.pageControl setNumberOfPages:IMAGE_COUNT];
    //NavigationBar
    [self.navigationController setNavigationBarHidden:YES];
}

#pragma mark - View Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - IBActions
- (IBAction)done:(id)sender
{
    if (self.scrollView.contentOffset.x == 320 * IMAGE_COUNT - 320)
    {
        //チュートリアル終了
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        PFViewDeckController *view = [storyboard instantiateViewControllerWithIdentifier:@"PFViewDeckController"];
        [self.navigationController pushViewController:view animated:YES];
    }
    else
    {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + 320, 0) animated:YES];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int currentPage = (self.scrollView.contentOffset.x / 320);
    [self.pageControl setCurrentPage:currentPage];
    
    if (currentPage == IMAGE_COUNT - 1)
    {
        [self.tutorialButton setTitle:@"早速やってみる" forState:UIControlStateNormal];
    }
}

@end
