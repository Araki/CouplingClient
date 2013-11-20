//
//  PFMyPageTopTableViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/03.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFAbstractPageViewController.h"
#import "PFActionSheet.h"
#import "MyPageDataManager.h"


@interface PFMyPageTopPageViewController : PFAbstractPageViewController <UITableViewDelegate, PFActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITableView *outletTableViewController;
@property (weak, nonatomic) IBOutlet UINavigationBar *outletNavigationBar;
@property (strong, nonatomic) NSArray *canTalkUserArray;            // トーク出来る（相互いいね）userModelを入れる配列
@property (strong, nonatomic) NSArray *goodFromPartnerUserArray;    // イイネされたユーザーのuserModelを入れる配列
@property (strong, nonatomic) NSArray *goodFromMeUserArray;         // イイネしたユーザーのuserModelを入れる配列
@property (strong, nonatomic) NSArray *favoriteUserDArray;          // お気に入りしたユーザーのuserModelを入れる配列


- (IBAction)actionStatusSortBarButton:(id)sender;

@end
