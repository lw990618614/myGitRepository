//
//  HomeViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//
#define IMAGE_COUNT  5
#define IMAGE_HEIGHT 160
#import "HomeViewController.h"
#import "YMHomeCollectionViewCell.h"
#import "YMDetailProductionController.h"
#import "YMRuleController.h"
#import "YMHomeCell.h"
#import "HomeManager.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UIScrollView *addScrollView;//广告滚动
    UIPageControl *pageControl;//广告控制器
    UIView *firstHeaderView;
    UILabel *firstLabel;
    UIView *secondeHeaderView;
    UILabel *secondLabel;
    NSArray *dataArray;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer *timer;
@end


@implementation HomeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"一元购";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开奖规则" style:UIBarButtonItemStylePlain target:self action:@selector(RightButtonClick)];

    
    [self addTheAdvertisement];
    
    firstHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(-1, 0, kWIDTH+2, 40)];
    firstHeaderView.layer.borderColor = [UIColor grayColor].CGColor;
    firstHeaderView.layer.borderWidth = 1;
    firstLabel = [UILabel labelWithFrame:firstHeaderView.bounds textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    firstLabel.text=@"  公告：恭喜136****3434 中奖 iHone6s";
    [firstHeaderView addSubview:firstLabel];

    secondeHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(-1, 0, kWIDTH+2, 40)];
    secondeHeaderView.layer.borderColor = [UIColor grayColor].CGColor;
    secondeHeaderView.layer.borderWidth = 1;
    secondLabel = [UILabel labelWithFrame:secondeHeaderView.bounds textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    secondLabel.text= @"  热门商品";
    [secondeHeaderView addSubview:secondLabel];

    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.headerReferenceSize = CGSizeMake(kWIDTH, 40);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-66-44) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, 0, 0, 0);
    [self.view addSubview:self.collectionView];
    [self.collectionView addSubview:addScrollView];

    [self.collectionView registerClass:[YMHomeCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    [self.collectionView registerClass:[YMHomeCell class] forCellWithReuseIdentifier:@"homeCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeridentifier"];
    [self loadData];
}


#pragma mark -- UIUICollectionViewDataSource & UIUICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return 3;
    }else{
        return 5;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kWIDTH/3.0, 150);
    }else{
        return CGSizeMake(kWIDTH/2.0, 150);
    }
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * homeCell = @"homeCell";
        YMHomeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCell forIndexPath:indexPath];
        cell = [cell configWithMode];
        return cell;

    }else{
        static NSString * CellIdentifier = @"CollectionCell";
        YMHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell = [cell configWithMode];
        return cell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [_collectionView
                                          dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                          withReuseIdentifier:@"headeridentifier"
                                          forIndexPath:indexPath];
        if (indexPath.section == 0) {
            [headerView addSubview:firstHeaderView];
        }else{
            [headerView addSubview:secondeHeaderView];
        }
        reusableview = headerView;
    }
    return reusableview;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YMDetailProductionController *controller = [[YMDetailProductionController alloc] init];
    controller.state =@"1";
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}
-(void)addTheAdvertisement
{
    addScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -IMAGE_HEIGHT , kWIDTH, IMAGE_HEIGHT)];
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
    addScrollView.delegate = self;
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
    [addScrollView addSubview:pageControl];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)RightButtonClick
{
    YMRuleController *controller = [[YMRuleController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)loadData
{
 [[HomeManager sharedManager] homeStatusWithModlecompletion:^(id result, NSInteger statusCode, NSString *msg) {
     NSLog(@"你好");
 }];
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
