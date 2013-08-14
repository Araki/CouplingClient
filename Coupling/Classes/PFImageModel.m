//
//  PFImageModel.m
//  Coupling
//
//  Created by Ryo Kamei on 13/05/14.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFImageModel.h"
#import "NSDictionary+Extension.h"
#import "PSImageDownloader.h"

@implementation PFImageModel

- (id)initWithDictionary:(NSDictionary *)aDictionary
{
    self = [super initWithDictionary:aDictionary];
    if (self) {
        NSString *createdAtString = [aDictionary stringValueForKey:@"created_at" defaultValue:nil];
        if (createdAtString) {
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
            self.createdAt = [dateFormatter dateFromString:createdAtString];
            NSLog(@"created at : %@", self.createdAt);
        }
        
        NSString *urlString = [aDictionary stringValueForKey:@"url" defaultValue:nil];
        if (urlString) {
            self.url = [NSURL URLWithString:urlString];
            [[PSImageDownloader sharedInstance] getImage:urlString
                                              onComplete:^(UIImage *image, NSString *url, NSError *error) {
                                                  if (error == nil)
                                                  {
                                                      if ([urlString isEqualToString:url])
                                                      {
                                                          self.image = image;
                                                      }
                                                  }
                                              }];
        }
        
        self.isMain = [[aDictionary stringValueForKey:@"is_main" defaultValue:nil] boolValue];
    }
    return self;
}

@end
