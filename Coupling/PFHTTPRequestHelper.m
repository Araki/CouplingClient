//
//  HTTPRequestHelper.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFHTTPRequestHelper.h"
#import "PFGlobal.h"
#import "NSString+Extension.h"
#import "NSError+Pairful.h"
#import "PFNotificationsName.h"
#import "PFUser.h"
#import "PFHTTPDownloadManager.h"
#import "PFHTTPDownload.h"

@interface PFHTTPRequestHelper ()
+ (NSString*)buildParameters:(NSDictionary *)params;
@end

@implementation PFHTTPRequestHelper

+ (NSString*)buildParameters:(NSDictionary*)params {
	if (params == nil) return nil;
	if ([params count] == 0) return [NSString string];
	
    NSMutableString *linkedParameters = [NSMutableString string];
	
	for (NSString *key in params) {
		id value = [params objectForKey:key];
//		if ([value isKindOfClass:[NSString class]]) value = [value encodeEscape];
		[linkedParameters appendFormat:@"%@=%@&", key, value];
	}
	[linkedParameters deleteCharactersInRange:NSMakeRange([linkedParameters length] - 1, 1)];
	return linkedParameters;
}

+ (NSString *)urlStringFromCommand:(NSString *)command params:(id)params {
	NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@%@", kPFEndpointBase, command, params ? @"?" : @""];
    
//	if ([params isKindOfClass:[NSString class]]) [url appendString:[params encodeEscape]];
//	else if ([params isKindOfClass:[NSDictionary class]]) [url appendString:[PFHTTPRequestHelper buildParameters:params]];
    if ([params isKindOfClass:[NSDictionary class]]) [url appendString:[PFHTTPRequestHelper buildParameters:params]];
	return url;
}

+ (NSString *)urlStringFromPath:(NSString*)path params:(id)params {
	NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@", path, params ? @"?" : @""];
    
	if ([params isKindOfClass:[NSString class]]) {
//        [url appendString:[params encodeEscape]];
    }
	else if ([params isKindOfClass:[NSDictionary class]]) [url appendString:[PFHTTPRequestHelper buildParameters:params]];
	return url;
}

+ (void)notifyInvalidSessionWithResponse:(PFHTTPResponse *)response
{
	if (!response.isSuccessful) {
		NSError *error = [NSError errorFromResponse:response.jsonString];
		
		if ([error respondsToSelector:@selector(errorCode)] && [error.errorCode isEqualToString:@"invalid_session"])
			[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kPFNotificationSessionBecameInvalid object:nil]];
	}
}

+ (void)requestWithCommand:(NSString*)command
				 onSuccess:(void (^)(PFHTTPResponse*))onSuccess
				 onFailure:(void (^)(NSError *error))onFailure {
	[self requestWithCommand:command params:[NSDictionary dictionaryWithObject:[PFUser currentUser].sessionId forKey:@"session"] onSuccess:onSuccess onFailure:onFailure];
}

+ (void)requestWithCommand:(NSString*)command params:(NSDictionary*)params
				 onSuccess:(void (^)(PFHTTPResponse* response))onSuccess
				 onFailure:(void (^)(NSError *error))onFailure {
	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kPFNotificationHTTPRequestToServerIsSent object:nil]];
	
	[[PFHTTPDownloadManager sharedObject] addedOperationToQueue:[PFHTTPDownload downloadJSONFromURLInBackground:[self urlStringFromCommand:command params:params] onSuccess:^(PFHTTPResponse* response) {
		[[self class] notifyInvalidSessionWithResponse:response];
		
        if (response.isS3ErrorXML) { // Handle error returned from s3.
            onFailure(response.error);
        } else {
            onSuccess(response);
        }
    } onFailure:^(NSError *error) {
		onFailure(error);
	}]];
}

//+ (void)postWithCommand:(NSString*)command params:(NSDictionary*)params
//              onSuccess:(void (^)(PFHTTPResponse* response))onSuccess
//              onFailure:(void (^)(NSError *error))onFailure
//{
//	[[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kPFNotificationHTTPRequestToServerIsSent object:nil]];
//	
//    [[PFSingleLineHTTPDownloadManager sharedObject] addedOperationToQueue:[PNHTTPUpload uploadAndGetJSONResponseFromURL:[self urlStringFromCommand:command params:nil] params:params onSuccess:^(PFHTTPResponse *response) {
//		[[self class] notifyInvalidSessionWithResponse:response];
//		
//        if (response.isS3ErrorXML)
//            onFailure(response.error);
//        else
//            onSuccess(response);
//    } onFailure:onFailure]];
//}

@end
