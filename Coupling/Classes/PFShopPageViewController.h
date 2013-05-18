//
//  PFShopPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/04/14.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFAbstractPageViewController.h"

@interface PFShopPageViewController : PFAbstractPageViewController

@property (weak, nonatomic) IBOutlet UILabel *outletOwnPointLabel;
- (IBAction)actionShowTapJoyView:(id)sender;

@end
