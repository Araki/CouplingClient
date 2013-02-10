//
//  SignupStep3ViewController.h
//  Coupling
//
//  Created by tsuchimoto on 13/02/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignupStep3ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)goNextView:(id)sender;

@end
