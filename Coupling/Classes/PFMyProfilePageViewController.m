//
//  PFMyProfilePageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/06.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyProfilePageViewController.h"
#import "IIViewDeckController.h"

@interface PFMyProfilePageViewController ()

@end

@implementation PFMyProfilePageViewController

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
	// Do any additional setup after loading the view.
    self.outletTableView.backgroundColor = kPFBackGroundColor;
    UIImage *image = [UIImage imageNamed:@"bg_header.png"];
    [self.outletNavigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
        
    // test
    self.outletUserProfileImageView.image = [UIImage imageNamed:@"test_imgres_1.jpeg"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    return _cellDataArray.count;
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    PFUser *user = [PFUser currentUser];
    UILabel *conditionTitleLabel = cell.textLabel;
    
    NSString *conditionTitle = [[PFUtil searchConditionTitles] objectAtIndex:indexPath.row];
    [conditionTitleLabel setText:conditionTitle];
    [conditionTitleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [conditionTitleLabel setFrame:CGRectMake(0, 0, 200, 30)];
    [conditionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [conditionTitleLabel setBackgroundColor:kPFBackGroundColor];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

- (IBAction)actionConfirmProfileButton:(id)sender
{
    
}
- (void)viewDidUnload {
    [self setOutletTableView:nil];
    [self setOutletUserProfileImageView:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}
@end
