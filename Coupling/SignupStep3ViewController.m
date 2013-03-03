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
    NSArray *items = [NSArray arrayWithObjects:@"職業", @"年収", @"休日", @"趣味・活動", @"性格", @"同居人", @"タバコ", @"お酒", nil];
    return (NSString *)[items objectAtIndex:row];
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
