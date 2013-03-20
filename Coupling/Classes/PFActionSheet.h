//
//  PFActionSheet.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//
//  About : UIPickerViewを埋め込んだUIActionSheetをmodalで表示する。
//          またdelegateメソッドでは、引数にPickerViewで選んだTitle(NSString)が
//          Comonentごとに配列で入っている。
//

#import <UIKit/UIKit.h>

@protocol PFActionSheetDelegate <NSObject>

- (void)dismissOkButtonWithTitles:(NSArray *)titles;

@end
@interface PFActionSheet : UIActionSheet <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) id<PFActionSheetDelegate> PFDelegate;
@property (nonatomic, strong) NSArray *titleArray;// pickerのタイトルが入ったArray。Array.countはcomponentの数と対応する。

+ (id)sheetWithView:(UIView *)view frame:(CGRect)frame delegate:(id)delegate NumberOfComponents:(NSInteger)numOfComponent titles:(NSArray *)title,...NS_REQUIRES_NIL_TERMINATION;
@end
