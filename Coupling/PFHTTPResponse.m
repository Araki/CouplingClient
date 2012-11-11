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
#import "NSError+Pairful.h"
#import "NSString+Extension.h"

@implementation PFHTTPResponse
@synthesize jsonString=__jsonString;

#pragma mark - object lifecycle

- (id)initWithJson:(NSString*)json
{
    self = [super init];
	if (self != nil) {
		self.jsonString = json;
	}
    PFCLog(PFLOG_CAT_RESPONSE, @"recieved response json : %@", [self jsonDictionary]);
	return self;
}

+ (PFHTTPResponse *) responseFromJson:(NSString*)json
{
	return [[PFHTTPResponse alloc] initWithJson:json];
}

#pragma mark - methods

- (NSDictionary *)jsonDictionary {
	return [self.jsonString JSONValue];
}

- (BOOL)isValid {
	return ([self jsonDictionary] != nil);
}

- (BOOL)isSuccessful {
	if ([self isValid]) {
		return [[[self jsonDictionary] objectForKey:@"status"] isEqualToString:@"ok"];
	} else {
		return NO;
	}
}

- (BOOL)isS3ErrorXML {
    if (self.jsonString != nil) {
        if ([self.jsonString hasPrefix:@"<?xml "]) { // response is xml
            if ([self.jsonString rangeOfString:@"<Error>"].location != NSNotFound) { // has <Error> tag.
                return YES;
            }
        }
    }
    return NO;
}

- (NSError *)error
{
    if (self.isS3ErrorXML) {
        NSString* errorString = [self.jsonString substringBetweenPrefix:@"<Error>" andSuffix:@"</Error>"];
        if (errorString) {
            return [NSError errorWithCode:[errorString substringBetweenPrefix:@"<Code>" andSuffix:@"</Code>"]
                                  message:[errorString substringBetweenPrefix:@"<Message>" andSuffix:@"</Message>"]];
        }
        return nil;
    } else {
        return [NSError errorFromResponse:self.jsonString];
    }
}

@end
