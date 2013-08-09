//
//  PSImageDownloader.h
//  Feed
//
//  Created by 古林 俊祐 on 2013/05/31.
//  Copyright (c) 2013年 ShunsukeFurubayashi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TMCache.h"

typedef void (^loadBlock)(UIImage *image, NSString *url, NSError *erro);

@interface PSImageDownloader : NSObject

//インスタンス生成
+ (PSImageDownloader *)sharedInstance;
+ (NSString *)urlStringToFileName:(NSString *)url;
//画像を取得
- (void)getImage:(NSString *)url onComplete:(loadBlock)complete;

@end
