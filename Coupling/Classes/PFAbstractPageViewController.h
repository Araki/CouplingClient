//
//  PFAbstractPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/17.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFAbstractPageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar;

- (IBAction)actionSlideMenuBarButton:(id)sender;


@end
