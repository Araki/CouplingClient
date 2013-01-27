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
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    // Configure the cell...
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CellIdentifier];
        
        PFSlideMenuButton *aButton = [[PFSlideMenuButton alloc] initWithFrame:CGRectMake(0, 0, 320, 36)];
        [aButton setImage:[self slideMenuImageWithRow:indexPath.row] forState:UIControlStateNormal];
        aButton.tag = 10000;
        [aButton addTarget:aButton
                    action:@selector(buttonDidTouchDown:)
          forControlEvents:UIControlEventTouchDown];
        [cell addSubview:aButton];
    }
    
    PFSlideMenuButton *theButton = (PFSlideMenuButton *)[cell viewWithTag:10000];
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

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

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

@end
