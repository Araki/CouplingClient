//
//  PFBlocks.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

typedef void(^PFEmptyBlock)(void);
typedef void(^PFErrorBlock)(NSError *error);
typedef void(^PFConditionBlock)(BOOL condition);
typedef void(^PFArrayBlock)(NSArray *objects);
typedef void(^PFArrayBlockE)(NSArray *objects, NSError *error);
typedef void(^PFHostPortBlock)(NSString *host, int port);
typedef void(^PFDataReceiveBlock)(NSString *user, NSData *data);
typedef void(^PFUserBlock)(NSString *user);
typedef void(^PFDataBlock)(NSData *data);
typedef void(^PFDataBlockE)(NSData *data, NSError *error);
typedef void(^PFAsyncDownloadUpdateBlock)(int downloadedContentLength, int expectedContentLength);
