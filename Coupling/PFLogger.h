//
//  PFLogger.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#define PFLOG_CAT_RESPONSE			true
#define PFLOG_CAT_MODEL_PARSER      true
#define PFLOG_CAT_HTTP_REQUEST      true




#ifdef DEBUG

#define PFAssert(condition, msg...) NSAssert(condition, msg)
#define PFCLog(cat, ...) { if(cat) { NSLog([[NSString stringWithFormat:@"%s ", __func__]  stringByAppendingFormat:__VA_ARGS__],nil); } }

#else

#define PFAssert(...) ;
#define PFCLog(...) ;

#endif
