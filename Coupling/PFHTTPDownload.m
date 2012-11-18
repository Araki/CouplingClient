//
//  PFHTTPDownload.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFHTTPDownload.h"
#import "PFHTTPResponse.h"
#import "NSError+Pairful.h"
#import "PFLogger.h"

#import "PFAsyncDownload.h"

@interface PFHTTPDownload()

@property (retain) NSString* url;
@property (copy) id onSuccess;
@property (copy) id onFailure;
@property (retain) NSString* filePath;
@property (assign) PFHTTPDownloadResponseType responseType;

- (void)performBlockOnCallbackThread:(NSDictionary*)params;
+ (PFHTTPDownload *)downloaderWithURL:(NSString *)url
							onSuccess:(id)onSuccess
							onFailure:(id)onFailure;
@end

@implementation PFHTTPDownload
@synthesize url = url_, onSuccess = onSuccess_, onFailure = onFailure_, responseType = responseType_, filePath = filePath_;

#pragma mark - constractor

+ (PFHTTPDownload *)downloaderWithURL:(NSString *)url
							onSuccess:(id)onSuccess
							onFailure:(id)onFailure {
	PFHTTPDownload *downloader = [[PFHTTPDownload alloc] init];
	downloader.url = url;
    downloader.onSuccess = onSuccess;
    downloader.onFailure = onFailure;
    return downloader;
}

+ (PFHTTPDownload *)downloadFileFromURL:(NSString*)urlString
								 toFile:(NSString*)filePath
							  onSuccess:(PFHTTPDownloadFileSuccessBLock)onSuccess
							  onFailure:(PFHTTPDownloadErrorBlock)onFailure {
	PFHTTPDownload *downloader = [PFHTTPDownload downloaderWithURL:urlString onSuccess:onSuccess onFailure:onFailure];
	downloader.responseType = kPFHTTPDownloadResponseTypeWriteToFile;
	downloader.filePath = filePath;
    return downloader;
}

+ (PFHTTPDownload *)downloadUTF8StringFromURLInBackground:(NSString*)urlString
												onSuccess:(PFHTTPDownloadUTF8StringSuccessBlock)onSuccess
												onFailure:(PFHTTPDownloadErrorBlock)onFailure {
    PFHTTPDownload* downloader = [PFHTTPDownload downloaderWithURL:urlString onSuccess:onSuccess onFailure:onFailure];
    downloader.responseType = kPFHTTPDownloadResponseTypeUTF8String;
    return downloader;
}
+ (PFHTTPDownload *)downloadJSONFromURLInBackground:(NSString*)urlString
										  onSuccess:(PFHTTPDownloadJSONSuccessBlock)onSuccess
										  onFailure:(PFHTTPDownloadErrorBlock)onFailure {
    PFHTTPDownload* downloader = [PFHTTPDownload downloaderWithURL:urlString onSuccess:onSuccess onFailure:onFailure];
    downloader.responseType = kPFHTTPDownloadResponseTypeJSON;
    return downloader;
}

- (void)performBlockOnCallbackThread:(NSDictionary*)params
{
	NSError* error = (NSError*)[params objectForKey:@"error"];
    void(^failureBlock)(NSError *) = self.onFailure;
    
	if(error) {
        if ([error code] == -1009) {	// Network error
			if(failureBlock) failureBlock([NSError errorWithDomain:kPFConnectionError code:kPFErrorTypeNetworkError userInfo:nil]);
		} else {
			if(failureBlock) failureBlock((NSError *)error);
		}
    } else {
        NSData* data = [params objectForKey:@"resultData"];
        switch (self.responseType) {
            case kPFHTTPDownloadResponseTypeJSON: {
                void(^successBlock)(PFHTTPResponse *) = self.onSuccess;
                NSString* resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                successBlock([PFHTTPResponse responseFromJson:resultString]);
            } break;
            case kPFHTTPDownloadResponseTypeUTF8String:{
                void(^successBlock)(NSString *) = self.onSuccess;
                NSString* resultString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                successBlock(resultString);
            } break;
            case kPFHTTPDownloadResponseTypeWriteToFile:{
                [[NSFileManager defaultManager] createDirectoryAtPath:[self.filePath stringByDeletingLastPathComponent] withIntermediateDirectories: YES attributes: nil error: nil];
                if ([data writeToFile:self.filePath atomically:YES]) {
                    void(^successBlock)() = self.onSuccess;
                    successBlock();
                } else {
                    failureBlock([NSError errorWithType:0 message:@""]);
                }
            } break;
            default:
                break;
        }
    }
}

#pragma mark NSOperation

- (void)main {
	PFAsyncDownload* downloader = [PFAsyncDownload downloader];
    PFCLog(PFLOG_CAT_HTTP_REQUEST, @"[HTTP]%@", self.url);
	
	__block dispatch_semaphore_t download_semaphore = dispatch_semaphore_create(0);
	
    [downloader downloadFromURL:self.url onSuccess:^(NSData *downloadedData) {
        PFCLog(PFLOG_CAT_HTTP_REQUEST, @"[HTTP] onSuccess");
        [self performBlockOnCallbackThread:[NSDictionary dictionaryWithObject:downloadedData forKey:@"resultData"]];
		dispatch_semaphore_signal(download_semaphore);
    } onFailure:^(NSError *error) {
        PFCLog(PFLOG_CAT_HTTP_REQUEST, @"[HTTP] onFailure");
        [self performBlockOnCallbackThread:[NSDictionary dictionaryWithObject:error forKey:@"error"]];
		dispatch_semaphore_signal(download_semaphore);
    } onUpdate:nil];
	
	dispatch_semaphore_wait(download_semaphore, DISPATCH_TIME_FOREVER);
	dispatch_release(download_semaphore); download_semaphore = nil;
	
}
@end
