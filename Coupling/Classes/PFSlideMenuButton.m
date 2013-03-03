//
//  PFSlideMenuButton.m
//  Coupling
//
//  Created by Ryo Kamei on 13/01/27.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFSlideMenuButton.h"
#import "PFMyPageTopTableViewController.h"

@implementation PFSlideMenuButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (IBAction)buttonDidTouchDown:(id)sender {
    
    PFSlideMenuButton *theButton = (PFSlideMenuButton *)sender;
    NSLog(@"Button[%d,%d] was pressed.", theButton.section, theButton.row);
    switch (theButton.row) {
        case PairSearch:
            
            break;
        case MyPage:
            
            break;
        case Profile:
            
            break;
        case Shop:
            
            break;
        case Setting:
            
            break;
        case Notification:
            
            break;
        case Invite:
            
            break;
        case Help:
            
            break;
        case TermsOfUse:
            
            break;
        case ContactUs:
            
            break;
        default:
            
            break;
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
