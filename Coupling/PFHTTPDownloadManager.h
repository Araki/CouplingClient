//
//  PFHTTPDownloadManager.h
//  Coupling
//
//  Created by tsuchimoto on 12/11/11.
//  Copyright (c) 2012年 tsuchimoto. All rights reserved.
//

#import "SingletonObject.h"
//#import "PFHTTPDownload.h"

@interface PFHTTPDownloadManager : SingletonObject {
    
}

- (void)addedOperationToQueue:(NSOperation *)downloader;
+ (PFHTTPDownloadManager *)sharedObject;

@end

@interface PFSingleLineHTTPDownloadManager : PFHTTPDownloadManager
@end