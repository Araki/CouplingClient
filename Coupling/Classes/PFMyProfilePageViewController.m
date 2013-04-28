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
    self.view.backgroundColor = kPFCommonBackGroundColor;
    
    
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
    return kPFProfileTitleListNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    UILabel *profileTitleLabel = cell.textLabel;
    
    NSString *conditionTitle = [[PFUtil profileTitles] objectAtIndex:indexPath.row];
    [profileTitleLabel setText:conditionTitle];
    [profileTitleLabel setFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
    [profileTitleLabel setFrame:CGRectMake(0, 0, 200, 30)];
    [profileTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [profileTitleLabel setBackgroundColor:kPFBackGroundColor];
    
    cell.detailTextLabel.text = [self profileStatusForRowAtIndexPath:indexPath];
    return cell;
}

- (NSString *)profileStatusForRowAtIndexPath:(NSIndexPath *)indexPath
{
    kPFProfileTitleList row = (kPFProfileTitleList)indexPath.row;
//    PFUser *user = [PFUser currentUser];
    NSString *status = nil;
    switch (row) {
        case Profile_NickName:
            status = @"ニックネーム";
            break;
        case Profile_Birthdate:
            status = @"1987/12/25";
            break;
        case Profile_Address:

            break;
        case Profile_Introduction:

            break;
        case Profile_HomeTown:

            break;
        case Profile_BloodType:

            break;
        case Profile_Height:

            break;
        case Profile_Body:

            break;
        case Profile_Education:

            break;
        case Profile_Occupation:
            
            break;
        case Profile_Income:
            
            break;
        case Profile_Holiday:
            
            break;
        case Profile_Hobbies:
            
            break;
        case Profile_Personality:
            
            break;
        case Profile_Roommate:
            
            break;
        case Profile_Tabaco:
            
            break;
        case Profile_Alcohol:
            
            break;            
        default:
            status = [NSArray arrayWithObject:nil];
            break;
    }
    return status;
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
