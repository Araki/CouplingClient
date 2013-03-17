//
//  PFMyProfilePageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/06.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFAbstractPageViewController.h"

@interface PFMyProfilePageViewController : PFAbstractPageViewController<UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar;
@property (weak, nonatomic) IBOutlet UITableView *outletTableView;
@property (weak, nonatomic) IBOutlet UIImageView *outletUserProfileImageView;

- (IBAction)actionConfirmProfileButton:(id)sender;


@end
