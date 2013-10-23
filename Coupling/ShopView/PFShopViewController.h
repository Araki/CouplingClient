//
//  PFShopViewController.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/10/12.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFShopViewControllerDelegate;

@interface PFShopViewController : UIViewController <UIAlertViewDelegate>

@property (nonatomic, assign) id <PFShopViewControllerDelegate> shopViewControllerDelegate;

@property (weak, nonatomic) IBOutlet UILabel *pointLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;


- (IBAction)closeView:(id)sender;
- (IBAction)buyPoints:(id)sender;
- (IBAction)showTapjoy:(id)sender;
- (IBAction)changeLike:(id)sender;

@end

@protocol PFShopViewControllerDelegate <NSObject>

@optional

@end