//
//  ApiController.h
//  Coupling
//
//  Created by 北野剛史 on 2013/06/26.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BASE_URL @"http://pairful.com/api/"

@protocol ApiControllerDelegate;
@interface ApiController : NSObject

+(id)api:(NSString *)graphPath
    andParams:(NSMutableDictionary *)params
    andHttpMethod:(NSString *)httpMethod
    andDelegate:(id <ApiControllerDelegate>)delegate;
@end

@protocol ApiControllerDelegate <NSObject>

@end
