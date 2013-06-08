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

+ (NSString *)readUUID
{
    NSMutableDictionary* query = [NSMutableDictionary dictionary];
    [query setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
    [query setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [query setObject:(__bridge id)kSecMatchLimitAll forKey:(__bridge id)kSecMatchLimit];
    [query setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFArrayRef attributesRef = nil;
    OSStatus result = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&attributesRef);
    NSArray *attributes = (__bridge_transfer NSArray *)attributesRef;
    NSData *data = [attributes objectAtIndex:0];
    
    if (result == noErr) {
        return [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
    }
    return nil;
}

+ (NSString *)createUUID
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    [attribute setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [attribute setObject:[[NSBundle mainBundle] bundleIdentifier] forKey:(__bridge id)kSecAttrService];
    [attribute setObject:[uuid dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge id)kSecValueData];
    OSStatus error = SecItemAdd((__bridge CFDictionaryRef)attribute, NULL);
    if (error == noErr) {
        NSLog(@"SecItemAdd: noErr");
    } else {
        NSLog(@"SecItemAdd: error(%ld)", error);
    }
    return uuid;
}

@end
