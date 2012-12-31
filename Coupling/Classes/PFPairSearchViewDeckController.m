//
//  PFPairSearchViewDeckController.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchViewDeckController.h"

@interface PFPairSearchViewDeckController ()

@end

@implementation PFPairSearchViewDeckController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    UIViewController *leftController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchLeftViewController"];
    UIViewController *centerController = [storyboard instantiateViewControllerWithIdentifier:@"PairSearchCenterViewController"];
    
    self = [super initWithCenterViewController:centerController
                            leftViewController:leftController];
    if (self) {
        // Add any extra init code here
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

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
