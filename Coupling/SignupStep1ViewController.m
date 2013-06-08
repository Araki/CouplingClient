//
//  SignupStep1ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "SignupStep1ViewController.h"
#import "AppDelegate.h"
#import "PFNotificationsName.h"
#import "SBJson.h"
#import "FBManager.h"
#import "PFHTTPConnector.h"
#import "PFMiscUtil.h"
#import "SignupStep2ViewController.h"

#import "PFViewDeckController.h"
#import "PFIndicatorView.h"

#import <Security/Security.h>

@interface SignupStep1ViewController ()

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

- (void)configureView;
- (void)showIndicator;
- (void)hideIndicator;

@end

@implementation SignupStep1ViewController

@synthesize detailDescriptionLabel, indicatorView;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }
}

- (void)configureView
{
    self.view.backgroundColor = kPFCommonBackGroundColor;
    self.navigationController.navigationBarHidden = NO;

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.responseData = [NSMutableData dataWithCapacity:0];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sessionStateChanged:)
                                                 name:kPFNotificationFBSessionStateChanged
                                               object:nil];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kPFNotificationFBSessionStateChanged object:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

#pragma mark - IBAction

- (IBAction)signup:(id)sender {
    [self showIndicator];
    [[FBManager sharedObject] openSessionWithAllowLoginUI:YES];
}

#pragma mark - received notification

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
            [PFUser currentUser].sessionId = session;
            [[PFUser currentUser] saveToCacheAsCurrentUser];
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
                SignupStep2ViewController *view = [storyboard instantiateViewControllerWithIdentifier:@"SignupStep2ViewController"];
                [self.navigationController pushViewController:view animated:YES];
                [self hideIndicator];
            });
            
        } onFailure:^(NSError *error) {
            NSLog(@"@@@@@ connection Error: %@", error);
        }];
    }
}

@end
