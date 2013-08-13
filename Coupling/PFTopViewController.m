//
//  PFTopViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/06/02.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTopViewController.h"
#import "PFViewDeckController.h"
#import "PFTutorialStep1Controller.h"
#import "TitleViewController.h"
#import "PFNotificationsName.h"

#import "PFHTTPConnector.h"

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
    
    NSString *sessionId = [PFUser currentUser].sessionId;
    if (sessionId == nil) {
        [self pushTutorialViewController];
        return;
        
    }
    
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleSessionVerifySuccess:)
												 name:kPFNotificationSessionVerifySuccess
                                               object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(handleSessionVerifyFailure:)
												 name:kPFNotificationSessionVerifyFailure
                                               object:nil];
    
    [PFHTTPConnector requestWithCommand:kPFCommandSessionsVerify params:nil onSuccess:^(PFHTTPResponse *response) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationSessionVerifySuccess object:self userInfo:[response jsonDictionary]];
        NSLog(@"@@@@@ verify session: %@", [response jsonDictionary]);
    } onFailure:^(NSError *error) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationSessionVerifyFailure object:self userInfo:nil];
        NSLog(@"@@@@@ verify Error: %@", error);
    }];

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

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
	[[NSNotificationCenter defaultCenter] removeObserver:kPFNotificationSessionVerifySuccess];
	[[NSNotificationCenter defaultCenter] removeObserver:kPFNotificationSessionVerifyFailure];
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

- (void)handleSessionVerifyFailure:(NSNotification *)notification
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    dispatch_async(mainQueue, ^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        TitleViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"TitleViewController"];
        [self.navigationController pushViewController:view animated:YES];
    });
}

- (void)pushTutorialViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    PFTutorialStep1Controller *view = [storyboard instantiateViewControllerWithIdentifier:@"PFTutorialStep1Controller"];
    [self.navigationController pushViewController:view animated:YES];
}

@end
