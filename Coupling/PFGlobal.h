//
//  PFGlobal.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#ifndef Coupling_PFGlobal_h
#define Coupling_PFGlobal_h

//#define kPFEndpointBase							@"https://api.pairful.net/api"
#define kPFEndpointBase							@"http://api-staging1.pairful.net/api"
//#define kPFEndpointBase							@"http://0.0.0.0:3000/api"

#endif


#if TARGET_IPHONE_SIMULATOR
static BOOL IsDevice = NO;
#else
static BOOL IsDevice = YES;
#endif