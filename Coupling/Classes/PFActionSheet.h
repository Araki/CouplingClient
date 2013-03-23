//
//  PFActionSheet.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/20.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//
//  About : UIPickerViewを埋め込んだUIActionSheetをmodalで表示する。
//

#import <UIKit/UIKit.h>

@protocol PFActionSheetDelegate <NSObject>

/**
 * okボタンが押されたときに呼ばれる。引数にはPickerViewで選んだTitle(NSString)がComponentごとに配列で入っている。
 */
@optional
- (void)dismissOkButtonWithTitles:(NSArray *)titles;
/**
 * 選択されたPickerのcomponentとtitleが渡される
 */
- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title;

@end

@interface PFActionSheet : UIActionSheet <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) id<PFActionSheetDelegate> PFDelegate;
@property (nonatomic, strong) NSArray *titleArray;// pickerのタイトルが入ったArray。Array.countはcomponentの数と対応する。

+ (id)sheetWithView:(UIView *)view frame:(CGRect)frame delegate:(id)delegate titles:(NSArray *)title,...NS_REQUIRES_NIL_TERMINATION;
@end
