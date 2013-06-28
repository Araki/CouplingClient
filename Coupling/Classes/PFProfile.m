//
//  PFProfile.m
//  Coupling
//
//  Created by Ryo Kamei on 13/04/29.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFProfile.h"
#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"


@implementation PFProfile

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    if (self) {
        self.type               = [aDictionary stringValueForKey:@"type"            defaultValue:nil];
        self.status             = [aDictionary intValueForKey:@"status"             defaultValue:0];
        self.userId             = [aDictionary intValueForKey:@"user_id"            defaultValue:0];
        self.groupId            = [aDictionary intValueForKey:@"group_id"           defaultValue:0];
        self.nickName           = [aDictionary stringValueForKey:@"nick_name"       defaultValue:nil];
        self.introduction       = [aDictionary stringValueForKey:@"introduction"    defaultValue:nil];
        self.gender             = [aDictionary intValueForKey:@"gender"             defaultValue:0];
        self.age                = [aDictionary intValueForKey:@"age"                defaultValue:0];
        self.birthPlace         = [aDictionary intValueForKey:@"birth_place"        defaultValue:0];
        self.prefecture         = [aDictionary intValueForKey:@"prefecture"         defaultValue:0];
        self.roommate           = [aDictionary intValueForKey:@"roommate"           defaultValue:0];
        self.height             = [aDictionary intValueForKey:@"height"             defaultValue:0];
        self.proportion         = [aDictionary intValueForKey:@"proportion"         defaultValue:0];
        self.bloodType          = [aDictionary intValueForKey:@"blood_type"         defaultValue:0];
        self.marialHistory      = [aDictionary intValueForKey:@"marial_history"     defaultValue:0];
        self.marriageTime       = [aDictionary intValueForKey:@"marriage_time"      defaultValue:0];
        self.smoking            = [aDictionary intValueForKey:@"smoking"            defaultValue:0];
        self.alcohol            = [aDictionary intValueForKey:@"alcohol"            defaultValue:0];
        self.job                = [aDictionary intValueForKey:@"job"                defaultValue:0];
        self.jobDescription     = [aDictionary stringValueForKey:@"job_description" defaultValue:nil];
        self.workPlace          = [aDictionary stringValueForKey:@"work_place"      defaultValue:nil];
        self.income             = [aDictionary intValueForKey:@"income"             defaultValue:0];
        self.schoolBackGoround  = [aDictionary intValueForKey:@"school_background"  defaultValue:0];
        self.holiday            = [aDictionary intValueForKey:@"holiday"            defaultValue:0];
        self.sociability        = [aDictionary intValueForKey:@"sociability"        defaultValue:0];
        self.dislike            = [aDictionary stringValueForKey:@"dislike"         defaultValue:0];
        
        NSArray *characters = [aDictionary objectForKey:@"characters"];
        if (characters.count) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:characters.count];
            for (NSDictionary *dic in characters){
                if([dic respondsToSelector:@selector(objectForKey)])
                [array addObject:[PFMultipleProfileModel dataModelWithDictionary:dic]];
            }
            self.characters = [NSArray arrayWithArray:array];
        }
        
        NSArray *hobbies = [aDictionary objectForKey:@"hobbies"];
        if (hobbies.count) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:hobbies.count];
            for (NSDictionary *dic in hobbies){
                if([dic respondsToSelector:@selector(objectForKey)])
                [array addObject:[PFMultipleProfileModel dataModelWithDictionary:dic]];
            }
            self.hobbies = [NSArray arrayWithArray:array];
        }
        
        NSArray *specialities = [aDictionary objectForKey:@"specialities"];
        if (specialities.count) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:specialities.count];
            for (NSDictionary *dic in specialities){
                if([dic respondsToSelector:@selector(objectForKey)])
                [array addObject:[PFMultipleProfileModel dataModelWithDictionary:dic]];
            }
            self.specialities = [NSArray arrayWithArray:array];
        }
        
        NSArray *images = [aDictionary objectForKey:@"images"];
        if (images.count) {
            NSMutableArray *array = [NSMutableArray arrayWithCapacity:images.count];
            for (NSDictionary *dic in images){
                if([dic respondsToSelector:@selector(objectForKey)])
                [array addObject:[PFImageModel dataModelWithDictionary:dic]];
            }
            self.images = [NSArray arrayWithArray:array];
        }
        
        NSString *createdAtString = [aDictionary stringValueForKey:@"created_at" defaultValue:nil];
        if (createdAtString) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            self.createdAt = [dateFormatter dateFromString:createdAtString];
            NSLog(@"created at : %@", self.createdAt);
        }
        
        NSString *updatedAtString = [aDictionary stringValueForKey:@"updated_at" defaultValue:nil];
        if (updatedAtString) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            self.updatedAt = [dateFormatter dateFromString:updatedAtString];
            NSLog(@"updated at : %@", self.updatedAt);
        }
    }
    return self;
}

@end
