//
//  PFProfilePictureSelectTableViewCell.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/07.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfilePictureSelectTableViewCell.h"

@interface PFProfilePictureSelectTableViewCell ()

@property (assign, nonatomic) NSInteger selectedIndex;

@end

@implementation PFProfilePictureSelectTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _selectedIndex = 0;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)actionSetMain:(id)sender
{
    // ボタンのタグにtableViewのIndexPath.rowがナンバリングされている->何番目のボタンがタップされたかわかるように。
    self.selectedIndex = ((UIButton *)sender).tag;
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.tag = 1;
    alert.delegate = self;
    alert.title = @"確認";
    alert.message = @"この写真をメインに設定します。よろしいですか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
    
}

- (void)actionDelete:(id)sender
{
    self.selectedIndex = ((UIButton *)sender).tag;
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.tag = 2;
    alert.delegate = self;
    alert.title = @"削除";
    alert.message = @"この写真を削除します。よろしいですか？";
    [alert addButtonWithTitle:@"いいえ"];
    [alert addButtonWithTitle:@"はい"];
    [alert show];
}



-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 削除
    if (alertView.tag == 1) {
        switch (buttonIndex) {
            case 0:
                // cancel
                break;
            case 1:
                [self.delegate setMainButtonWithIndex:self.selectedIndex];
                break;
        }
    // メインに設定
    } else {
        switch (buttonIndex) {
            case 0:
                // cancel
                break;
            case 1:
                [self.delegate deleteButtonWithIndex:self.selectedIndex];
                break;
        }
    }
    
    
}

@end
