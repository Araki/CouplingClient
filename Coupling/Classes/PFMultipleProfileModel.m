//
//  PFMultipleProfileModel.m
//  Coupling
//
//  Created by Ryo Kamei on 13/05/14.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFMultipleProfileModel.h"
#import "NSDictionary+Extension.h"

@implementation PFMultipleProfileModel

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    if (self) {
        self.name = [aDictionary stringValueForKey:@"name" defaultValue:nil];
    }
    return self;
}

@end
