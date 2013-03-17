//
//  PFSlideMenuPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchViewDeckController.h"
#import "PFSlideMenuPageViewController.h"

@interface PFSlideMenuPageViewController ()

@property (nonatomic, strong) UIImage *headerImage;

@end

@implementation PFSlideMenuPageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    // tableViewのヘッダー画像
    self.headerImage = [UIImage imageNamed:@"bg_header.png"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerImage.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //tableViewのヘッダーを設定
    UIImageView * headerImageView = [[UIImageView alloc] initWithImage:self.headerImage];
    [headerImageView setFrame:CGRectMake(0, 0, self.headerImage.size.width, self.headerImage.size.height)];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerImageView.frame.size.width, headerImageView.frame.size.height)];
    [headerView addSubview:headerImageView];
    return headerView;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // スライドメニューのボタンの数
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPFSlideMenuHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        
        PFSlideMenuButton *aButton = [[PFSlideMenuButton alloc] initWithFrame:CGRectMake(0, 0, 320, kPFSlideMenuHeight)];
        aButton.delegate = self;
        [aButton setImage:[self slideMenuImageWithRow:indexPath.row] forState:UIControlStateNormal];
        aButton.tag = kPFSlideMenuButtonTag;
        
        [aButton addTarget:aButton
                    action:@selector(buttonDidTouchDown:)
          forControlEvents:UIControlEventTouchDown];
        
        [cell addSubview:aButton];
    }
    
    PFSlideMenuButton *theButton = (PFSlideMenuButton *)[cell viewWithTag:kPFSlideMenuButtonTag];
    if (theButton) {
        theButton.section = [indexPath section];
        theButton.row = [indexPath row];
    }
    
    return cell;
}

/*
 * CenterViewControllerのを入れ替える
 */
- (void)changeParentCenterViewWithSlideMenuIndex:(NSInteger)index
{
    PFPairSearchViewDeckController *parentController = (PFPairSearchViewDeckController *)self.parentViewController;
    [parentController changeCenterViewWithSlideMenuIndex:index];
}

- (UIImage *)slideMenuImageWithRow:(NSInteger)row
{
    UIImage *image = nil;
    switch (row) {
        case PairSearch:
            image = [UIImage imageNamed:@"button_partner_search.png"];
            break;
        case MyPage:
            image = [UIImage imageNamed:@"button_my_page.png"];
            break;
        case Profile:
            image = [UIImage imageNamed:@"button_profile.png"];
            break;
        case Shop:
            image = [UIImage imageNamed:@"button_shop.png"];
            break;
        case Setting:
            image = [UIImage imageNamed:@"button_settings.png"];
            break;
        case Notification:
            image = [UIImage imageNamed:@"button_info_from_pairful.png"];
            break;
        case Invite:
            image = [UIImage imageNamed:@"button_invite_friends.png"];
            break;
        case Help:
            image = [UIImage imageNamed:@"button_help.png"];
            break;
        case TermsOfUse:
            image = [UIImage imageNamed:@"button_tos.png"];
            break;
        case ContactUs:
            image = [UIImage imageNamed:@"button_inquiry.png"];
            break;
        default:
            
            break;
    }
    
    return image;
}


#pragma mark- SlideMenuButtonDelegate
- (void)selectedSlideMenuWithIndex:(NSInteger)index
{
    [self changeParentCenterViewWithSlideMenuIndex:index];
}


@end
