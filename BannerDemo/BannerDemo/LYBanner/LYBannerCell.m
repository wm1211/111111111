//
//  LYBannerCell.m
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import "LYBannerCell.h"
#import "LYBannerModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <SVProgressHUD.h>
#import <UIImageView+WebCache.h>

@interface LYBannerCell ()
{
    //整个cell的frame
    CGRect _frameRect;
}
@end
@implementation LYBannerCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameRect = frame;
        [self creatView];
    }
    return self;
}
- (void)creatView{
    self.bannerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _frameRect.size.width, _frameRect.size.height)];
    self.bannerView.userInteractionEnabled = YES;
    [self.contentView addSubview:self.bannerView];
}


#pragma mark - Image 的查找策略
- (void)reloadCellWith:(LYBannerModel*)photo
{
    
    __weak typeof(self) weakSelf = self;
    [self.loadingIndicator stopAnimating];
    
    if (photo.image) {
        [self.bannerView setImage:photo.image];
    }
    else if (photo.photoURL) {
        if ([[[photo.photoURL scheme] lowercaseString] isEqualToString:@"assets-library"]) {
            
            ALAssetsLibrary *assetslibrary = [[ALAssetsLibrary alloc] init];
            [assetslibrary assetForURL:photo.photoURL
                           resultBlock:^(ALAsset *asset){
                               ALAssetRepresentation *rep = [asset defaultRepresentation];
                               CGImageRef iref = [rep fullScreenImage];
                               if (iref) {
                                   UIImage *img = [UIImage imageWithCGImage:iref];
                                   [weakSelf.bannerView setImage:img];
                               }
                           }
                          failureBlock:^(NSError *error) {
                              
                          }];
            
        }
        else if ([photo.photoURL isFileURL]) {
            UIImage *img = [UIImage imageWithContentsOfFile:photo.photoURL.path];
            [self.bannerView setImage:img];
            
        }
        else {
            BOOL imgExists = [[SDWebImageManager sharedManager] diskImageExistsForURL:photo.photoURL];
            if (!imgExists) {
                [self.loadingIndicator startAnimating];
            }
            [self.bannerView sd_setImageWithURL:photo.photoURL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                [weakSelf.loadingIndicator stopAnimating];
                UIImage *img = (image == nil ? weakSelf.bannerView.image:image);
                
                if (img) {
                    self.bannerView.center = CGPointMake(_frameRect.size.width/2, _frameRect.size.height/2);
                } else {
                    NSLog(@"图片加载失败-----");
                }
            }];
        }
    }
}

@end
