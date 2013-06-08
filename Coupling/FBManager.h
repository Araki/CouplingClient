//
//  FBManager.h
//  Coupling
//
//  Created by tsuchimoto on 12/10/28.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import "PFSingletonObject.h"

@interface FBManager : PFSingletonObject

@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) NSData *deviceToken;

-(void) closeSession;
-(BOOL) openSessionWithAllowLoginUI:(BOOL)allowLoginUI;

@end
