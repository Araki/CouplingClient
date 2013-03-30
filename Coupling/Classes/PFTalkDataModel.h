//
//  PFTalkDataModel.h
//  Coupling
//
//  Created by Ryo Kamei on 13/03/30.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFDataModel.h"

@interface PFTalkDataModel : PFDataModel

@property (nonatomic, assign) BOOL          isFromUser;
@property (nonatomic, copy)   NSString *    message;


@property (nonatomic, strong) NSDate *      timeStamp;
@property (nonatomic, strong) UIImage *     iconImage;


@end
