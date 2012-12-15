//
//  PairSearchCenterViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PairSearchTopScrollView.h"

@interface PairSearchCenterViewController : UIViewController

@property (nonatomic, retain) PairSearchTopScrollView *scrollView;


//---action---
- (IBAction)actionShowMenuButton:(UIButton *)sender;

@end
