//
//  SignupStep4ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "SignupStep4ViewController.h"
#import "PFTutorialViewController.h"

@interface SignupStep4ViewController ()

@end

@implementation SignupStep4ViewController

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
    self.view.backgroundColor = kPFCommonBackGroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)done:(id)sender
{
    PFTutorialViewController *tutorial = [[PFTutorialViewController alloc] initWithNibName:@"PFTutorialViewController" bundle:nil];
    [self.navigationController pushViewController:tutorial animated:YES];
}

@end
