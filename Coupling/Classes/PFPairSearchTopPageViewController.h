//
//  PFPairSearchTopPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 12/12/31.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFPairSearchTopPageViewController : UIViewController<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *outletScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
