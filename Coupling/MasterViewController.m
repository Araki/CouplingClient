//
//  MasterViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "SearchResultViewController.h"
#import "PurchaseViewController.h"
#import "PFPairSearchViewDeckController.h"

@interface MasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarImage];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark -

- (void)setNavigationBarImage
{
    UIImage *image = [UIImage imageNamed:@"bg_header.png"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _objects.count;
    return 4;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"ログイン";
                break;
            case 1:
                cell.textLabel.text = @"検索";
                break;
            case 2:
                cell.textLabel.text = @"会員登録";
                break;
            case 3:
                cell.textLabel.text = @"相手検索";
                break;
            default:
                break;
        }
    }


//    NSDate *object = [_objects objectAtIndex:indexPath.row];
//    cell.textLabel.text = [object description];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self pushViewControllerAtIndex:indexPath.row];
    } else {
//        self.detailViewController.detailItem = object;
    }
}

#pragma mark -


- (void)pushViewControllerAtIndex:(NSInteger)index
{
    switch (index) {
        case 0: {
            NSDate *object = [_objects objectAtIndex:index];
            if (!self.detailViewController) {
                self.detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
            }
            self.detailViewController.detailItem = object;
            [self.navigationController pushViewController:self.detailViewController animated:YES];
            break;
        }
        case 1: {
            if (!self.searchResultViewController) {
                self.searchResultViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultViewController"];
            }
            [self.navigationController pushViewController:self.searchResultViewController animated:YES];
            break;
            
        }
        case 2: {
            if (!self.purchaseViewController) {
                self.purchaseViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PurchaseViewController"];
            }
            [self.navigationController pushViewController:self.purchaseViewController animated:YES];
            break;
        }
        case 3: {
            if (!self.pairSearchViewDeckController) {
                self.pairSearchViewDeckController = [self.storyboard instantiateViewControllerWithIdentifier:@"PFPairSearchViewDeckController"];
            }
            [self.navigationController pushViewController:self.pairSearchViewDeckController animated:YES];
            break;
        }
        default:
            break;
    }
}

@end
