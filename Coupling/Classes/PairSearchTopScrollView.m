//
//  PairSearchTopScrollView.m
//  Coupling
//
//  Created by Ryo Kamei on 12/12/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PairSearchTopScrollView.h"

@implementation PairSearchTopScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        NSString *imageName = @"test_pairSearchTop.png";
        UIImage *image = [UIImage imageNamed:imageName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        self.contentSize = CGSizeMake(imageView.frame.size.width, imageView.frame.size.height);
        [self addSubview:imageView];
        
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
