//
//  LYBannerView.m
//  BannerDemo
//
//  Created by 刘勇航 on 16/3/28.
//  Copyright © 2016年 YongHang Liu. All rights reserved.
//

#import "LYBannerView.h"
#import "LYBannerModel.h"
#import "LYBannerCell.h"

@interface LYBannerView ()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    //当前页数
    int _currentIndex;
    //图片的frame
    CGRect _frameRect;
    //轮播图
    UICollectionView *_bannerCollertionView;
    //轮播图图片数组
    NSMutableArray *_bannersArray;
    //轮播的总页数(可能有重复的)
    int _totalItemsCount;
    //定时器
    NSTimer *_autoScrollTimer;
}
@property (nonatomic, strong)UIPageControl *pageView;
@end

@implementation LYBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _frameRect = frame;
        _totalItemsCount = 0;
        _bannersArray = [NSMutableArray array];
        self.autoScroll = NO;
        self.isInfiniteLoop = NO;
        self.autoScrollTimeInterval = 2;
        self.isPageControl = NO;
        [self createView];
    }
    return self;
}
/**
 *  将外部的图片数组传入
 */
- (instancetype)initWithFrame:(CGRect)frame Banners:(NSMutableArray *)banners
{
    self = [super initWithFrame:frame];
    if (self) {
        [self reloadBannerWithBannersArray:banners];
    }
    return self;
}
/**
 *  将外部的图片数组传入
 */
- (void)reloadBannerWithBannersArray:(NSMutableArray *)banners{
    [_bannersArray removeAllObjects];
    [_bannersArray addObjectsFromArray:banners];
    //在这里数组中才有数据
    self.pageView.numberOfPages = banners.count;
    if (self.isInfiniteLoop) {
        _totalItemsCount = (int)banners.count * 100;
    } else {
        _totalItemsCount = (int)banners.count;
    }
    [_bannerCollertionView reloadData];
}

- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    //每次设置时间计时器时，先把时间计时器清零
    if (_autoScroll) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
        //设置时间定时器
        [self setupTimer];
    }
}
/**
 *  重写setter方法，设置时间
 */
- (void)setAutoScrollTimeInterval:(float)autoScrollTimeInterval{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    //只要设置时间间隔，则自动调用设置时间定时器
    [self setAutoScroll:self.autoScroll];
}
/**
 *  若果显示pageControl则直接创建
 *
 *  @param isPageControl 是否创建pageControl
 */
- (void)setIsPageControl:(BOOL)isPageControl{
    _isPageControl = isPageControl;
    if (isPageControl) {
        _pageView = [[UIPageControl alloc]init];
        _pageView.backgroundColor = [UIColor blueColor];
        _pageView.currentPage = 0;
        _pageView.pageIndicatorTintColor = [UIColor whiteColor];
        _pageView.currentPageIndicatorTintColor = [UIColor redColor];
        self.pageView.center = CGPointMake(_frameRect.size.width/2, _frameRect.size.height - 30);
        
        [self addSubview:_pageView];
    }
}
/**
 *  创建定时器
 */
- (void)setupTimer{
    _autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:_autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    //将时间定时器加入子线程中
    [[NSRunLoop mainRunLoop] addTimer:_autoScrollTimer forMode:NSRunLoopCommonModes];
}
/**
 *  时间定时器调用的方法
 */
- (void)automaticScroll{
    if (_bannersArray.count > 1) {
        int currentIndex = _bannerCollertionView.contentOffset.x / _frameRect.size.width;
        int targateIndex = currentIndex + 1;
        //如果到了最后一页,并且回去的时候取消动画
        if (targateIndex == _totalItemsCount) {
            //如果无限滚动
            if (self.isInfiniteLoop) {
                targateIndex = _totalItemsCount * 0.5;
            }else {
                targateIndex = 0;
            }
            //直接滚动到目标item
            [_bannerCollertionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targateIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:NO];
        }
        [_bannerCollertionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targateIndex inSection:0] atScrollPosition:(UICollectionViewScrollPositionNone) animated:YES];
    }
    
}

- (void)createView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    _bannerCollertionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, _frameRect.size.width, _frameRect.size.height) collectionViewLayout:layout];
    
    _bannerCollertionView.pagingEnabled = YES;
    _bannerCollertionView.dataSource = self;
    _bannerCollertionView.delegate = self;
    _bannerCollertionView.showsHorizontalScrollIndicator = NO;
    _bannerCollertionView.backgroundColor = [UIColor clearColor];
    _bannerCollertionView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [_bannerCollertionView registerClass:[LYBannerCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_bannerCollertionView];
    
}


/**
 *  当拖动的时候，将定时器销毁
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.autoScroll) {
        [_autoScrollTimer invalidate];
        _autoScrollTimer = nil;
    }
}
/**
 *  将要减速时，创建控制器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) {
        [self setupTimer];
    }
}
/**
 *  拖拽的时候，设置当前的页码
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //如果拖动的是banner
    if (_bannerCollertionView == scrollView) {
        CGFloat pageWidth = scrollView.frame.size.width;
        int currentPage = floor((scrollView.contentOffset.x - pageWidth/2)/pageWidth) + 1;
        int indexOnPageControl = (currentPage % (int)_bannersArray.count) + 1;
        _currentIndex = indexOnPageControl - 1;
        if (self.pageView.currentPage == _currentIndex) {
            return;
        }
        [self reloadPageView];
    }
}
/**
 *  刷新底部的pageView
 */
- (void)reloadPageView{
    int sumPage = (int)_bannersArray.count;
    if (sumPage <= 1) {
        self.pageView.hidden = YES;
    }
    self.pageView.currentPage = _currentIndex;
}

#pragma mark - collerctionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    int row = 0;
    row = _totalItemsCount;
    return row;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return _frameRect.size;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    int itemIndex = indexPath.item % (int)_bannersArray.count;
    LYBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    LYBannerModel *model = nil;
    model = [_bannersArray objectAtIndex:itemIndex];
    [cell reloadCellWith:model];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    int row = indexPath.item % (int)_bannersArray.count;
    if ([self.delegate respondsToSelector:@selector(bannerView:didSelectItemAtIndex:)]) {
        [self.delegate bannerView:self didSelectItemAtIndex:row];
    }
}

@end
