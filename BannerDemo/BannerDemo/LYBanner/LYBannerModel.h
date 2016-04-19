//
//  LYBannerModel.h
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LYBannerModel : NSObject
@property (nonatomic, copy)NSString *caption;
@property (nonatomic, strong, readonly)UIImage *image;
@property (nonatomic, strong, readonly)NSURL *photoURL;

+ (instancetype)bannerWithImage:(UIImage *)image;
+ (instancetype)bannerWithURL:(NSURL *)url;

- (instancetype)initWithImage:(UIImage *)image;
- (instancetype)initWithURL:(NSURL *)url;
@end
