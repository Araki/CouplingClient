//
//  PFIndicatorView.m
//  Coupling
//
//  Created by tsuchimoto on 13/06/08.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFIndicatorView.h"

@implementation PFIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark original method

+ (PFIndicatorView *)indicatorWithNavigationController:(UINavigationController *)navigationController;
{
    PFIndicatorView *view = [[PFIndicatorView alloc] initWithFrame:navigationController.view.bounds];
    view.backgroundColor = [UIColor clearColor];
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [indicator setCenter:CGPointMake(view.bounds.size.width / 2, view.bounds.size.height / 2)];
    [view addSubview:indicator];
    [navigationController.view addSubview:view];
    [indicator startAnimating];
    
    return view;
}



@end
