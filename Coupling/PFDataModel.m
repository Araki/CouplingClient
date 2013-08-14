//
//  PFDataModel.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFDataModel.h"
#import "NSString+Extension.h"

@implementation PFDataModel
@synthesize min_version, max_version, originalDictionary;

+ (id)data
{
    return [[self alloc] init];
}

- (id)initWithDictionary:(NSDictionary*)aDic
{
	self = [super init];
	if (self != nil) {
        id min = [aDic objectForKey:@"min_version"];
        id max = [aDic objectForKey:@"max_version"];
        self.min_version = (NSString *)min != nil || [min isKindOfClass:[NSString class]] ? min : @"0.0.0";
        self.max_version = (NSString *)max != nil || [max isKindOfClass:[NSString class]] ? max : @"9999.99.99";
        self.originalDictionary = aDic;
	}
	return self;
}

+ (id)dataModelWithDictionary:(NSDictionary*)aDictionary
{
	if (aDictionary == nil) return nil;
	
	return [[[self class] alloc] initWithDictionary:aDictionary];
}

+ (NSArray*)dataModelsFromArray:(NSArray*)anArray
{
	NSMutableArray* dataModels = [NSMutableArray array];
	for (NSDictionary* dictionary in anArray) {
		id parsedObject = [self dataModelWithDictionary:dictionary];
		if (parsedObject) {
			[dataModels addObject:parsedObject];
		}
	}
	return dataModels;
}
+ (NSArray*)availableDataModelsFromArray:(NSArray*)anArray inVersion:(int)version
{
	NSMutableArray* dataModels = [NSMutableArray array];
	for (NSDictionary* dictionary in anArray) {
		PFDataModel* parsedObject = [self dataModelWithDictionary:dictionary];
		if (parsedObject && [parsedObject isAvailableInVersion:version]) {
			[dataModels addObject:parsedObject];
		}
	}
	return dataModels;
}

- (BOOL)isAvailableInVersion:(int)versionInt
{
	if (self.min_version != nil) {
		int minVersion = [min_version versionIntValue];
		if (versionInt < minVersion) return NO;
	}
	if (self.max_version != nil) {
		int maxVersion = [max_version versionIntValue];
		if (versionInt > maxVersion) return NO;
	}
	return YES;
}

@end
