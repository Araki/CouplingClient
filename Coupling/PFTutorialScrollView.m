//
//  PFTutorialScrollView.m
//  Coupling
//
//  Created by 古林 俊祐 on 2013/09/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTutorialScrollView.h"

@implementation PFTutorialScrollView

- (void)initImages:(NSArray *)imageArray
{
    //サイズ指定
    [self setContentSize:CGSizeMake(320 * [imageArray count], self.frame.size.height)];
    //画像追加
    for (int i = 0; i < [imageArray count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        [imageView setFrame:CGRectMake(320 * i, 0, 320, self.frame.size.height)];
        [self addSubview:imageView];
    }
}

@end
