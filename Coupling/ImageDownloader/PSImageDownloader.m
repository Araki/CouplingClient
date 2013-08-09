//
//  PSImageDownloader.m
//  Feed
//
//  Created by 古林 俊祐 on 2013/05/31.
//  Copyright (c) 2013年 ShunsukeFurubayashi. All rights reserved.
//

#import "PSImageDownloader.h"

@implementation PSImageDownloader
{
    //読み込み配列
    NSMutableArray *loadArray;
}

#pragma mark - Init
+ (PSImageDownloader *)sharedInstance
{
    static PSImageDownloader *sharedInstance;
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        sharedInstance = [[PSImageDownloader alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        loadArray = [NSMutableArray arrayWithCapacity:0];
    }
    return self;
}

- (void)getImage:(NSString *)url onComplete:(loadBlock)complete
{
    
    UIImage *image = (UIImage *)[[TMCache sharedCache] objectForKey:[PSImageDownloader urlStringToFileName:url]];
    if (image != nil)
    {
        complete(image, url, nil);
        return;
    }
    
    //読み込み処理
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:0];
    [dict setObject:url forKey:@"url"];
    [dict setObject:[complete copy] forKey:@"block"];
    
    [loadArray addObject:dict];
    
    if ([loadArray count] == 1)
    {
        //読み込みへ
        [self loadImage];
    }
}

- (void)loadImage
{
    NSString *url = [[loadArray objectAtIndex:0] objectForKey:@"url"];
    loadBlock completeBlock = [[loadArray objectAtIndex:0] objectForKey:@"block"];
    
    UIImage *image = (UIImage *)[[TMCache sharedCache] objectForKey:[PSImageDownloader urlStringToFileName:url]];
    if (image != nil)
    {
        completeBlock(image, url, nil);
        return;
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        //読み込み
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSError *error = nil;
        NSData *data = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error:&error];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
            //非同期で裏でネットワークで取得
            if (error == nil)
            {
                UIImage *getImg = [UIImage imageWithData:data];
                UIImage *resizeImg = [self resizeImage:getImg];
                
                completeBlock(resizeImg, url, nil);
                
                //キャッシュに保存
                [[TMCache sharedCache] setObject:resizeImg forKey:[PSImageDownloader urlStringToFileName:url]];
            }
            else
            {
                completeBlock(nil, url, error);
            }
            [loadArray removeObjectAtIndex:0];
            if ([loadArray count] != 0)
            {
                [self loadImage];
            }
        }];
    }];
}

+ (NSString *)urlStringToFileName:(NSString *)url
{
    NSString *filename = url;
    filename = [filename stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    filename = [filename stringByReplacingOccurrencesOfString:@":" withString:@"_"];
    filename = [filename stringByReplacingOccurrencesOfString:@"?" withString:@"_"];
    filename = [filename stringByReplacingOccurrencesOfString:@"=" withString:@"_"];
    filename = [filename stringByReplacingOccurrencesOfString:@"." withString:@"_"];
    
    return filename;
}

- (UIImage *)resizeImage:(UIImage *)image
{
    //	自分が作りたい画像の大きさを決めて描画領域を作る。
	CGRect bounds = CGRectMake(0, 0, 300, 200);
	//	ボタンの内容部高さ x 0.95を最大とする。
	double wide = bounds.size.height;
	CGSize size = image.size;
	CGFloat ratio = 0;
    
    if (size.width < bounds.size.width && size.height < bounds.size.height)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
        UIGraphicsBeginImageContext(rect.size);
        [image drawInRect:rect];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    else
    {
        if (size.width > size.height)
        {
            ratio = wide / size.width;
        }
        else
        {
            ratio = wide / size.height;
        }
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
        CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
        UIGraphicsBeginImageContext(rect.size);
        [image drawInRect:rect];
        image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
        
    return image;
}

@end
