//
//  PFHTTPDownloadManager.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFHTTPDownloadManager.h"

@interface PFHTTPDownloadManager()
@property (retain) NSOperationQueue *downloadQueue;
@end

@implementation PFHTTPDownloadManager
@synthesize downloadQueue=__downloadQueue;

- (void)addedOperationToQueue:(NSOperation *)downloader {
	[self.downloadQueue addOperation:downloader];
}

#pragma mark - singleton pattern

+ (PFHTTPDownloadManager *)sharedObject {
	return [super sharedObject];
}

- (id)init {
	self = [super init];
	if (self != nil) {
		self.downloadQueue = [[NSOperationQueue alloc] init];
        self.downloadQueue.maxConcurrentOperationCount = 3;
	}
	return self;
}

@end

@implementation PFSingleLineHTTPDownloadManager
- (id)init {
    self = [super init];
    if (self) {
        self.downloadQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}
@end