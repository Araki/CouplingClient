//
//  PFHTTPClient.m
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFHTTPClient.h"
#import "PFLogger.h"
#import "PFError.h"
#import "PFAsyncDownload.h"

#define kPFKeyForFilePathParameter @"kPFKeyForFilePathParameter"

@interface PFHTTPClient ()
@property (retain) NSString *url;
@property (copy) id onSuccess;
@property (copy) PFErrorBlock onFailure;
@property (retain) NSDictionary *params;
@property (assign) PFHTTPClientRequestType requestType;
@property (assign) PFHTTPClientResponseType responseType;
@end

@implementation PFHTTPClient

@synthesize url = _url;
@synthesize onSuccess = _onSuccess;
@synthesize onFailure = _onFailure;
@synthesize params = _params;
@synthesize requestType = _requestType;
@synthesize responseType = _responseType;

#pragma mark -

- (id)initWithURL:(NSString *)url
	  requestType:(PFHTTPClientRequestType)requestType
	 responseType:(PFHTTPClientResponseType)responseType
		onSuccess:(id)onSuccess
		onFailure:(PFErrorBlock)onFailure
{
	self = [super init];
	
	if (self) {
		self.url = url;
		self.requestType = requestType;
		self.responseType = responseType;
		self.onSuccess = onSuccess;
		self.onFailure = onFailure;
	}
	
	return self;
}

#pragma mark - Constructor

+ (PFHTTPClient *)clientWithURL:(NSString *)url
					requestType:(PFHTTPClientRequestType)requestType
				   responseType:(PFHTTPClientResponseType)responseType
					  onSuccess:(id)onSuccess
					  onFailure:(PFErrorBlock)onFailure
{
	return [[PFHTTPClient alloc] initWithURL:url requestType:requestType responseType:responseType onSuccess:onSuccess onFailure:onFailure];
}

+ (PFHTTPClient *)downloadFileFromURL:(NSString *)url
							   toFile:(NSString *)filePath
							onSuccess:(PFEmptyBlock)onSuccess
							onFailure:(PFErrorBlock)onFailure
{
	PFHTTPClient *client = [PFHTTPClient clientWithURL:url requestType:kPFHTTPClientRequestTypeGET responseType:kPFHTTPClientResponseTypeWriteToFile onSuccess:onSuccess onFailure:onFailure];
	
	client.params = [NSDictionary dictionaryWithObject:filePath forKey:kPFKeyForFilePathParameter];
	
	return client;
}

+ (PFHTTPClient *)downloadUTF8StringFromURL:(NSString *)url
								  onSuccess:(PFStringBlock)onSuccess
								  onFailure:(PFErrorBlock)onFailure
{
	return [PFHTTPClient clientWithURL:url requestType:kPFHTTPClientRequestTypeGET responseType:kPFHTTPClientResponseTypeUTF8String onSuccess:onSuccess onFailure:onFailure];
}

+ (PFHTTPClient *)downloadJSONFromURL:(NSString *)url
							onSuccess:(PFHTTPResponseBlock)onSuccess
							onFailure:(PFErrorBlock)onFailure
{
	return [PFHTTPClient clientWithURL:url requestType:kPFHTTPClientRequestTypeGET responseType:kPFHTTPClientResponseTypeJSON onSuccess:onSuccess onFailure:onFailure];
}

+ (PFHTTPClient *)uploadAndGetUTF8StringResponseFromURL:(NSString *)url
												 params:(NSDictionary *)params
											  onSuccess:(PFStringBlock)onSuccess
											  onFailure:(PFErrorBlock)onFailure
{
	PFHTTPClient *client = [PFHTTPClient clientWithURL:url requestType:kPFHTTPClientRequestTypePOST responseType:kPFHTTPClientResponseTypeUTF8String onSuccess:onSuccess onFailure:onFailure];
	
	client.params = params;
	
	return client;
}

+ (PFHTTPClient *)uploadAndGetJSONResponseFromURL:(NSString *)url
										   params:(NSDictionary *)params
										onSuccess:(PFHTTPResponseBlock)onSuccess
										onFailure:(PFErrorBlock)onFailure
{
	PFHTTPClient *client = [PFHTTPClient clientWithURL:url requestType:kPFHTTPClientRequestTypePOST responseType:kPFHTTPClientResponseTypeJSON onSuccess:onSuccess onFailure:onFailure];
	
	client.params = params;
	
	return client;
}

#pragma mark NSOperation

- (void)performBlock:(NSDictionary *)params
{
	NSError *error = (NSError *)[params objectForKey:@"error"];
	
	if (error) {
		self.onFailure(error);
		return;
	}
	
	NSData *data = [params objectForKey:@"resultData"];
	
	switch (self.responseType) {
		case kPFHTTPClientResponseTypeJSON: {
			PFHTTPResponseBlock successBlock = self.onSuccess;
			NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			successBlock([PFHTTPResponse responseFromJson:json]);
		} break;
		case kPFHTTPClientResponseTypeUTF8String: {
			PFStringBlock successBlock = self.onSuccess;
			NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
			successBlock(result);
		} break;
		case kPFHTTPClientResponseTypeWriteToFile: {
			NSString *filePath = [self.params objectForKey:kPFKeyForFilePathParameter];
			
			[[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories: YES attributes: nil error: nil];
			if ([data writeToFile:filePath atomically:YES])
				((PFEmptyBlock)self.onSuccess)();
			else
				self.onFailure([PFError errorWithCode:PFErrorUnknownError userInfo:nil]);
		} break;
		default:
			break;
	}
}

- (void)main
{
	PFCLog(PFLOG_CAT_HTTP_REQUEST, @"[HTTP]%@", self.url);
	
	__block dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	
	PFDataBlock successBlock = ^(NSData *data) {
		[self performBlock:[NSDictionary dictionaryWithObject:data forKey:@"resultData"]];
		dispatch_semaphore_signal(semaphore);
	};
	
	PFErrorBlock failureBlock = ^(NSError *error) {
		[self performBlock:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
		dispatch_semaphore_signal(semaphore);
	};
	
	[PFAsyncDownload downloaderWithURL:self.url params:(self.requestType == kPFHTTPClientRequestTypeGET)? nil: self.params useCache:NO onSuccess:successBlock onFailure:failureBlock onUpdate:nil];
	
	dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//	dispatch_release(semaphore);
	semaphore = nil;
	
	self.onSuccess = nil;
	self.onFailure = nil;
}

@end
