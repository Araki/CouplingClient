//
//  NSDictionary+MultiPartFormData.m
//  Coupling
//
//  Created by tsuchimoto on 13/04/29.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "NSDictionary+MultiPartFormData.h"
#import "PNLogger.h"

@implementation NSDictionary (MultiPartFormData)

- (void)addPartForData:(NSMutableData *)data name:(NSString *)name value:(NSString *)value
{
	static NSString *format = @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n";
	[data appendData:[[NSString stringWithFormat:format, name] dataUsingEncoding:NSUTF8StringEncoding]];
	[data appendData:[[NSString stringWithFormat:@"%@", value] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (void)addPartForData:(NSMutableData *)data name:(NSString *)name fileName:(NSString *)fileName contentType:(NSString *)contentType content:(NSData *)content
{
	static NSString *format = @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n";
	[data appendData:[[NSString stringWithFormat:format, name, fileName] dataUsingEncoding:NSUTF8StringEncoding]];
	[data appendData:[[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n",contentType] dataUsingEncoding:NSUTF8StringEncoding]];
	[data appendData:content];
}

- (void)appendPartToData:(NSMutableData *)data key:(NSString *)key boundary:(NSString *)boundary
{
	[data appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];

	if ([[self valueForKey:key] isKindOfClass:[NSDictionary class]]) {
		NSDictionary *value = [self valueForKey:key];
		[self addPartForData:data name:key fileName:[value valueForKey:@"FileName"] contentType:[value valueForKey:@"ContentType"] content:[value valueForKey:@"Content"]];
	}
	else {
		[self addPartForData:data name:key value:[self valueForKey:key]];
	}

	[data appendData:[[NSString stringWithString:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
}

- (NSData *)multiPartFormDataRepresentationWithBoundary:(NSString *)boundary
{
	NSMutableData *data = [NSMutableData data];

	for (NSString *key in self)
		[self appendPartToData:data key:key boundary:boundary];

	[data appendData:[[NSString stringWithFormat:@"--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

	return data;
}

- (NSData *)multiPartFormDataRepresentationForAmazonWithBoundary:(NSString *)boundary
{
	NSArray *orderedKeys = [NSArray arrayWithObjects:@"key", @"acl", @"AWSAccessKeyId", @"policy", @"success_action_redirect", @"signature", @"file", nil];

	NSMutableData *data = [NSMutableData data];

	for (NSString *key in orderedKeys) {
		if (![self valueForKey:key])
			PNWarn(@"Value for amazon key(%@) is not found.", key);

		[self appendPartToData:data key:key boundary:boundary];
	}

	[data appendData:[[NSString stringWithFormat:@"--%@--",boundary] dataUsingEncoding:NSUTF8StringEncoding]];

	return data;
}

@end
