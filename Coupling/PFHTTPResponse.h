//
//  PFHTTPResponse.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFHTTPResponse : NSObject

@property (nonatomic, retain) NSString *jsonString;
@property (readonly) BOOL isSuccessful;
@property (readonly) NSDictionary *jsonDictionary;
@property (readonly) NSError *error;

+ (id) responseFromJson:(NSString *)json;

@end
