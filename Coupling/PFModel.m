//
//  PFModel.m
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFModel.h"
#import "NSString+Extension.h"

@implementation PFModel
@synthesize maxVersion, minVersion;

- (id) init
{
	self = [super init];
	if (self != nil) {
		minVersion = 0;
		maxVersion = 99999999;
	}
	return self;
}

- (id) initWithDataModel:(PFDataModel *)dataModel
{
	self = [self init];
	if (self != nil) {
		if (dataModel.max_version != nil){
			maxVersion			= [dataModel.max_version versionIntValue];
		}
		if (dataModel.min_version != nil){
			minVersion			= [dataModel.min_version versionIntValue];
		}
	}
	return self;
}

+ (id) modelFromDataModel:(PFDataModel *)dataModel
{
	return [[self alloc] initWithDataModel:dataModel];
}

+ (NSArray*) modelsFromDataModels:(NSArray *)dataModels
{
	NSMutableArray* models = [NSMutableArray array];
	for (PFDataModel* dataModel in dataModels) {
		[models addObject:[self modelFromDataModel:dataModel]];
	}
	return models;
}

+ (NSArray*) modelsFromDataModels:(NSArray *)dataModels availableInVersion:(int)versionNumber
{
	NSMutableArray* models = [NSMutableArray array];
	for (PFDataModel* dataModel in dataModels) {
		PFModel* model = [self modelFromDataModel:dataModel];
		if ([model isAvailable:versionNumber]) {
			[models addObject:[self modelFromDataModel:dataModel]];
		}
	}
	return models;
}

- (BOOL) isAvailable:(int)currentVersionInt
{
	if (minVersion > currentVersionInt) return NO;
	if (maxVersion < currentVersionInt) return NO;
	
	return YES;
}

@end
