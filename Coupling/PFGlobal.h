//
//  PFGlobal.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#ifndef Coupling_PFGlobal_h
#define Coupling_PFGlobal_h

#define kPFEndpointBase							@"https://api.pairful.net/api/v1"


#endif


#if TARGET_IPHONE_SIMULATOR
static BOOL IsDevice = NO;
#else
static BOOL IsDevice = YES;
#endif