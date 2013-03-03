//
//  PFSlideMenuButton.h
//  Coupling
//
//  Created by Ryo Kamei on 13/01/27.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PFSlideMenuButtonDelegate <NSObject>

/*
 * タップされたボタンのindexを引数にとる 
 */
- (void)selectedSlideMenuWithIndex:(NSInteger)index;

@end


@interface PFSlideMenuButton : UIButton

@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger row;
@property (nonatomic, assign) id<PFSlideMenuButtonDelegate> delegate;

@end
