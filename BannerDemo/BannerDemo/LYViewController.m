//
//  LYViewController.m
//  BannerDemo
//
//  Created by 刘勇航 on 16/4/1.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import "LYViewController.h"
#import "LYBanner/LYBannerController.h"
#import "LYBannerModel.h"

@implementation LYViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 100, 30);
    [btn setTitle:@"查看轮播图" forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(showBanners:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)showBanners:(id)sender
{
    LYBannerController *vc = [LYBannerController new];
    NSMutableArray * bigImgArray = [NSMutableArray new];
    
    [bigImgArray addObject:[LYBannerModel bannerWithImage:[UIImage imageNamed:@"test0.jpg"]]];
    [bigImgArray addObject:[LYBannerModel bannerWithImage:[UIImage imageNamed:@"test1.jpg"]]];
    [bigImgArray addObject:[LYBannerModel bannerWithImage:[UIImage imageNamed:@"test2.jpg"]]];
    [bigImgArray addObject:[LYBannerModel bannerWithURL:[NSURL URLWithString:@"http://img4.duitang.com/uploads/item/201408/30/20140830185433_FnJLA.jpeg"]]];
    [bigImgArray addObject:[LYBannerModel bannerWithURL:[NSURL URLWithString:@"http://img161.poco.cn/mypoco/myphoto/20100424/19/53310080201004241856521800459127582_005.jpg"]]];
    [bigImgArray addObject:[LYBannerModel bannerWithURL:[NSURL URLWithString:@"http://s4.sinaimg.cn/middle/5db29a99h70e7bb8abe33&690"]]];
    
    vc.currentImgIndex = 0;
    vc.banners = bigImgArray;
    
    [self presentViewController:vc animated:YES completion:nil];
}


@end
