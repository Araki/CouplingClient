//
//  PFPairSearchTopPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 12/12/15.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFAbstractPageViewController.h"
#import "PFProfileScrollView.h"
#import "PFSetConditionViewController.h"

@interface PFPairSearchTopPageViewController : PFAbstractPageViewController <UIScrollViewDelegate, PFProfileScrollViewDelegate, PFSetConditionViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar;

- (IBAction)moveConditionView:(id)sender;

@end
