//
//  TitleViewController.h
//  Coupling
//
//  Created by tsuchimoto on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFIndicatorView;

@interface TitleViewController : UIViewController

@property(nonatomic, retain) PFIndicatorView *indicatorView;

- (IBAction)loginFacebook:(id)sender;
- (IBAction)showSignupView:(id)sender;

@end
