//
//  SignupStep3ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/02/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "SignupStep3ViewController.h"

@interface SignupStep3ViewController ()

@end

@implementation SignupStep3ViewController

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
    self.tableView.backgroundView = nil;
    self.tableView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:245.0/250.0 blue:230.0/250.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDelegate

//行に表示するデータの生成
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSInteger row = indexPath.row;
    cell.textLabel.text = [self profileItemString:row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)profileItemString:(NSInteger)row
{
    switch (row) {
        case 0:
            return @"職業";
        case 1:
            return @"年収";
        case 2:
            return @"休日";
        case 3:
            return @"趣味・活動";
        case 4:
            return @"性格";
        case 5:
            return @"同居人";
        case 6:
            return @"タバコ";
        case 7:
            return @"お酒";
        default:
            return nil;
            break;
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

#pragma mark -

- (IBAction)goNextView:(id)sender
{
    SignupStep3ViewController *signupViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SignupStep3ViewController"];
    [self.navigationController pushViewController:signupViewController animated:YES];
    
}


@end
