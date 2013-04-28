//
//  PFSingletonObject.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/20.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFSingletonObject : NSObject

+ (id)sharedObject;

@end
