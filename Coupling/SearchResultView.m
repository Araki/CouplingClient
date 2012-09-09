//
//  SearchResultView.m
//  Coupling
//
//  Created by tsuchimoto on 12/09/01.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "SearchResultView.h"

@implementation SearchResultView
@synthesize scrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self = [[[NSBundle mainBundle] loadNibNamed:@"SearchResultView" owner:self options:nil] objectAtIndex:0];
        return self;
        
    }
    return self;
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
