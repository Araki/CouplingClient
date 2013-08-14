//
//  PFImageModel.h
//  Coupling
//
//  Created by Ryo Kamei on 13/05/14.
//  Copyright (c) 2013年 tsuchimoto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PFImageModel : PFDataModel

@property (nonatomic, assign) NSDate *      createdAt;
@property (nonatomic, assign) BOOL          isMain;
@property (nonatomic, assign) NSURL *       url;
@property (nonatomic, strong) UIImage *     image;

@end
