//
//  NSString+Extension.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSData *)decodeFromHexidecimal
{
	const char *dataBytes = [self cStringUsingEncoding:NSUTF8StringEncoding];
	NSUInteger dataLength = strlen(dataBytes);
	unsigned char *buffer = (unsigned char *)malloc((dataLength / 2) + 1);
	unsigned char *index = buffer;
	
	while ((*dataBytes) && (*(dataBytes + 1))) {
		char encoder[3] = {'\0','\0','\0'};
		encoder[0] = *dataBytes;
		encoder[1] = *(dataBytes + 1);
		*index = (char)strtol(encoder, NULL, 16);
		index++;
		dataBytes += 2;
	}
	*index = '\0';
	
	NSData *result = [NSData dataWithBytes:buffer length:(dataLength / 2)];
	free(buffer);
	
	return result;
}

- (NSString *)serializeIntoHexidecimal:(NSData *)data
{
	NSMutableString *str = [NSMutableString stringWithCapacity:64];
	int length = [data length];
	char *bytes = malloc(sizeof(char) * length);
	
	[data getBytes:bytes length:length];
	
	for (int i = 0; i < length; i++)
		[str appendFormat:@"%02.2hhx", bytes[i]];
    
	free(bytes);
	
	return str;
}

- (NSString *)substringBetweenPrefix:(NSString *)prefix andSuffix:(NSString *)suffix
{
	NSRange rangeOfPrefix = [self rangeOfString:prefix];
	if (rangeOfPrefix.location != NSNotFound) {
		NSRange rangeOfSuffix = [self rangeOfString:suffix options:0 range:NSMakeRange(rangeOfPrefix.location, [self length] - rangeOfPrefix.location)];
		if (rangeOfSuffix.location != NSNotFound)
            return [self substringWithRange:NSMakeRange(NSMaxRange(rangeOfPrefix), rangeOfSuffix.location - NSMaxRange(rangeOfPrefix))];
	}
	return nil;
}

- (BOOL)containsString:(NSString *)stringToFind
{
	return ([self rangeOfString:stringToFind].location != NSNotFound);
}

//- (NSString *)encodeEscape
//{
//	return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, CFSTR (";,/?:@&=+$ #"), kCFStringEncodingUTF8);
//}

- (int)versionIntValue
{
	NSArray *components = [self componentsSeparatedByString:@"."];
	if (self == nil || [self isEqualToString:@""] || components == nil)
		return -1;
	
	NSString *majorString, *minorString, *revisionString;
	switch ([components count]) {
		case 2:	// ex 1.23
			majorString = [components objectAtIndex:0];
			minorString = [components objectAtIndex:1];
			revisionString = @"0";
			break;
		case 3:	// ex.1.23.45
			majorString = [components objectAtIndex:0];
			minorString = [components objectAtIndex:1];
			revisionString = [components objectAtIndex:2];
			break;
		default:
			return -1;
			break;
	}
	
	@try {
		int majorInt = [majorString intValue];
		int minorInt = [minorString intValue];
		int revisionInt = [revisionString intValue];
		return revisionInt + minorInt * 100 + majorInt * 10000;
	}
	@catch (NSException * e) {
		return -1;
	}
	
	return -1;
}

//- (NSString *)firstCharacterCapitalizedString
//{
//	if ([self length] <= 1) return [[self copy] autorelease];
//	return [[[self substringToIndex:1] capitalizedString] stringByAppendingString:[self substringFromIndex:1]];
//}

- (NSString *)stringByReplacingInvalidJSONString
{
	NSMutableString *replacedString = [NSMutableString stringWithString:self];
	
	do {
		NSCharacterSet *invalidCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"\u2028\u2029"];
		NSRange range = [replacedString rangeOfCharacterFromSet:invalidCharacterSet];
		
		if (range.location == NSNotFound)
			break;
		
		[replacedString replaceCharactersInRange:range withString:@""];
	} while (true);
	
	return replacedString;
}

@end
