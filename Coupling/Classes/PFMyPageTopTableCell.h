//
//  PFMyPageTopTableCell.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageDataManager.h"

@protocol PFMyPageTopTableCellDelegate;

@interface PFMyPageTopTableCell : UITableViewCell <UIAlertViewDelegate>

@property (nonatomic, assign) id <PFMyPageTopTableCellDelegate> myPageTopTableCellDelegate;

@property (weak, nonatomic) IBOutlet UIButton *outletFavoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *outletStatusButton;
@property (weak, nonatomic) IBOutlet UILabel *outletUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outletUserAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *outletUserAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *outletUserPictureImage;

- (void)initCellWithData:(NSDictionary *)userData withShowType:(kPFMyPageSortType)type;

- (IBAction)favorite:(id)sender;
- (IBAction)changeState:(id)sender;

@end

@protocol PFMyPageTopTableCellDelegate <NSObject>

@optional
- (void)showTalkView:(NSDictionary *)user;

@end
