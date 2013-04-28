//
//  PFSingletonObject.m
//  Coupling
//
//  Created by tsuchimoto on 12/10/20.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "PFSingletonObject.h"

static NSMutableDictionary *_instances;/**!< this is the dictionary which manages all instance of inheritor of this class */

@implementation PFSingletonObject

+ (id)sharedObject {
	@synchronized(self) {
		if ([_instances objectForKey:NSStringFromClass(self)] == nil) {
			return [[self alloc] init];
		}
	}
	return [_instances objectForKey:NSStringFromClass(self)];
}

+ (id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if ([_instances objectForKey:NSStringFromClass(self)] == nil) {
			id instance = [super allocWithZone:zone];
			if ([_instances count] == 0) {
				_instances = [[NSMutableDictionary alloc] initWithCapacity:0];
			}
			[_instances setObject:instance forKey:NSStringFromClass(self)];
			return instance;
		}
	}
	return nil;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)releaseAllLocalObjects
{
	@synchronized(self) {
		for (id target in _instances) {
			SEL selector = @selector(releaseAllLocalObjects);
			if ([target respondsToSelector:selector]) {
				[target performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
			}
		}
	}
}

- (void)resecureAllLocalObjects
{
	@synchronized(self) {
		for (id target in _instances) {
			SEL selector = @selector(resecureAllLocalObjects);
			if ([target respondsToSelector:selector]) {
				[target performSelectorOnMainThread:selector withObject:nil waitUntilDone:YES];
			}
		}
	}
}


@end
