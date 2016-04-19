//
//  LYBannerCell.h
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYBannerModel.h"

@interface LYBannerCell : UICollectionViewCell
/**
 *  转动的菊花
 */
@property (nonatomic, strong)UIActivityIndicatorView *loadingIndicator;
/**
 *  轮播图中放置的图片
 */
@property (nonatomic, strong)UIImageView *bannerView;
/**
 *  将模型数据传入数组
 *
 *  @param photo 模型参数
 */
- (void)reloadCellWith:(LYBannerModel*)photo;
@end
