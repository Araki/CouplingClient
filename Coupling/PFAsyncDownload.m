//
//  PFAsyncDownload.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFAsyncDownload.h"
#import "NSDictionary+MultiPartFormData.h"
#import "NSDictionary+Extension.h"
//#import "PFArchiveManager.h"
#import "PFMiscUtil.h"
#import "PFError.h"
#import "PFNotificationsName.h"

#define kPFCallbackBlockOnSuccess @"onSuccess"
#define kPFCallbackBlockOnFailure @"onFailure"
#define kPFCallbackBlockOnUpdate @"onUpdate"

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
@synthesize downloadedContentLength;
@synthesize expectedContentLength;
@synthesize useHTTPCache;
@synthesize hasCache;
@synthesize url = url_, downloadedData, connection=__connection, shouldKeepRunning, successBlock=__successBlock, failureBlock=__failureBlock, updateBlock=__updateBlock, currentThread, etagHeader, lastModifiedHeader;

#pragma mark helper

//+ (NSString *)cacheFileNameForURL:(NSString *)url
//{
//	return [NSString stringWithFormat:@".pairful/http-cache-%d", [url hash]];
//}
//
//- (void)cacheHTTPContents:(NSData *)contents
//{
//	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
//						  etagHeader, @"ETag",
//						  lastModifiedHeader, @"Last-Modified",
//						  contents, @"contents", nil];
//	
//	[PFArchiveManager archiveObject:data toFile:[PFAsyncDownload cacheFileNameForURL:self.url]];
//}
//
//+ (NSString *)readEtagHeaderFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PFAsyncDownload cacheFileNameForURL:url]] objectForKey:@"ETag"];
//}
//
//+ (NSString *)readLastModifiedHeaderFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PFAsyncDownload cacheFileNameForURL:url]] objectForKey:@"Last-Modified"];
//}
//
//+ (NSData *)readHTTPContentsFromCacheForURL:(NSString *)url
//{
//	return [[PFArchiveManager unarchiveObjectWithFile:[PFAsyncDownload cacheFileNameForURL:url]] objectForKey:@"contents"];
//}

#pragma mark download

- (void)downloadInBackgroundWithParameter:(NSDictionary *)params
{
	NSMutableURLRequest* urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0f];
	
	[urlRequest setValue:@"gzip" forHTTPHeaderField:@"Accept-Encoding"];
	[urlRequest setValue:[PFMiscUtil userAgent] forHTTPHeaderField:@"User-Agent"];
	
//	if (useHTTPCache) {
//		NSString *etag = [PFAsyncDownload readEtagHeaderFromCacheForURL:self.url];
//		if (etag) {
//			[urlRequest setValue:etag forHTTPHeaderField:@"If-None-Match"];
//			[urlRequest setValue:[PFAsyncDownload readLastModifiedHeaderFromCacheForURL:self.url] forHTTPHeaderField:@"Last-Modified-Since"];
//		}
//	}
	
	if (params) {
		[urlRequest setHTTPMethod:@"POST"];
        NSLog(@" param %@", [params encodedComponentsJoinedByString:@"&"]);
        [urlRequest setHTTPBody:[[params encodedComponentsJoinedByString:@"&"] dataUsingEncoding:NSUTF8StringEncoding]];
//		static NSString *boundary = @"UNIQUEBOUNDARYSTRING";
//		NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//		[urlRequest addValue:contentType forHTTPHeaderField:@"Content-Type"];
//		
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
	if (self.failureBlock) {
		self.failureBlock([PFError errorWithCode:PFErrorAsyncDownloadCancelled userInfo:nil]);
		self.failureBlock = nil;
	}
	
	self.shouldKeepRunning = NO;
}

#pragma mark NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response
{
	expectedContentLength = [response expectedContentLength];
	
	int statusCode = response.statusCode;
	
	if (statusCode == 400 || statusCode == 404 || statusCode == 422 || statusCode == 500 || statusCode == 503) {
		[self.connection performSelector:@selector(cancel) onThread:self.currentThread withObject:nil waitUntilDone:YES];
		
		if (self.failureBlock) {
			self.failureBlock([PFError errorWithCode:statusCode + 1000 userInfo:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%d", statusCode] forKey:@"status_code"]]);
			self.failureBlock = nil;
		}
		
		self.shouldKeepRunning = NO;
		[self clear];
		return;
	}
	
	if (useHTTPCache) {
		if (statusCode == 304)
			hasCache = YES;
		else if (statusCode == 200) {
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
		//[self cacheHTTPContents:downloadedData];
	
	if (self.successBlock)
		//self.successBlock(hasCache ? [PFAsyncDownload readHTTPContentsFromCacheForURL:self.url] : downloadedData);
		self.successBlock(downloadedData);
	
	self.shouldKeepRunning = NO;
	[self clear];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
	if (error.code == NSURLErrorNotConnectedToInternet) {
		[[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationFailedToConnectToInternet object:nil];
		
		if (self.failureBlock)
			self.failureBlock([PFError errorWithCode:PFErrorNotConnectedToInternet userInfo:[NSDictionary dictionaryWithObject:@"offline" forKey:@"code"]]);
	} else {
		if (self.failureBlock)
			self.failureBlock(error);
	}
	
	self.shouldKeepRunning = NO;
	[self clear];
}

#pragma mark object lifecycle

+ (PFAsyncDownload *)downloaderWithURL:(NSString*)url
								params:(NSDictionary *)params
							  useCache:(BOOL)useCache
							 onSuccess:(PFDataBlock)onSuccess
							 onFailure:(PFErrorBlock)onFailure
							  onUpdate:(PFAsyncDownloadUpdateBlock)onUpdate
{
	PFAsyncDownload *download = [[PFAsyncDownload alloc] init];
	
	download.url = url;
	
	download.successBlock	= onSuccess;
	download.failureBlock	= onFailure;
	download.updateBlock	= onUpdate;
	
	download.downloadedData = [NSMutableData data];
	
	download.useHTTPCache = useCache;
	
	[NSThread detachNewThreadSelector:@selector(downloadInBackgroundWithParameter:) toTarget:download withObject:params];
	
	return download;
}

- (void)clear
{
	self.successBlock = nil;
	self.failureBlock = nil;
	self.updateBlock = nil;
}

@end
