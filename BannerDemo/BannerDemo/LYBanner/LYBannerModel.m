//
//  LYBannerModel.m
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import "LYBannerModel.h"

@implementation LYBannerModel
+ (instancetype)bannerWithImage:(UIImage *)image{
    return [[LYBannerModel alloc]initWithImage:image];
}

+ (instancetype)bannerWithURL:(NSURL *)url {
    return [[LYBannerModel alloc] initWithURL:url];
}


- (instancetype)initWithImage:(UIImage *)image {
    if ((self = [super init])) {
        _image = image;
    }
    return self;
}

- (instancetype)initWithURL:(NSURL *)url {
    if ((self = [super init])) {
        _photoURL = [url copy];
    }
    return self;
}

@end
