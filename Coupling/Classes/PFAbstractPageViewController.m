//
//  PFAbstractPageViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/17.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFAbstractPageViewController.h"
#import "IIViewDeckController.h"

@interface PFAbstractPageViewController ()

@end

@implementation PFAbstractPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionSlideMenuBarButton:(id)sender
{
    [self.viewDeckController toggleLeftView];
}

@end
