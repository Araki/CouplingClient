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

#define kPFActionSheetFrameDefault CGRectMake(0, 150, 320, 485)

#define kPFActionSheetFrameDefault_NonNavBar       CGRectMake(0, 160 + 44, 320, 485)
#define kPFActionSheetFrameDefault_NonNavBar_4inch CGRectMake(0, 160 + 88 + 44, 320, 485)

typedef enum {
    singleType = 0, // PickerViewのcomponentが１つのタイプ
    dowbleType,     //          〃            2つのタイプ
    tripleType      //          〃            3つのタイプ
}kPFActionSheetType;

typedef enum{
    defaultFrameType = 0,
}kPFActionSheetFrameType; // ActionSheetのframeを定義するためのenum


@protocol PFActionSheetDelegate <NSObject>

/**
 * okボタンが押されたときに呼ばれる。引数にはPickerViewで選んだTitle(NSString)がComponentごとに配列で入っている。
 */
@optional
- (void)dismissOkButtonWithTitles:(NSArray *)titles type:(kPFActionSheetType)type;
/**
 * 選択されたPickerのcomponentとtitleが渡される
 */
- (void)selectedWithComponent:(NSInteger)component title:(NSString *)title type:(kPFActionSheetType)type;

@end

@interface PFActionSheet : UIActionSheet <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, assign) id<PFActionSheetDelegate> PFDelegate;
@property (nonatomic, strong) NSArray *titleArray;// pickerのタイトルが入ったArray。Array.countはcomponentの数と対応する。

+ (id)sheetWithView:(UIView *)view frameType:(kPFActionSheetFrameType)frameType delegate:(id)delegate titles:(NSArray *)title,...NS_REQUIRES_NIL_TERMINATION;
@end
