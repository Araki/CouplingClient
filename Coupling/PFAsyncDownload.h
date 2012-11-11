//
//  PFAsyncDownload.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFBlocks.h"

@interface PFAsyncDownload : NSObject {
    long long downloadedContentLength;
    long long expectedContentLength;
	BOOL useHTTPCache;
	BOOL hasCache;
}

+ (PFAsyncDownload *)downloader;

- (void)downloadFromURL:(NSString*)url
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate;

- (void)downloadFromURL:(NSString*)url
				 params:(NSDictionary *)params
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate;

- (void)downloadFromURL:(NSString*)url
				 params:(NSDictionary *)params
			   useCache:(BOOL)useCache
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate;

- (void)cancel;

@end
