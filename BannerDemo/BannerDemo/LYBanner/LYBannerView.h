//
//  LYBannerView.h
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYBannerView;
@protocol LYBannerViewDelegate <NSObject>
@optional
- (void)bannerView:(LYBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index;
@end

@interface LYBannerView : UIView
@property (nonatomic, assign)id<LYBannerViewDelegate> delegate;
/**
 *  是否无限循环
 */
@property (nonatomic, assign)BOOL isInfiniteLoop;
/**
 *  是否需要pageControl
 */
@property (nonatomic, assign)BOOL isPageControl;
/**
 *  是否实现自动滚动
 */
@property (nonatomic, assign)BOOL autoScroll;
/**
 *  滚动时间间隔
 */
@property (nonatomic, assign)float autoScrollTimeInterval;
/**
 *  将外部的图片数组传入
 */
- (instancetype)initWithFrame:(CGRect)frame Banners:(NSMutableArray *)banners;
/**
 *  将外部的图片数组传入
 */
- (void)reloadBannerWithBannersArray:(NSMutableArray *)banners;
@end
