//
//  PFLogger.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#define PNLOG_CAT_RESPONSE			true

#ifdef DEBUG

#define PFAssert(condition, msg...) NSAssert(condition, msg)
#define PFCLog(cat, ...) { if(cat) { NSLog([[NSString stringWithFormat:@"%s ", __func__]  stringByAppendingFormat:__VA_ARGS__],nil); } }

#else

#define PFAssert(...) ;
#define PFCLog(...) ;

#endif
