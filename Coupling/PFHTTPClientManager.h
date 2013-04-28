//
//  PFHTTPClientManager.h
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFSingletonObject.h"
#import "PFHTTPClient.h"

@interface PFHTTPClientManager : PFSingletonObject

- (void)addedOperationToQueue:(NSOperation *)client;
+ (PFHTTPClientManager *)sharedObject;

@end

@interface PFSingleLineHTTPClientManager : PFHTTPClientManager
@end
