//
//  PFAsyncDownload.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFAsyncDownload.h"
#import "NSError+Pairful.h"
//#import "NSDictionary+MultiPartFormData.h"
//#import "PNArchiveManager.h"
//#import "PNMiscUtil.h"
//#import "PNNotificationNames.h"

#define kPNCallbackBlockOnSuccess @"onSuccess"
#define kPNCallbackBlockOnFailure @"onFailure"
#define kPNCallbackBlockOnUpdate @"onUpdate"

@interface PFAsyncDownload()
@property (retain) NSString* url;
@property (retain) NSMutableData* downloadedData;
@property (retain) NSURLConnection* connection;
@property (assign) BOOL shouldKeepRunning;
@property (copy) PFDataBlock successBlock;
@property (copy) PFErrorBlock failureBlock;
@property (copy) PFAsyncDownloadUpdateBlock updateBlock;
@property (retain) NSThread* currentThread;
@property (retain) NSString *etagHeader;
@property (retain) NSString *lastModifiedHeader;
- (void)clear;
@end

@implementation PFAsyncDownload
@synthesize url = url_, downloadedData, connection=__connection, shouldKeepRunning, successBlock=__successBlock, failureBlock=__failureBlock, updateBlock=__updateBlock, currentThread, etagHeader, lastModifiedHeader;

- (void)clear
{
	self.successBlock = nil;
	self.failureBlock = nil;
	self.updateBlock = nil;
}

+ (PFAsyncDownload *)downloader {
	return [[PFAsyncDownload alloc] init];
}

+ (NSString *)cacheFileNameForURL:(NSString *)url
{
	return [NSString stringWithFormat:@".pankia/http-cache-%d", [url hash]];
}

//- (void)cacheHTTPContents:(NSData *)contents
//{
//	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
//						  etagHeader, @"ETag",
//						  lastModifiedHeader, @"Last-Modified",
//						  contents, @"contents", nil];
//	
//	[PFArchiveManager archiveObject:data toFile:[PNAsyncDownload cacheFileNameForURL:self.url]];
//}

//+ (NSString *)readEtagHeaderFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PNAsyncDownload cacheFileNameForURL:url]] objectForKey:@"ETag"];
//}

//+ (NSString *)readLastModifiedHeaderFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PNAsyncDownload cacheFileNameForURL:url]] objectForKey:@"Last-Modified"];
//}

//+ (NSData *)readHTTPContentsFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PNAsyncDownload cacheFileNameForURL:url]] objectForKey:@"contents"];
//}

- (void)downloadFromURL:(NSString*)url
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate
{
	[self downloadFromURL:url params:nil onSuccess:onSuccess onFailure:onFailure onUpdate:onUpdate];
}

- (void)downloadFromURL:(NSString*)url
				 params:(NSDictionary *)params
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate
{
	[self downloadFromURL:url params:params useCache:NO onSuccess:onSuccess onFailure:onFailure onUpdate:onUpdate];
}

- (void)downloadFromURL:(NSString*)url
				 params:(NSDictionary *)params
			   useCache:(BOOL)useCache
			  onSuccess:(PFDataBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
			   onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate
{
	self.url = url;
	
	self.successBlock	= onSuccess;
	self.failureBlock	= onFailure;
	self.updateBlock	= onUpdate;
	
	self.downloadedData = [NSMutableData data];
	
	NSMutableDictionary *optionalInfo = [NSMutableDictionary dictionaryWithObject:[NSNumber numberWithBool:useCache] forKey:@"useCache"];
	if (params)
		[optionalInfo setObject:params forKey:@"params"];
	
	[NSThread detachNewThreadSelector:@selector(downloadInBackgroundWithParameter:) toTarget:self withObject:optionalInfo];
}

- (void)downloadInBackgroundWithParameter:(NSDictionary *)optionalInfo
{
	NSDictionary *params = [optionalInfo objectForKey:@"params"];
	useHTTPCache = [[optionalInfo objectForKey:@"useCache"] boolValue];
	
	NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
	
	[urlRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
//	[urlRequest setValue:[PNMiscUtil userAgent] forHTTPHeaderField:@"User-Agent"];
	
//	if (useHTTPCache) {
//		NSString *etag = [PFAsyncDownload readEtagHeaderFromCacheForURL:self.url];
//		if (etag) {
//			[urlRequest setValue:etag forHTTPHeaderField:@"If-None-Match"];
//			[urlRequest setValue:[PFAsyncDownload readLastModifiedHeaderFromCacheForURL:self.url] forHTTPHeaderField:@"Last-Modified-Since"];
//		}
//	}
	
	if (params) {
		static NSString *boundary = @"UNIQUEBOUNDARYSTRING";
		[urlRequest setHTTPMethod:@"POST"];
		NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
		[urlRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
		
//		if ([[params objectForKey:@"is_amazon_record?"] isEqualToString:@"yes"])
//			[urlRequest setHTTPBody:[params multiPartFormDataRepresentationForAmazonWithBoundary:boundary]];
//		else
//			[urlRequest setHTTPBody:[params multiPartFormDataRepresentationWithBoundary:boundary]];
	}
	
	self.connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
	self.currentThread = [NSThread currentThread];
	
	shouldKeepRunning = YES;
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
	while (shouldKeepRunning && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]]);
}

- (void)cancel
{
	[self.connection performSelector:@selector(cancel) onThread:self.currentThread withObject:nil waitUntilDone:YES];
	if (self.failureBlock)
		self.failureBlock([NSError errorWithCode:@"cancelled" message:@"cancelled."]);
	
	self.shouldKeepRunning = NO;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
	expectedContentLength = [response expectedContentLength];
	
	if ([response statusCode] == 404 || [response statusCode] == 503) {
		NSString* errorCode = [NSString stringWithFormat:@"%d", [response statusCode]];
		NSString* errorMessage = [response statusCode] == 404 ? @"File not found." : @"The server is down.";
		[self.connection performSelector:@selector(cancel) onThread:self.currentThread withObject:nil waitUntilDone:YES];
		if (self.failureBlock)
			self.failureBlock([NSError errorWithCode:errorCode message:errorMessage]);
		self.shouldKeepRunning = NO;
		[self clear];
		return;
	}
	
	if (useHTTPCache) {
		if ([response statusCode] == 304)
			hasCache = YES;
		else if ([response statusCode] == 200) {
			self.etagHeader = [[response allHeaderFields] objectForKey:@"Etag"];
			self.lastModifiedHeader = [[response allHeaderFields] objectForKey:@"Last-Modified"];
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	downloadedContentLength += (long long)[data length];
	[downloadedData appendData:data];
	if (self.updateBlock)
		self.updateBlock(downloadedContentLength, expectedContentLength);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if (useHTTPCache && !hasCache)
//		[self cacheHTTPContents:downloadedData];
	
	if (self.successBlock)
//		self.successBlock(hasCache ? [PFAsyncDownload readHTTPContentsFromCacheForURL:self.url] : downloadedData);
	
	self.shouldKeepRunning = NO;
	[self clear];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (error.code == NSURLErrorNotConnectedToInternet) {
//		[[NSNotificationCenter defaultCenter] postNotificationName:kPNNotificationFailedToConnectToInternet object:nil];
		if (self.failureBlock)
			self.failureBlock([NSError errorWithCode:@"offline" message:@"Failed to connect internet."]);
	} else {
		if (self.failureBlock)
			self.failureBlock(error);
	}
	
	self.shouldKeepRunning = NO;
	[self clear];
}
@end
