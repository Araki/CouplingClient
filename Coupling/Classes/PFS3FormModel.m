//
//  PFS3FormModel.m
//  Coupling
//
//  Created by Ryo kamei on 2013/08/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFS3FormModel.h"
#import "NSDictionary+Extension.h"

@implementation PFS3FormModel

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    if (self) {
        self.status          = [[aDictionary stringValueForKey:@"status"        defaultValue:@"no"] boolValue];
        self.bucketName      = [aDictionary stringValueForKey:@"bucket_name"    defaultValue:nil];
        
        NSDictionary *fields = [aDictionary objectForKey:@"fields"];
        if (![fields isKindOfClass:[NSNull class]]) {
            self.accessKeyId    = [fields stringValueForKey:@"AWSAccessKeyId"   defaultValue:nil];
            self.key            = [fields stringValueForKey:@"key"              defaultValue:nil];
            self.policy         = [fields stringValueForKey:@"policy"           defaultValue:nil];
            self.signature      = [fields stringValueForKey:@"signature"        defaultValue:nil];
            self.acl            = [fields stringValueForKey:@"acl"              defaultValue:nil];
            self.secretKey      = [fields stringValueForKey:@"secretKey"        defaultValue:nil];
        }
        
    }
    return self;
}

@end
