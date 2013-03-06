//
//  PFProfilePictureSelectTableViewCell.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/07.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PFProfilePictureSelectTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *outletUserImage;
@property (weak, nonatomic) IBOutlet UIButton *outletSetMainButton;
@property (weak, nonatomic) IBOutlet UIButton *outletDeleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *outletMainImageView;

- (IBAction)actionSetMain:(id)sender;
- (IBAction)actionDelete:(id)sender;
@end
