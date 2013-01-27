//
//  PFPairSearchProfileViewController.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFPairSearchProfileViewController.h"
#import "PFPairSearchProfileScrollViewController.h"

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
      
    PFPairSearchProfileScrollViewController *view1 = [[PFPairSearchProfileScrollViewController alloc] initWithNibName:@"PFPairSearchProfileScrollViewController" bundle:nil];
    
    float width = view1.view.frame.size.width;
    float height = view1.view.frame.size.height;
    [self addChildViewController:view1];
    [self.outletProfileScrollView setContentSize:CGSizeMake(width, height)];
    [self.outletProfileScrollView addSubview:view1.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setOutletProfileImageView:nil];
    [self setOutletProfileScrollView:nil];
    [super viewDidUnload];
}
@end
