//
//  NSDictionary+Extension.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

@interface NSDictionary(Extension)

- (NSString *)encodedComponentsJoinedByString:(NSString *)separator;
- (BOOL)hasObjectForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (int64_t)longLongValueForKey:(NSString *)key defaultValue:(int64_t)defaultValue;
- (float)floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;
- (BOOL)boolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (NSString *)stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

@end
