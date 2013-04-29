//
//  NSDictionary+MultiPartFormData.h
//  Coupling
//
//  Created by tsuchimoto on 13/04/29.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MultiPartFormData)

- (NSData *)multiPartFormDataRepresentationWithBoundary:(NSString *)boundary;
- (NSData *)multiPartFormDataRepresentationForAmazonWithBoundary:(NSString *)boundary;

@end
