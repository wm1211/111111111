//
//  LYBannerController.h
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYBannerController : UIViewController
/**
 *  图片的数组
 */
@property (nonatomic, strong)NSMutableArray *banners;
/**
 *  当前的image
 */
@property (nonatomic, assign)int currentImgIndex;

@end
