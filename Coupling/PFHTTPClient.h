//
//  PFHTTPClient.h
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFBlocks.h"
#import "PFHTTPResponse.h"
#import "PFGlobal.h"

typedef enum {
	kPFHTTPClientRequestTypeGET,
	kPFHTTPClientRequestTypePOST
} PFHTTPClientRequestType;

typedef enum {
	kPFHTTPClientResponseTypeJSON,
	kPFHTTPClientResponseTypeUTF8String,
	kPFHTTPClientResponseTypeWriteToFile
} PFHTTPClientResponseType;

@interface PFHTTPClient : NSOperation

+ (PFHTTPClient *)downloadFileFromURL:(NSString *)url
							   toFile:(NSString *)filePath
							onSuccess:(PFEmptyBlock)onSuccess
							onFailure:(PFErrorBlock)onFailure;

+ (PFHTTPClient *)downloadUTF8StringFromURL:(NSString *)url
								  onSuccess:(PFStringBlock)onSuccess
								  onFailure:(PFErrorBlock)onFailure;

+ (PFHTTPClient *)downloadJSONFromURL:(NSString *)url
							onSuccess:(PFHTTPResponseBlock)onSuccess
							onFailure:(PFErrorBlock)onFailure;

+ (PFHTTPClient *)uploadAndGetUTF8StringResponseFromURL:(NSString *)url
												 params:(NSDictionary *)params
											  onSuccess:(PFStringBlock)onSuccess
											  onFailure:(PFErrorBlock)onFailure;

+ (PFHTTPClient *)uploadAndGetJSONResponseFromURL:(NSString *)url
										   params:(NSDictionary *)params
										onSuccess:(PFHTTPResponseBlock)onSuccess
										onFailure:(PFErrorBlock)onFailure;

@end
