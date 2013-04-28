//
//  PFProfilePictureSelectTableViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/07.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFProfilePictureSelectTableViewCell.h"
#import "PFAbstractPageViewController.h"

@interface PFProfilePictureSelectTableViewController : PFAbstractPageViewController<UIActionSheetDelegate,
                                                                            UIImagePickerControllerDelegate,
                                                                            UINavigationControllerDelegate,
                                                                            PFProfileTableCellDelegate>

@end
