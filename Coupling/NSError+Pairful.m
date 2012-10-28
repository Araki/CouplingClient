//
//  NSError+Pairful.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "NSError+Pairful.h"
#import "PFLogger.h"
#import "SBJSON.h"
//#import "PFLocalizedString.h"
//#import "PFGameModel.h"

@implementation NSError(Pankia)

- (int)errorType {
	NSString *numStr = [[self userInfo] objectForKey:kPFErrorTypeKeyName];
	return [numStr intValue];
}

- (NSString *)errorCode {
	return [[self userInfo] objectForKey:kPFErrorCodeKeyName];
}

- (NSString *)message {
	return [[self userInfo] objectForKey:kPFMessageKeyName];
}

- (NSError *)initWithResponse:(NSString *)response {
	
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	
	NSString *beginStr = @"""";
	NSString *endStr   = @"""";
	
	NSDictionary *json = [response JSONValue];
	NSString *detail     = [json objectForKey:@"detail"];
	if (detail && ![detail isKindOfClass:[NSNull class]]) {
		NSRange    beginRange = [detail rangeOfString:beginStr];
		NSRange    endRange   = [detail rangeOfString:endStr];
		NSUInteger _location  = beginRange.location + [beginStr length] + beginRange.length;
		NSUInteger _length    = endRange.location - _location - endRange.length;
		if (_location && _length) {
			[dic setObject:[detail substringWithRange:NSMakeRange(_location, _length)] forKey:kPFMessageKeyName];
		} else {
			[dic setObject:detail forKey:kPFMessageKeyName];
		}
	} else {
		[dic setObject:@"" forKey:kPFMessageKeyName];
	}
    if ([json objectForKey:@"code"]) {
        [dic setObject:[json objectForKey:@"code"] forKey:kPFErrorCodeKeyName];
    } else {
        //Warn(@"Warning: error code not found. response: %@", response);
    }
	
	if ([json objectForKey:@"subcode"])
		[dic setObject:[json objectForKey:@"subcode"] forKey:@"subcode"];
	
	[dic setObject:@"0" forKey:kPFErrorTypeKeyName];
	return [self initWithDomain:kPFErrorCodeDomain code:kPFErrorCodeNull userInfo:dic];
}

+ (NSError *)errorFromResponse:(NSString*)response {
	return [[self alloc] initWithResponse:response];
}

- (NSError *)initWithCode:(NSString *)code message:(NSString *)aMessage {
	return [self initWithDomain:kPFErrorCodeDomain code:kPFErrorCodeNetworkError userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"", kPFErrorTypeKeyName, code, kPFErrorCodeKeyName, aMessage, kPFMessageKeyName, nil]];
}

+ (NSError *)errorWithCode:(NSString *)code message:(NSString *)message {
	return [[self alloc] initWithCode:code message:message];
}

+ (NSError *)errorWithType:(int)type message:(NSString*)message {
	return [self errorWithDomain:kPFErrorCodeDomain code:kPFErrorCodeNetworkError userInfo:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", type], kPFErrorTypeKeyName, @"", kPFErrorCodeKeyName, message, kPFMessageKeyName, nil]];
}

@end
