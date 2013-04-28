//
//  PFTalkDataModel.m
//  Coupling
//
//  Created by Ryo Kamei on 13/03/30.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFTalkDataModel.h"
#import "NSDictionary+Extension.h"

@implementation PFTalkDataModel

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super init];
    if (self) {
        self.isFromUser = [aDictionary boolValueForKey:@"is_from_user" defaultValue:YES];
        self.message    = [aDictionary stringValueForKey:@"message" defaultValue:@""];
        
    }
    return self;
}

@end
