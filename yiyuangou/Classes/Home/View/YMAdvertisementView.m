//
//  YMAdvertisementView.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMAdvertisementView.h"
#define IMAGE_COUNT  5
#define IMAGE_HEIGHT 160
@interface YMAdvertisementView()
{
    UIScrollView *addScrollView;//广告滚动
    UIPageControl *pageControl;//广告控制器
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer *timer;
@end
@implementation YMAdvertisementView
-(UIView *)advertisementView
{
    
    UIScrollView *scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 160)];
    for (int i = 0 ; i < IMAGE_COUNT; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, IMAGE_HEIGHT)];
        NSString *iconName = [NSString stringWithFormat:@"img_%02d", i + 1];
        imageView.image = [UIImage imageNamed:iconName];
        [scollView addSubview:imageView];
    }
    scollView.contentSize = CGSizeMake(IMAGE_COUNT *kWIDTH, 0);
    scollView.showsHorizontalScrollIndicator = NO;
    scollView.showsVerticalScrollIndicator = NO;
    scollView.pagingEnabled = YES;
    scollView.delegate = self;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scollView.frame.size.height - 30 , kWIDTH, 40)];
    pageControl.numberOfPages = IMAGE_COUNT;
    
    //设置时间定时器
    [self setTheTimer];
    UIView *adView = [[UIView alloc] initWithFrame:scollView.bounds];
    [adView addSubview:scollView];
    return adView;
}
-(void)addTheAdvertisement
{
    addScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, IMAGE_HEIGHT)];
    for (int i = 0 ; i < IMAGE_COUNT; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, IMAGE_HEIGHT)];
        NSString *iconName = [NSString stringWithFormat:@"img_%02d", i + 1];
        imageView.image = [UIImage imageNamed:iconName];
        [addScrollView addSubview:imageView];
    }
    addScrollView.contentSize = CGSizeMake(IMAGE_COUNT *kWIDTH, 0);
    addScrollView.showsHorizontalScrollIndicator = NO;
    addScrollView.showsVerticalScrollIndicator = NO;
    addScrollView.pagingEnabled = YES;
//    addScrollView.delegate = self;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, addScrollView.frame.size.height - 30 , kWIDTH, 40)];
    pageControl.numberOfPages = IMAGE_COUNT;
    
    //设置时间定时器
    [self setTheTimer];
}
-(void)nextImage
{
    NSInteger page = 0;
    if (pageControl.currentPage == 4) {
        page = 0;
    }else{
        page = pageControl.currentPage+1;
    }
    //改变当前的图片
    CGPoint  offset = addScrollView.contentOffset;
    offset.x  = page * kWIDTH;
    pageControl.currentPage = page;
    [addScrollView setContentOffset:offset animated:YES];
}

#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = (scrollView.contentOffset.x +kWIDTH * 0.5)/kWIDTH;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setTheTimer];
}
-(void)setTheTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [self addSubview:pageControl];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
