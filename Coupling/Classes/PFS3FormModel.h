//
//  PFS3FormModel.h
//  Coupling
//
//  Created by Ryo kamei on 2013/08/13.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import "PFDataModel.h"

@interface PFS3FormModel : PFDataModel

@property (nonatomic, assign) BOOL    status;
@property (nonatomic, copy) NSString *bucketName;
@property (nonatomic, copy) NSString *accessKeyId;
@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *policy;
@property (nonatomic, copy) NSString *signature;
@property (nonatomic, copy) NSString *acl;
@property (nonatomic, copy) NSString *secretKey;
@end
