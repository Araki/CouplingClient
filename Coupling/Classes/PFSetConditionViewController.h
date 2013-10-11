//
//  PFSetConditionViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/02/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFActionSheet.h"
#import "PFAbstractPageViewController.h"

@protocol PFSetConditionViewControllerDelegate;

@interface PFSetConditionViewController : PFAbstractPageViewController <PFActionSheetDelegate>

@property (nonatomic, assign) id <PFSetConditionViewControllerDelegate> setConditionViewControllerDelegate;
@property (strong, nonatomic) PFActionSheet *actionSheet;
@property (strong, nonatomic) NSIndexPath *currentPath;

@end

@protocol PFSetConditionViewControllerDelegate <NSObject>

@optional
- (void)setSearchCondition:(NSArray *)searchArray;

@end
