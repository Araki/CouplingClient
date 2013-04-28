//
//  NSDictionary+GetterExt.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"

@implementation NSDictionary(GetterExt)

- (NSString *)encodedComponentsJoinedByString:(NSString *)separator
{
	NSMutableArray *pairList = [NSMutableArray array];
	
	for (NSString *key in self) {
		id value = [self objectForKey:key];
		
		if ([value isKindOfClass:[NSString class]])
			value = [value encodeEscape];
		
		[pairList addObject:[NSString stringWithFormat:@"%@=%@", [key encodeEscape], value]];
	}
	
	return [pairList componentsJoinedByString:separator];
}

- (BOOL)hasObjectForKey:(NSString *)key
{
	id object = [self objectForKey:key];
	
	return object && ![object isKindOfClass:[NSNull class]];
}

- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
	id object = [self objectForKey:key];
	
	return [self hasObjectForKey:key] && [object respondsToSelector:@selector(intValue)] ? [object intValue] : defaultValue;
}

- (int64_t)longLongValueForKey:(NSString *)key defaultValue:(int64_t)defaultValue
{
	id object = [self objectForKey:key];
	
	return [self hasObjectForKey:key] && [object respondsToSelector:@selector(longLongValue)] ? [object longLongValue] : defaultValue;
}

- (float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue
{
	id object = [self objectForKey:key];
	
	return [self hasObjectForKey:key] && [object respondsToSelector:@selector(floatValue)] ? [object floatValue] : defaultValue;
}

- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
	id object = [self objectForKey:key];
	
	return [self hasObjectForKey:key] && [object respondsToSelector:@selector(boolValue)] ? [object boolValue] : defaultValue;
}

- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	id object = [self objectForKey:key];
	
	return [self hasObjectForKey:key] && ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) ? [NSString stringWithFormat:@"%@", object] : defaultValue;
}

@end
