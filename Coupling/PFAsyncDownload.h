//
//  PFAsyncDownload.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBlocks.h"

@interface PFAsyncDownload : NSObject

@property (nonatomic, assign) long long downloadedContentLength;
@property (nonatomic, assign) long long expectedContentLength;
@property (nonatomic, assign) BOOL useHTTPCache;
@property (nonatomic, assign) BOOL hasCache;

+ (PFAsyncDownload *)downloaderWithURL:(NSString*)url
								params:(NSDictionary *)params
							  useCache:(BOOL)useCache
							 onSuccess:(PFDataBlock)onSuccess
							 onFailure:(PFErrorBlock)onFailure
							  onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate;

- (void)cancel;

@end
