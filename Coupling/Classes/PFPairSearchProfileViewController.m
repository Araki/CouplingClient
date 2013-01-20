//
//  PFPairSearchProfileViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchProfileViewController.h"

@interface PFPairSearchProfileViewController ()

@end

@implementation PFPairSearchProfileViewController

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
    
#warning test
    UIImage *image = [UIImage imageNamed:@"test_imgres.jpeg"];
    [self.outletProfileImageView setImage:image];
    
    CGRect scrollRect = CGRectMake(0, 80, 320, 400);
    self.profilwScrollView = [[PFPairSearchProfileScrollView alloc] initWithFrame:scrollRect];
    [self.view addSubview:self.profilwScrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOutletProfileImageView:nil];
    [super viewDidUnload];
}
@end
