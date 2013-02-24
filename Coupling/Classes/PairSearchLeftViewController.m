//
//  PairSearchLeftViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PairSearchLeftViewController.h"
#import "PFSlideMenuButton.h"

@interface PairSearchLeftViewController ()

@property (nonatomic, retain) UIImage *headerImage;

@end

@implementation PairSearchLeftViewController

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
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
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
    // Return the number of rows in the section.
    return 9;
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
//    cell.textLabel.text = [NSString stringWithFormat:@"%d", [indexPath row]];
    
    return cell;
}

- (UIImage *)slideMenuImageWithRow:(NSInteger)row
{
    UIImage *image = nil;
    switch (row) {
        case 0:
            image = [UIImage imageNamed:@"button_partner_search.png"];
            break;
        case 1:
            image = [UIImage imageNamed:@"button_my_page.png"];
            break;
        case 2:
            image = [UIImage imageNamed:@"button_profile.png"];
            break;
        case 3:
            image = [UIImage imageNamed:@"button_shop.png"];
            break;
        case 4:
            image = [UIImage imageNamed:@"button_settings.png"];
            break;
        case 5:
            image = [UIImage imageNamed:@"button_info_from_pairful.png"];
            break;
        case 6:
            image = [UIImage imageNamed:@"button_invite_friends.png"];
            break;
        case 7:
            image = [UIImage imageNamed:@"button_tos.png"];
            break;
        case 8:
            image = [UIImage imageNamed:@"button_inquiry.png"];
            break;
        default:
            
            break;
    }
    
    return image;
}

@end
