//
//  TitleViewController.m
//  Coupling
//
//  Created by tsuchimoto on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "TitleViewController.h"
#import "PFPairSearchViewDeckController.h"

@interface TitleViewController ()

@end

@implementation TitleViewController

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
    self.view.backgroundColor = kPFCommonBackGroundColor;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
