//
//  PFMiscUtil.m
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMiscUtil.h"
#import "NSString+Extension.h"
#import "NSDictionary+Extension.h"

@implementation PFMiscUtil

+ (NSString *)userAgent
{
	NSString *bundleIdentifier = [[NSDictionary dictionaryWithContentsOfFile:[self pathForBundleResource:@"Info" ofType:@"plist"]] objectForKey:@"CFBundleIdentifier"];
	
	NSString *bundleVersion = [[NSDictionary dictionaryWithContentsOfFile:[self pathForBundleResource:@"Info" ofType:@"plist"]] objectForKey:@"CFBundleVersion"];
	
	return [NSString stringWithFormat:@"%@ %@", bundleIdentifier, bundleVersion];
}

+ (BOOL)isJailBroken
{
#if kPFIgnoreJailbrokenDevices
	if (!TARGET_IPHONE_SIMULATOR) {
		NSArray *jailbrokenDirectories = [NSArray arrayWithObjects:@"/bin/bash", @"/Applications/Cydia.app", nil];
		
		for (NSString *jailbrokenDirectory in jailbrokenDirectories) {
			if ([[NSFileManager defaultManager] fileExistsAtPath:jailbrokenDirectory]) {
				return YES;
			}
		}
	}
#endif
	
	return NO;
}

+ (NSString *)pathForBundleResource:(NSString *)resource ofType:(NSString *)type
{
	NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:type];
	
	if (path == nil) {
		path = [[NSBundle bundleForClass:self] pathForResource:resource ofType:type];
	}
	
	return path;
}

+ (NSString *)urlStringFromPath:(NSString *)path params:(id)params
{
	NSMutableString *url = [NSMutableString stringWithFormat:@"%@%@", path, params ? @"?" : @""];
	
	if ([params isKindOfClass:[NSString class]])
		[url appendString:[params encodeEscape]];
	else if ([params isKindOfClass:[NSDictionary class]])
		[url appendString:[params encodedComponentsJoinedByString:@"&"]];
	
	return url;
}

@end
