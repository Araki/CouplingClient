//
//  ApiController.m
//  Coupling
//
//  Created by 北野剛史 on 2013/06/26.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "ApiController.h"

@implementation ApiController

+(id)api:(NSString *)graphPath
andParams:(NSMutableDictionary *)params
andHttpMethod:(NSString *)httpMethod
andDelegate:(id <ApiControllerDelegate>)delegate
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BASE_URL,graphPath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    if(httpMethod != Nil) {
        NSArray *keys = [params allKeys];
        NSMutableString *param = [NSMutableString new];
        for (int i = 0; i < [keys count]; i++) {
            [param appendFormat:@"%@=%@",[keys objectAtIndex:i],[params objectForKey:[keys objectAtIndex:i]]];
            if(i != [keys count] - 1)
                [param appendString:@"&"];
        }
        [request setHTTPMethod:httpMethod];
        [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
    }
    NSData *json_data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSError *error=nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:json_data options:NSJSONReadingAllowFragments error:&error];
    return jsonObject;
}
@end
