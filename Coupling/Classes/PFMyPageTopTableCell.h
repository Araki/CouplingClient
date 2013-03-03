//
//  PFMyPageTopTableCell.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFMyPageTopTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *outletFavoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *outletStatusButton;
@property (weak, nonatomic) IBOutlet UILabel *outletUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *outletUserAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *outletUserAddressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *outletUserPictureImage;


@end
