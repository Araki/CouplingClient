//
//  TitleViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "TitleViewController.h"
#import "PFNotificationsName.h"
#import "FBManager.h"
#import "PFHTTPConnector.h"
#import "PFMiscUtil.h"
#import "PFViewDeckController.h"
#import "SignupStep1ViewController.h"
#import "PFIndicatorView.h"

@interface TitleViewController ()

- (void)showIndicator;
- (void)hideIndicator;

@end

@implementation TitleViewController

@synthesize indicatorView;

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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged:)
                                                 name:kPFNotificationFBSessionStateChanged
                                               object:nil];
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

#pragma mark original method

- (IBAction)loginFacebook:(id)sender
{
    [self showIndicator];
    [[FBManager sharedObject] openSessionWithAllowLoginUI:YES];
}

- (IBAction)showSignupView:(id)sender
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPFNotificationFBSessionStateChanged object:nil];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    SignupStep1ViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"SignupStep1ViewController"];
    [self.navigationController pushViewController:view animated:YES];
}

- (void)showIndicator
{
    self.indicatorView = [PFIndicatorView indicatorWithNavigationController:self.navigationController];
}

- (void)hideIndicator
{
    [self.indicatorView removeFromSuperview];
}

- (void)sessionStateChanged:(NSNotification *)notification
{
    FBSession *fbSession = (FBSession *)notification.object;
    
    if (fbSession.state == FBSessionStateOpen) {
        NSString *uuid = [PFMiscUtil readUUID];
        if (uuid == nil) {
            uuid = [PFMiscUtil createUUID];
        }
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:
                                fbSession.accessToken, @"access_token", uuid, @"device_token", nil];
        [PFHTTPConnector postWithCommand:kPFCommandSessionsCreate params:params onSuccess:^(PFHTTPResponse *response) {
            NSLog(@"@@@@@ postWithCommand onSuccess");
            NSString *session = [[response jsonDictionary] valueForKey:@"session"];
            NSString *likePoint = [[[response jsonDictionary] valueForKey:@"user"] valueForKey:@"like_point"];
            NSString *point = [[[response jsonDictionary] valueForKey:@"user"] valueForKey:@"point"];
            [PFUser currentUser].likePoints = [likePoint integerValue];
            [PFUser currentUser].points     = [point integerValue];
            [PFUser currentUser].sessionId = session;
            [[PFUser currentUser] saveToCacheAsCurrentUser];
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                PFViewDeckController *view = [storyboard instantiateViewControllerWithIdentifier:@"PFViewDeckController"];
                [self.navigationController pushViewController:view animated:YES];
                [self hideIndicator];
            });
            
        } onFailure:^(NSError *error) {
            NSLog(@"@@@@@ connection Error: %@", error);
        }];
    }
}

@end
