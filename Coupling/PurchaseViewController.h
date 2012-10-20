//
//  PurchaseViewController.h
//  Coupling
//
//  Created by tsuchimoto on 12/09/17.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface PurchaseViewController : UIViewController <SKProductsRequestDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (strong, nonatomic) SKProduct *product;

- (IBAction)buy:(id)sender;

@end
