//
//  PFTopViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/06/02.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTopViewController.h"
#import "PFViewDeckController.h"
#import "PFNotificationsName.h"

@interface PFTopViewController ()

@end

@implementation PFTopViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleSessionVerifySuccess:)
												 name:kPFNotificationSessionVerifySuccess
                                               object:nil];
}

#pragma mark -

- (void)handleSessionVerifySuccess:(NSNotification *)notification
{
   dispatch_queue_t mainQueue = dispatch_get_main_queue();
   dispatch_async(mainQueue, ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        PFViewDeckController *view = [storyboard instantiateViewControllerWithIdentifier:@"PFViewDeckController"];
        [self.navigationController pushViewController:view animated:YES];
   });
}

@end
