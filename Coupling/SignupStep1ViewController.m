//
//  SignupStep1ViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "SignupStep1ViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "FBManager.h"
#import "PFHTTPConnector.h"
#import "SignupStep2ViewController.h"

#import "PFViewDeckController.h"

#import <Security/Security.h>

@interface SignupStep1ViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation SignupStep1ViewController

@synthesize detailDescriptionLabel;

NSString *const FBSessionStateChangedNotification = @"com.example.Login:FBSessionStateChangedNotification";


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
                                                 name:FBSessionStateChangedNotification
                                               object:nil];
    [self configureView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:FBSessionStateChangedNotification object:nil];
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
    [[FBManager sharedObject] openSessionWithAllowLoginUI:YES];
}

#pragma mark - received notification

- (void)sessionStateChanged:(NSNotification *)notification
{
    FBSession *fbSession = (FBSession *)notification.object;
    
    if (fbSession.state == FBSessionStateOpen) {
        NSString *uuid = [self readUUID];
        if (uuid == nil) {
            uuid = [self createUUID];
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
                PFViewDeckController *view = [storyboard instantiateViewControllerWithIdentifier:@"PFViewDeckController"];
                [self.navigationController pushViewController:view animated:YES];
            });
            
        } onFailure:^(NSError *error) {
            NSLog(@"@@@@@ connection Error: %@", error);
        }];
    }
}

- (NSString *)readUUID
{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    [query setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    [query setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFArrayRef attributesRef = nil;
    OSStatus result = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&attributesRef);
    NSArray *attributes = (__bridge_transfer NSArray *)attributesRef;
    NSData *data = [attributes objectAtIndex:0];
    
    if (result == noErr) {
        return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    }
    return nil;
}

- (NSString *)createUUID
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    [attribute setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [attribute setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
    [attribute setObject:[uuid dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
    OSStatus error = SecItemAdd((__bridge CFDictionaryRef)attribute, NULL);
    if (error == noErr) {
        NSLog(@"SecItemAdd: noErr");
    } else {
        NSLog(@"SecItemAdd: error(%ld)", error);
    }
    return uuid;
}


@end
