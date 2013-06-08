//
//  PFMiscUtil.h
//  Coupling
//
//  Created by tsuchimoto on 13/04/28.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//


@interface PFMiscUtil : NSObject

+ (NSString *)userAgent;
+ (NSString *)pathForBundleResource:(NSString *)resource ofType:(NSString *)type;
+ (NSString *)urlStringFromPath:(NSString *)path params:(id)params;
+ (NSString *)readUUID;
+ (NSString *)createUUID;

@end
