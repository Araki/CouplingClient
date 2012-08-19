//
//  DetailViewController.h
//  Coupling
//
//  Created by tsuchimoto on 12/08/19.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
