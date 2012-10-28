//
//  DetailViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "DetailViewController.h"
#import "AppDelegate.h"
#import "SBJson.h"
#import "FBManager.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailDescriptionLabel;

NSString *const FBSessionStateChangedNotification = @"com.example.Login:FBSessionStateChangedNotification";
NSString *const APIRegister = @"https://api.pairful.net/api/v1/session/register?access_token=%@";


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
    // Update the user interface for the detail item.

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
    NSLog(@"signup");
    [[FBManager sharedObject] openSessionWithAllowLoginUI:YES];
}

- (IBAction)push:(id)sender {
    NSLog(@"push");
    
    NSMutableData *data = [NSMutableData data];
    [data appendData:[@"device=" dataUsingEncoding:NSUTF8StringEncoding]];
    [data appendData:[[FBManager sharedObject] deviceToken]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"ホスト名"]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

#pragma mark -

- (void)sessionStateChanged:(NSNotification *)notification
{
    FBSession *session = (FBSession *)notification.object;
    NSLog(@"@@@@@ state: %d / accessToken: %@", session.state, session.accessToken);
    
    if (session.state == FBSessionStateOpen) {
        NSString *urlString = [NSString stringWithFormat:APIRegister, session.accessToken];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
        if (connection) {
            NSLog(@"@@@@ connection Success");
        } else {
            NSLog(@"@@@@ connection Error");
        }
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"@@@@ didReceiveData");
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"didReceiveResponse");
    [self.responseData setLength:0];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connectionDidFinishLoading");
    NSString *responseString = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
    
    NSLog(@"%@", responseString);
    
    NSDictionary *jsonObject = [responseString JSONValue];
    
    NSLog(@"%@", jsonObject);
    
    
}

@end
