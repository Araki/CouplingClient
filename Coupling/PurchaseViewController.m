//
//  PurchaseViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/09/17.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <StoreKit/StoreKit.h>
#import "PurchaseViewController.h"

@interface PurchaseViewController ()

@end

@implementation PurchaseViewController

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
    [self requestProductData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (void)requestProductData
{
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:@"paid_membership_standard"]];
    request.delegate = self;
    [request start];
}

- (void)buy:(id)sender
{
    if ([SKPaymentQueue canMakePayments]) {
        SKPayment *payment = [SKPayment paymentWithProduct:self.product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
}


#pragma mark SKProductsRequestDelegate

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    self.product = (SKProduct *)[response.products lastObject];
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:self.product.priceLocale];
    NSString *formattedPrice = [numberFormatter stringFromNumber:self.product.price];
    
    
    NSLog(@"products price: %@", formattedPrice);
    
    NSString *temp = [NSString stringWithFormat:@"%@ %@", [self.product localizedTitle], formattedPrice];
    [self.button setTitle:temp forState:UIControlStateNormal];
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error
{
    NSLog(@"error: %@", error);
}


@end
