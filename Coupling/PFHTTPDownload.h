//
//  PFHTTPDownload.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFHTTPResponse;

typedef enum {
    kPFHTTPDownloadResponseTypeJSON,
    kPFHTTPDownloadResponseTypeUTF8String,
    kPFHTTPDownloadResponseTypeWriteToFile
}PFHTTPDownloadResponseType;

typedef void(^PFHTTPDownloadFileSuccessBLock)(void);
typedef void(^PFHTTPDownloadUTF8StringSuccessBlock)(NSString *result);
typedef void(^PFHTTPDownloadJSONSuccessBlock)(PFHTTPResponse *result);
typedef void(^PFHTTPDownloadErrorBlock)(NSError *error);



@interface PFHTTPDownload : NSOperation {
    NSString* url_;
    id onSuccess_;
    id onFailure_;
    PFHTTPDownloadResponseType responseType_;
    NSString* filePath_;
}

+ (PFHTTPDownload *)downloadFileFromURL:(NSString*)urlString
                                 toFile:(NSString*)filePath
                              onSuccess:(PFHTTPDownloadFileSuccessBLock)onSuccess
                              onFailure:(PFHTTPDownloadErrorBlock)onFailure;

+ (PFHTTPDownload *)downloadUTF8StringFromURLInBackground:(NSString*)urlString
                                                onSuccess:(PFHTTPDownloadUTF8StringSuccessBlock)onSuccess
                                                onFailure:(PFHTTPDownloadErrorBlock)onFailure;

+ (PFHTTPDownload *)downloadJSONFromURLInBackground:(NSString*)urlString
                                          onSuccess:(PFHTTPDownloadJSONSuccessBlock)onSuccess
                                          onFailure:(PFHTTPDownloadErrorBlock)onFailure;
@end
