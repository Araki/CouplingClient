//
//  PFGroup.m
//  Coupling
//
//  Created by Ryo Kamei on 13/05/18.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFGroup.h"
#import "NSDictionary+Extension.h"

@implementation PFGroup

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    if (self) {
        
        self.leader = [aDictionary hasObjectForKey:@"leader"] ? [PFProfile dataModelWithDictionary:[aDictionary objectForKey:@"leader"]] : nil;
        NSArray *friendArray = [aDictionary objectForKey:@"friends"];
        if (friendArray.count) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:friendArray.count];
            for (NSDictionary *dic in friendArray){
                [array addObject:[PFFriendProfile dataModelWithDictionary:dic]];
            }
            self.friends = [NSArray arrayWithArray:array];
        }
        
        self.area           = [aDictionary stringValueForKey:@"area"            defaultValue:nil];
        self.relationship   = [aDictionary stringValueForKey:@"relationship"    defaultValue:nil];
        self.request        = [aDictionary stringValueForKey:@"request"         defaultValue:nil];
        
        self.headCount      = [aDictionary intValueForKey:@"head_count"         defaultValue:0];
        self.maxAge         = [aDictionary intValueForKey:@"max_age"            defaultValue:0];
        self.minAge         = [aDictionary intValueForKey:@"min_age"            defaultValue:0];
        self.status         = [aDictionary intValueForKey:@"status"             defaultValue:0];
        self.targetAgeRange = [aDictionary intValueForKey:@"target_age_range"   defaultValue:0];
        self.userId         = [aDictionary intValueForKey:@"user_id"            defaultValue:0];
        
        NSString *openingHourString = [aDictionary stringValueForKey:@"opening_hour" defaultValue:nil];
        if (openingHourString) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            self.openingHour = [dateFormatter dateFromString:openingHourString];
        }
    }
    return self;
}

@end
