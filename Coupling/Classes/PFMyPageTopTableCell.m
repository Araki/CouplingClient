//
//  PFMyPageTopTableCell.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMyPageTopTableCell.h"

@implementation PFMyPageTopTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = kPFBackGroundColor;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
