//
//  PFMyPageTopTableViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyPageTopPageViewController.h"
#import "PFMyPageTopTableCell.h"
#import "IIViewDeckController.h"


@interface PFMyPageTopPageViewController ()

@end

@implementation PFMyPageTopPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.outletTableViewController.backgroundColor = kPFBackGroundColor;
    
    UIImage *image = [UIImage imageNamed:@"bg_header.png"];
    [self.outletNavigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    return 80;
}

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
    static NSString *CellIdentifier = @"PFMyPageTopTableCell";
    
    PFMyPageTopTableCell* cell = (PFMyPageTopTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        UINib* nib = [UINib nibWithNibName:CellIdentifier bundle:nil];
        NSArray* array = [nib instantiateWithOwner:nil options:nil];
        cell = [array objectAtIndex:0];
        cell.backgroundColor = kPFBackGroundColor;
        cell.outletUserPictureImage.image = [UIImage imageNamed:@"test_imgres_1.jpeg"];
    }
    cell.outletUserAgeLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
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

- (void)viewDidUnload {
    [self setOutletTableViewController:nil];
    [self setOutletNavigationBar:nil];
    [super viewDidUnload];
}

- (IBAction)actionStatusSortBarButton:(id)sender
{
    NSLog(@"senderTag = %d", ((UIBarButtonItem *)sender).tag);
    
}
@end
