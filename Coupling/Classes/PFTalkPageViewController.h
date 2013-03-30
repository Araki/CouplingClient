//
//  PFTalkPageViewController.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/10.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "JSMessagesViewController.h"
#import "PFTalkDataModel.h"

@interface PFTalkPageViewController : JSMessagesViewController <JSMessagesViewDelegate, JSMessagesViewDataSource>

@property (nonatomic, strong) NSMutableArray *talkDataArray;

@end
