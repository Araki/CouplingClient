//
//  PFHTTPResponse.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFHTTPResponse : NSObject

@property (strong, nonatomic) NSString *jsonString;

- (id) initWithJson:(NSString *)json;
+ (id) responseFromJson:(NSString *)json;

- (NSDictionary *)jsonDictionary;
- (BOOL)isValid;
- (BOOL)isSuccessful;
- (BOOL)isS3ErrorXML;
- (NSError *)error;

@end
