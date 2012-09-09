//
//  SearchResultViewController.m
//  Coupling
//
//  Created by tsuchimoto on 12/09/01.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultView.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

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
    SearchResultView *searchResultView = [[SearchResultView alloc] initWithFrame:self.view.frame];
    
    CGSize size = CGSizeMake(320.0, 700.0);
    searchResultView.scrollView.contentSize = size;
    
    [self.view addSubview:searchResultView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
