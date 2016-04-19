//
//  LYBannerController.m
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import "LYBannerController.h"
#import "LYBannerView.h"
#import <SVProgressHUD.h>

@interface LYBannerController ()<LYBannerViewDelegate>
{
    LYBannerView *bannerView;
}
@property (nonatomic, strong)UIPageControl *pageView;
@end

@implementation LYBannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
}
- (void)createView{
    bannerView = [[LYBannerView alloc]initWithFrame:CGRectMake(0, 0, 375, 300)];
    //这个属性必须设置在加入数据之前
    bannerView.autoScroll = YES;
    bannerView.isInfiniteLoop = YES;
    bannerView.isPageControl = YES;
//    bannerView.autoScrollTimeInterval = 0.5;
    [bannerView reloadBannerWithBannersArray:self.banners];
    bannerView.delegate = self;
    [self.view addSubview:bannerView];
}
- (void)viewDidAppear:(BOOL)animated{
    if (self.banners.count == 0) {
        [SVProgressHUD showSuccessWithStatus:@"请设置图片"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)bannerView:(LYBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"%ld",index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
