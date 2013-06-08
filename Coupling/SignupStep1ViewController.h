//
//  SignupStep1ViewController.h
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@class PFIndicatorView;

@interface SignupStep1ViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (retain, nonatomic) PFIndicatorView *indicatorView;

- (IBAction)signup:(id)sender;

@end
