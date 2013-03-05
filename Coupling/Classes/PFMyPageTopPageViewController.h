//
//  PFMyPageTopTableViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFMyPageTopPageViewController : UIViewController <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *outletTableViewController;
@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar;
@property (strong, nonatomic) NSArray *cellDataArray; // user modelを入れる配列

- (IBAction)actionSlideMenuBarButton:(id)sender;
- (IBAction)actionStatusSortBarButton:(id)sender;

@end
