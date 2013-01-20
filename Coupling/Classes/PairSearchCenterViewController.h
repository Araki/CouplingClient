//
//  PairSearchCenterViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PairSearchCenterViewController : UIViewController<UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *outletScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *outletPageControl;

//---action---
- (IBAction)actionShowMenuButton:(UIButton *)sender;

@end
