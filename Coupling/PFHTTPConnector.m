//
//  PFHTTPConnector.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFHTTPConnector.h"
#import "PFGlobal.h"
#import "NSString+Extension.h"
#import "PFError.h"
#import "PFNotificationsName.h"
#import "PFUser.h"
#import "PFHTTPClientManager.h"
#import "PFHTTPClient.h"
#import "PFBlocks.h"
#import "PFMiscUtil.h"

@implementation PFHTTPConnector

+ (NSString *)urlStringFromCommand:(NSString *)command params:(id)params
{
	return [PFMiscUtil urlStringFromPath:[NSString stringWithFormat:@"%@%@", kPFEndpointBase, command] params:params];
}

+ (void)dealWithResponse:(PFHTTPResponse *)response
			   onSuccess:(PFHTTPResponseBlock)onSuccess
			   onFailure:(PFErrorBlock)onFailure
{
	if (response.isSuccessful) {
		onSuccess(response);
	} else {
		if (response.error.code == PFServerErrorInvalidSession)
			[[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationSessionBecameInvalid object:nil];
		
		onFailure(response.error);
	}
}

+ (void)requestWithCommand:(NSString *)command
				 onSuccess:(PFHTTPResponseBlock)onSuccess
				 onFailure:(PFErrorBlock)onFailure
{
	[self requestWithCommand:command params:[NSDictionary dictionaryWithObject:[PFUser currentUser].sessionId forKey:@"session"] onSuccess:onSuccess onFailure:onFailure];
}

+ (void)requestWithCommand:(NSString *)command
					params:(NSDictionary *)params
				 onSuccess:(PFHTTPResponseBlock)onSuccess
				 onFailure:(PFErrorBlock)onFailure
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationHTTPRequestToServerIsSent object:nil];
	
	if (![params objectForKey:@"session"] && [PFUser currentUser].sessionId) {
		NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:params];
		[newDic setObject:[PFUser currentUser].sessionId forKey:@"session"];
		params = newDic;
	}
	
	[[PFHTTPClientManager sharedObject] addedOperationToQueue:[PFHTTPClient downloadJSONFromURL:[self urlStringFromCommand:command params:params] onSuccess:^(PFHTTPResponse *response) {
		[self dealWithResponse:response onSuccess:onSuccess onFailure:onFailure];
	} onFailure:onFailure]];
}

+ (void)postWithCommand:(NSString *)command
				 params:(NSDictionary *)params
			  onSuccess:(PFHTTPResponseBlock)onSuccess
			  onFailure:(PFErrorBlock)onFailure
{
	[[NSNotificationCenter defaultCenter] postNotificationName:kPFNotificationHTTPRequestToServerIsSent object:nil];
	
	if (![params objectForKey:@"session"]) {
		NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:params];
		[newDic setObject:[PFUser currentUser].sessionId forKey:@"session"];
		params = newDic;
	}
	
	[[PFSingleLineHTTPClientManager sharedObject] addedOperationToQueue:[PFHTTPClient uploadAndGetJSONResponseFromURL:[self urlStringFromCommand:command params:nil] params:params onSuccess:^(PFHTTPResponse *response) {
		[self dealWithResponse:response onSuccess:onSuccess onFailure:onFailure];
	} onFailure:onFailure]];
}

@end
