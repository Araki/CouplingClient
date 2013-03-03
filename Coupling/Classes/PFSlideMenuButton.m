//
//  PFSlideMenuButton.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/27.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFSlideMenuButton.h"
#import "PFMyPageTopPageViewController.h"

@implementation PFSlideMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)buttonDidTouchDown:(id)sender
{
    PFSlideMenuButton *theButton = (PFSlideMenuButton *)sender;
    NSLog(@"Button[%d,%d] was pressed.", theButton.section, theButton.row);
    
    // delegate method
    [self.delegate selectedSlideMenuWithIndex:theButton.row];
}


@end
