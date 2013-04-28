//
//  PFAbstractPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/17.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFAbstractPageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar; // スライドメニュー用のボタンをセットしている場合のNavigationBar
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)actionSlideMenuBarButton:(id)sender;


@end
