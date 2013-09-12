//
//  PFTutorialViewController.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/09/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFTutorialScrollView.h"

@interface PFTutorialViewController : UIViewController <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet PFTutorialScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIButton *tutorialButton;

- (IBAction)done:(id)sender;

@end
