//
//  PFError.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFError.h"
#import "PFLogger.h"
#import "SBJSON.h"

@implementation PFError

#pragma mark - Normal Error

+ (id)errorWithCode:(PFErrorCode)code userInfo:(NSDictionary *)info
{
	return [self errorWithDomain:PairfulErrorDomain code:code userInfo:info];
}

#pragma mark Server Error

+ (NSInteger)codeFromTextCode:(NSString *)code
{
	if ([code isEqualToString:@"invalid_session"])
		return PFServerErrorInvalidSession;
	else if ([code isEqualToString:@"already_exists"])
		return PFServerErrorAlreadyExists;
	else if ([code isEqualToString:@"not_allowed"])
		return PFServerErrorNotAllowed;
	else if ([code isEqualToString:@"not_found"])
		return PFServerErrorNotFound;
	else if ([code isEqualToString:@"external_error"])
		return PFServerErrorExternalError;
	else if ([code isEqualToString:@"invalid_credentials"])
		return PFServerErrorInvalidCredentials;
	
	//PFWarn(@"Unknown error code : %@. please create an error in PFError.(Develop)", code);
	
	return 0;
}

+ (NSError *)errorFromResponse:(NSString *)response
{
	NSDictionary *json = [response JSONValue];
	NSString *code = [json objectForKey:@"code"];
	NSString *detail = [json objectForKey:@"detail"];
	NSString *subcode = [json objectForKey:@"subcode"];
	
	NSMutableDictionary *info = [NSMutableDictionary dictionary];
	
	if (code)
		[info setObject:code forKey:@"code"];
	
	if (subcode)
		[info setObject:subcode forKey:@"subcode"];
	
	if (detail)
		[info setObject:detail forKey:@"detail"];
		
	return [self errorWithDomain:PairfulServerErrorDomain code:[self codeFromTextCode:code] userInfo:info];
}

#pragma mark Description

- (NSString *)localizedDescription
{
	if ([self.domain isEqualToString:PairfulErrorDomain]) {
		NSString *errorReason = nil;
		switch (self.code) {
			case PFErrorNone:
				errorReason = [NSString stringWithFormat:@"this error has no information.(%@ PFErrorNone)", PairfulErrorDomain];
				break;
			case PFErrorOAuthNotLoggedIn:
				errorReason = @"Never called";
				break;
			case PFErrorPairingFailed:
				errorReason = [NSString stringWithFormat:@"pairing has failed"];
				break;
			case PFErrorInvalidArgument:
				errorReason = @"valid argument is not gived.";
				break;
			case PFErrorServerTimeout:
				errorReason = @"responce from server has occured timeout.";
				break;
			case PFErrorUnknownError:
				errorReason = @"unknown error has occured";
				break;
			default:
				errorReason = @"";
				break;
		}
		return [NSString stringWithFormat:@"Error Domain=%@ Code=%d \"%@\" userInfo=%@", self.domain, self.code, errorReason, self.userInfo];
	} else if ([self.domain isEqualToString:PairfulServerErrorDomain]) {
		NSString *code = [self.userInfo objectForKey:@"code"];
		NSString *subcode = [self.userInfo objectForKey:@"subcode"];
		NSString *detail = [self.userInfo objectForKey:@"detail"];
		
		NSMutableString *description = [NSMutableString stringWithFormat:@"Error Domain=%@ Code=%d [text:%@]", self.domain, self.code, code];
		
		if (subcode)
			[description appendFormat:@" [subcode:%@]", subcode];
		
		if (detail)
			[description appendFormat:@" [detail:%@]", detail];
		
		for (NSString *other in self.userInfo) {
			if (![other isEqualToString:@"code"] && ![other isEqualToString:@"subcode"] && ![other isEqualToString:@"detail"])
				[description appendFormat:@" [%@:%@]", other, [self.userInfo objectForKey:other]];
		}
		
		return [NSString stringWithString:description];
	}
	
	return [super localizedDescription];
}

- (NSDictionary *)jsonDictionary
{
	NSMutableDictionary *json = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d", self.code], @"id", nil];
	
	if ([self.domain isEqualToString:PairfulErrorDomain]) {
		[json setObject:@"internal" forKey:@"type"];
		
		NSString *detail = @"";
		
		switch (self.code) {
			case PFErrorNone:
				detail = [NSString stringWithFormat:@"this error has no information.(%@ PFErrorNone)", PairfulErrorDomain];
				break;
			case PFErrorPairingFailed:
				detail = @"pairing has failed";
				[json setObject:@"pairing_failed" forKey:@"code"];
				break;
			case PFErrorInvalidArgument:
				detail = @"invalid argument";
				break;
			case PFErrorPairingTimeout:
				detail = @"pairing_timeout";
				[json setObject:@"pairing_timeout" forKey:@"code"];
				break;
			case PFErrorServerTimeout:
				detail = @"server timeout";
				[json setObject:@"server_timeout" forKey:@"code"];
				break;
			case PFErrorPairingTooHighRTT:
				detail = @"too high rtt";
				[json setObject:@"too_high_rtt" forKey:@"code"];
				break;
			case PFErrorUnknownError:
				detail = @"unknown";
				break;
			default:
				detail = self.localizedDescription;
				break;
		}
		
		[json setObject:detail forKey:@"detail"];
	} else if ([self.domain isEqualToString:PairfulServerErrorDomain]) {
		[json setObject:@"server" forKey:@"type"];
		
		for (NSString *key in self.userInfo) {
			id value = [self.userInfo objectForKey:key];
			
			if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
				[json setObject:value forKey:key];
			else
				[json setObject:[[value description] JSONValue] forKey:key];
		}
	} else {
		[json setObject:@"other" forKey:@"type"];
		
		[json setObject:self.localizedDescription forKey:@"detail"];
	}
	
	return json;
}


@end
