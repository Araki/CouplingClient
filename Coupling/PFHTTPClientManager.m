//
//  PFHTTPClientManager.m
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFHTTPClientManager.h"

@interface PFHTTPClientManager ()
@property (retain) NSOperationQueue *clientQueue;
@end

@implementation PFHTTPClientManager

@synthesize clientQueue = _clientQueue;

- (void)addedOperationToQueue:(NSOperation *)client
{
	[self.clientQueue addOperation:client];
}

+ (PFHTTPClientManager *)sharedObject
{
	return [super sharedObject];
}

- (id)init
{
	self = [super init];
	
	if (self) {
		self.clientQueue = [[NSOperationQueue alloc] init];
		self.clientQueue.maxConcurrentOperationCount = 3;
	}
	
	return self;
}

@end

@implementation PFSingleLineHTTPClientManager

- (id)init
{
	self = [super init];
	
	if (self)
		self.clientQueue.maxConcurrentOperationCount = 1;
	
	return self;
}


@end