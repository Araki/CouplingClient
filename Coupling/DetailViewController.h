//
//  DetailViewController.h
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

- (IBAction)signup:(id)sender;
- (IBAction)push:(id)sender;

@end
