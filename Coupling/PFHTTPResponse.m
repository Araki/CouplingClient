//
//  PFHTTPResponse.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFHTTPResponse.h"
#import "SBJson.h"
#import "PFLogger.h"
#import "PFError.h"
#import "NSString+Extension.h"

@implementation PFHTTPResponse
@synthesize jsonString=__jsonString;

- (id)initWithJson:(NSString *)json
{
	self = [super init];
	
	if (self) {
		self.jsonString = json;
		
		PFCLog(PFLOG_CAT_RESPONSE, @"[HTTP Response] %@", [self jsonDictionary]);
	}
	
	return self;
}

+ (PFHTTPResponse *)responseFromJson:(NSString*)json
{
	return [[PFHTTPResponse alloc] initWithJson:json];
}

- (NSDictionary *)jsonDictionary
{
	return [self.jsonString JSONValue];
}

- (BOOL)isSuccessful
{
	return (!self.isS3ErrorXML && [self jsonDictionary]) ? [[[self jsonDictionary] objectForKey:@"status"] isEqualToString:@"ok"] : NO;
}

- (BOOL)isS3ErrorXML
{
	if (self.jsonString) {
		if ([self.jsonString hasPrefix:@"<?xml "]) {
			if ([self.jsonString rangeOfString:@"<Error>"].location != NSNotFound)
				return YES;
		}
	}
	
	return NO;
}

- (NSError *)error
{
	if (self.isS3ErrorXML) {
		NSString* errorString = [self.jsonString substringBetweenPrefix:@"<Error>" andSuffix:@"</Error>"];
		if (errorString)
			return [PFError errorWithCode:PFErrorHTTPResponceError userInfo:nil];
		
		return nil;
	} else {
		return [PFError errorFromResponse:self.jsonString];
	}
}

@end
