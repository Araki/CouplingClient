//
//  PFHTTPRequestHelper.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PFHTTPResponse.h"
//#import "PFAPIHTTPDefinition.h"

typedef enum {
	kPNHTTPRequestCommandGET  =  0x00000001 << 0,
	kPNHTTPRequestCommandPOST =  0x00000001 << 1
} kPNHTTPRequestCommand;

@interface PFHTTPRequestHelper : NSObject {
	
}
+ (NSString*)urlStringFromCommand:(NSString *)command
                           params:(id)params;

+ (NSString*)urlStringFromPath:(NSString *)path
                        params:(id)params;

+ (void)requestWithCommand:(NSString *)command
				 onSuccess:(void (^)(PFHTTPResponse *response))onSuccess
				 onFailure:(void (^)(NSError *error))onFailure;

+ (void)requestWithCommand:(NSString *)command
					params:(NSDictionary *)params
				 onSuccess:(void (^)(PFHTTPResponse *response))onSuccess
				 onFailure:(void (^)(NSError *error))onFailure;

//+ (void)postWithCommand:(NSString *)command params:(NSDictionary *)params
//              onSuccess:(void (^)(PFHTTPResponse *response))onSuccess
//              onFailure:(void (^)(NSError *error))onFailure;

@end
