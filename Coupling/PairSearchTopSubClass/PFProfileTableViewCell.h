//
//  PFProfileTableViewCell.h
//  Coupling
//
//  Created by 古林 俊祐 on 2013/08/09.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFProfile.h"

@interface PFProfileTableViewCell : UITableViewCell

- (void)initCell:(PFProfile *)dict withRow:(int)row;

@end
