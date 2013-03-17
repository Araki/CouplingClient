//
//  PFPairSearchProfileScrollViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/01/21.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFPairSearchProfileDelegate <NSObject>

- (void)showTalkPage;

@end

@interface PFPairSearchProfileScrollViewController : UIViewController

@property (assign, nonatomic) id<PFPairSearchProfileDelegate> delegate;

- (IBAction)actionOpenFacebook:(id)sender;
- (IBAction)actionViewingFacebookPage:(id)sender;
- (IBAction)actionFavorite:(id)sender;
- (IBAction)actionLikeOrTalk:(UIButton *)sender;



@end
