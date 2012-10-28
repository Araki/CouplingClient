//
//  NSString+Extension.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)serializeIntoHexidecimal:(NSData *)data;
- (NSData *)decodeFromHexidecimal;
- (NSString *)encrypt:(NSString *)key;
- (NSString *)decrypt:(NSString *)key;
- (NSString *)substringBetweenPrefix:(NSString *)prefix andSuffix:(NSString *)suffix;
- (BOOL)containsString:(NSString *)stringToFind;
- (NSString *)encodeEscape;
- (int)versionIntValue;
- (NSString *)firstCharacterCapitalizedString;
- (NSString *)stringByReplacingInvalidJSONString;

@end