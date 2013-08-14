//
//  PFDataModel.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

/**
 @brief サーバーとクライアント間で通信されるモデル用のベースとなるクラス
 
 このデータモデル自体は一時オブジェクトとしての意味しかなさないため、
 Object* obj = [Object dataModelWithDictionary:hoge];
 としてautorelease行きの一時オブジェクトとして扱ってください。
 */
//#import "NSDictionary+GetterExt.h"
#import "PFLogger.h"

@interface PFDataModel : NSObject {
	NSString* min_version;
	NSString* max_version;
    NSDictionary* originalDictionary;
}

@property (nonatomic, retain) NSString* min_version;
@property (nonatomic, retain) NSString* max_version;
@property (nonatomic, retain) NSDictionary* originalDictionary;

+ (id)data;
- (id)initWithDictionary:(NSDictionary*)aDictionary;
+ (id)dataModelWithDictionary:(NSDictionary*)aDictionary;
+ (NSArray*)dataModelsFromArray:(NSArray*)anArray;
+ (NSArray*)availableDataModelsFromArray:(NSArray*)anArray inVersion:(int)version;
- (BOOL)isAvailableInVersion:(int)versionInt;

@end
