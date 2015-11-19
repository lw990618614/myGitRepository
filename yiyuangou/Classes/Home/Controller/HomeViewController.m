//
//  HomeViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//
#define IMAGE_COUNT  5
#define IMAGE_HEIGHT 155
#import "HomeViewController.h"
#import "YMHomeCollectionViewCell.h"
#import "YMDetailProductionController.h"
#import "YMRuleController.h"
#import "YMHomeCell.h"
#import "HomeManager.h"
#import "YMHomeResult.h"
#import "RewardViewController.h"
#import "YMOrderView.h"
#import "YMPayController.h"
#import "YMNotifiyController.h"
#import "YMOrderResult.h"
#import "GoodsInfomation.h"
#import "YMInfoCenter.h"
#import "YMRefreshResult.h"
#import "CBAutoScrollLabel.h"
#import "LSPaoMaView.h"
#import "YMCarResult.h"
#import "MyCarManager.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
#import "YMReceiveListController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,YMOrderViewDelegate,HomeCellDelegate,homeCollectionViewCellDelegate,UIAlertViewDelegate>
{
    UIView *headScrollView;
    UIScrollView *addScrollView;//广告滚动
    UIPageControl *pageControl;//广告控制器
    UIPageControl *attention;//广告控制器
    
    UIView *firstHeaderView;
    UILabel *noticeLable;
    UIView *secondeHeaderView;
    UIView *backView;
    UILabel *secondLabel;
    NSMutableArray *hotListArray;
    NSMutableArray *flowListArray;
    NSMutableArray *imageArray;
    NSMutableArray *messageArray;//公告栏数组
    NSMutableArray *lotteryArray;
    NSInteger allCount;
    NSMutableArray *selctCarArray;
    YMOrderResult *order;
}
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)HomeFlowList * model;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,assign)BOOL isHiden;

@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)YMOrderView *orderView;
@property (nonatomic,assign)NSInteger pageNumber;

@property (nonatomic,assign)BOOL  isShowlucky;
@property (nonatomic,assign)BOOL  isshow;
@property (nonatomic,copy)NSString *productionName;
@property (nonatomic,copy)NSString *grPeriod;//中奖期号

@property (nonatomic,strong)NSTimer *attentiontimer;
@property (nonatomic,strong)UIScrollView  *attentionSrollView;
@end


@implementation HomeViewController
-(YMOrderView *)orderView{
    if (_orderView == nil) {
        _orderView  = [[YMOrderView alloc] initWithFrame:CGRectMake(0, kHEIGHT, kWIDTH, 385) withModel:order.left];
        NSLog(@"%ld",order.left);
        _orderView.delegate = self;
    }
    return _orderView;
}
-(void)viewWillDisappear:(BOOL)animated
{
    self.isshow = NO;
    [super viewWillDisappear:animated];
    self.collectionView.userInteractionEnabled = YES;
    [self.orderView removeFromSuperview];
    self.orderView = nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.isshow = YES;
    [super viewWillAppear:animated];
    [self loadData];
}
-(UIScrollView *)attentionSrollView
{
    if (_attentionSrollView == nil) {
        _attentionSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, kWIDTH - 40, 22.5)];
    }
    return _attentionSrollView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"99夺宝";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开奖规则" style:UIBarButtonItemStylePlain target:self action:@selector(RightButtonClick)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], UITextAttributeFont, [UIColor colorWithHex:@"#FFD1D1"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    [self makeThefirstView];
    
    hotListArray = [[NSMutableArray alloc] init];
    flowListArray = [[NSMutableArray alloc] init];
    imageArray = [[NSMutableArray alloc] init];
    messageArray = [[NSMutableArray alloc] init];
    lotteryArray = [[NSMutableArray alloc] init];
    
    secondeHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 51)];
    secondLabel = [UILabel labelWithFrame:CGRectMake(-1, 10, kWIDTH+2, 41) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
    secondLabel.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
    secondLabel.layer.borderWidth = 1;
    secondLabel.text= @"   热门商品";
    secondLabel.backgroundColor = [UIColor whiteColor];
    secondLabel.font = [UIFont systemFontOfSize:16];
    secondeHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [secondeHeaderView addSubview:secondLabel];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-66-48) collectionViewLayout:layout];
    self.collectionView.backgroundColor  =  [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    self.collectionView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, 0, 0, 0);
    [self.view addSubview:self.collectionView];
//    [self.collectionView addSubview:addScrollView];
    
    [self.collectionView registerClass:[YMHomeCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    [self.collectionView registerClass:[YMHomeCell class] forCellWithReuseIdentifier:@"homeCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeridentifier"];
    
    SAFE;
    self.collectionView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [weakSelf addMoreHotstatus];
        [weakSelf.collectionView.footer endRefreshing];
    }];
}

#pragma mark -- UIUICollectionViewDataSource & UIUICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return hotListArray.count||flowListArray.count?2:0;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        if (flowListArray.count == 0) {
            return lotteryArray.count;
        }
        return flowListArray.count;
    }else{
        return hotListArray.count;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(kWIDTH/3.0, 140);
    }else{
        return CGSizeMake(kWIDTH/2.0, 160);
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    CGSize size={kWIDTH,73.5 - 22.5};
    if (section == 1) {
        size = CGSizeMake(kWIDTH, 51);
    }
    return size;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString * homeCell = @"homeCell";
        YMHomeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:homeCell forIndexPath:indexPath];
        cell.delegate = self;
        cell.row = indexPath.row;
        cell.delegate = self;

        if (flowListArray.count) {
            HomeFlowList *flowList = flowListArray[indexPath.row];
            cell = [cell configWithMode:flowList];
            return cell;

        }else{
            YMHomelotteryList *flowList = lotteryArray[indexPath.row];
            cell = [cell configWithMode:flowList];
            return cell;
        }
        
    }else{
        static NSString * CellIdentifier = @"CollectionCell";
        YMHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.delegate = self;
        HomeHotList *hotList = hotListArray[indexPath.row];
        cell.middleView.hidden = indexPath.item%2;
        cell = [cell configWithMode:hotList];
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
    [self setHidesBottomBarWhenPushed:YES];
    if (indexPath.section == 1) {
        HomeHotList *hotlist =  hotListArray[indexPath.row];
        controller.gid = hotlist.gid;
        controller.gsid = hotlist.gsid;
    }else{
        if (flowListArray.count == 0) {
            YMHomelotteryList *hotlist =  lotteryArray[indexPath.row];
            controller.gid = hotlist.gid;
            controller.gsid = hotlist.gsid;
        }else{
            HomeFlowList *hotlist =  flowListArray[indexPath.row];
            controller.gid = hotlist.gid;
            controller.gsid = hotlist.gsid;
        }
    }
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
    
}
#pragma mark -- 广告图片轮播

-(void)addTheAdvertisement
{
    addScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , kWIDTH, IMAGE_HEIGHT -22.5)];
    addScrollView.bounces = NO;
//    [self.collectionView addSubview:addScrollView];
    for (int i = 0 ; i < imageArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, IMAGE_HEIGHT)];
        
        imageView.tag= 666+i;
        HomeBannerList *list = imageArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:list.url] placeholderImage:placeHolder];
//        imageView.contentMode =  UIViewContentModeScaleAspectFill;
//        [imageView setClipsToBounds:YES];

        UITapGestureRecognizer *buygesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:buygesture];
        
        [addScrollView addSubview:imageView];
    }
    addScrollView.contentSize = CGSizeMake(imageArray.count *kWIDTH, 0);
    addScrollView.showsHorizontalScrollIndicator = NO;
    addScrollView.showsVerticalScrollIndicator = NO;
    addScrollView.pagingEnabled = YES;
    addScrollView.delegate = self;
    addScrollView.tag = 1;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, -50 , kWIDTH, 10)];
    pageControl.numberOfPages = imageArray.count;
    
    attention = [[UIPageControl alloc] initWithFrame:CGRectZero];
    attention.numberOfPages = imageArray.count;

    headScrollView = [[UIView alloc] initWithFrame:CGRectMake(0, -IMAGE_HEIGHT , kWIDTH, IMAGE_HEIGHT)];
    [headScrollView  addSubview:addScrollView];
    headScrollView.backgroundColor = [UIColor whiteColor];
    [self.collectionView addSubview:headScrollView];
    
    self.attentionSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, addScrollView.tmri_bottom, kWIDTH, 22.5)];
    
    
    for (int i = 0 ; i < messageArray.count; i ++) {
        
        UILabel *label = [UILabel labelWithFrame:CGRectMake(40, i *22.5, kWIDTH, 22.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
        
        HomeRewardList *list = messageArray[i];
        label.text = [NSString stringWithFormat:@"恭喜%@在第%ld期夺宝中获得%@一台",@"angele",list.grPeriod?list.grPeriod:12,list.name];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *buygesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        NSLog(@"%@",NSStringFromCGRect(label.frame));
//        [label addGestureRecognizer:buygesture];
        NSLog(@"%ld",messageArray.count);
        [self.attentionSrollView addSubview:label];
    }

    UIImageView *labaiamge  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 12, 10)];
    labaiamge.image = [UIImage imageNamed:@"bugle"];
    
    labaiamge.centerY = self.attentionSrollView.centerY;
    [headScrollView addSubview:labaiamge];
    
    self.attentionSrollView.contentSize = CGSizeMake(0, 22.5*messageArray.count);
    self.attentionSrollView.showsHorizontalScrollIndicator = NO;
    self.attentionSrollView.showsVerticalScrollIndicator = NO;
    self.attentionSrollView.pagingEnabled = YES;
    self.attentionSrollView.delegate = self;
    self.attentionSrollView.tag = 2;
//    attention = [[UIPageControl alloc] initWithFrame:cgsiz];
    pageControl.numberOfPages = imageArray.count;
    attention.numberOfPages = messageArray.count;
    
    [headScrollView addSubview:self.attentionSrollView];
    
    //设置时间定时器
    [self setTheTimer];
}
-(void)nextImage
{
    NSInteger page = 0;
    if (pageControl.currentPage == imageArray.count -1) {
        page = 0;
    }else{
        page = pageControl.currentPage+1;
    }
    CGPoint  offset = addScrollView.contentOffset;
    offset.x  = page * kWIDTH;
    pageControl.currentPage = page;
    [addScrollView setContentOffset:offset animated:YES];
}

#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    pageControl.currentPage = (scrollView.contentOffset.x +kWIDTH * 0.5)/kWIDTH;
    attention.currentPage = (scrollView.contentOffset.y +kWIDTH * 0.5)/kWIDTH;
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    self.attentiontimer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(nextMessge) userInfo:nil repeats:YES];
    [self.collectionView addSubview:pageControl];
    [self.collectionView addSubview:attention];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    [[NSRunLoop currentRunLoop] addTimer:self.attentiontimer forMode:NSRunLoopCommonModes];
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
    SAFE;
    [self.view makeToastActivity:kLoadingText];
    [[HomeManager sharedManager] homeStatusWithPage:self.pageNumber completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            YMHomeResult *homeResult= result;
            flowListArray = homeResult.flowList;
            hotListArray = homeResult.hotList;
            imageArray  = homeResult.bannerList;
            messageArray  = homeResult.rewardList;
            lotteryArray = homeResult.lotteryList;
            
            for (HomeFlowList *list in flowListArray) {
                if (list.left > 60*60*1000 - 6000) {
                    list.showPhone = YES;
                }
            }
       
            [[NSNotificationCenter defaultCenter]postNotificationName:TIME_RELOAD object:nil];
            if (!weakSelf.isAdd) {
                weakSelf.isAdd = YES;
                weakSelf.collectionView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    [weakSelf loadData];
                    [weakSelf.collectionView.header endRefreshing];
                }];
                [weakSelf addTheAdvertisement];
            }
            [weakSelf.collectionView reloadData];
            if (self.isshow&& homeResult.grPeriod.length&&homeResult.grName&&![homeResult.grName isEqualToString:self.productionName]&&self.isShowlucky == NO&&![self.grPeriod isEqualToString:homeResult.grPeriod]) {
                NSString *messageStr = [NSString stringWithFormat:@"您成为宝物%@ 第%@期的幸运儿",homeResult.grName,homeResult.grPeriod];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"恭喜您中奖了!" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上领奖", nil];
                self.isShowlucky = YES;
                self.productionName = homeResult.grName;
                self.grPeriod = homeResult.grPeriod;
                [alterView show];
            }

        }else {
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)makeThefirstView
{
    firstHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 73.5 - 22.5)];
    firstHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIView * lineView1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 1)];
    lineView1.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [firstHeaderView addSubview:lineView1];

    UIView *bottonView  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWIDTH, 41)];
    bottonView.backgroundColor = [UIColor whiteColor];
    [firstHeaderView addSubview:bottonView];
    
    UIView * lineView2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 1)];
    lineView2.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [firstHeaderView addSubview:lineView2];
    
    UIView * lineView3  = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kWIDTH, 1)];
    lineView3.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [bottonView addSubview:lineView3];
    
    UILabel *firstLable = [UILabel labelWithFrame:CGRectMake(10, 0, 100, 41) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
    firstLable.text = @"即将揭晓";
    firstLable.font = [UIFont systemFontOfSize:16];
    [bottonView addSubview:firstLable];
    
    UILabel *secondeLable = [UILabel labelWithFrame:CGRectMake(kWIDTH - 110, 0, 100, 41) textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHex:@"#999999"]];
    secondeLable.text = @"查看全部 >";
    secondeLable.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(checkClick)];
    [secondeLable addGestureRecognizer:gesture];
    [bottonView addSubview:secondeLable];
}
-(void)imageViewClick:(UITapGestureRecognizer *)imageView
{
    HomeBannerList *list =  imageArray[imageView.view.tag - 666];
    YMDetailProductionController *controller = [[YMDetailProductionController alloc] init];
    controller.gid = list.gid;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    YMReceiveListController *controller = [[YMReceiveListController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)checkClick
{
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
    [tabbar setSelectedIndex:1];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
#pragma mark YMOrderViewDelegate
-(void)orderButtonClickWith:(id)data
{
    YMOrderResult *order = data;
    if ([YMInfoCenter userID]) {
        YMCarInfo *carinfo = [[YMCarInfo alloc] init];
        carinfo.buyCount = order.buyCount;
        carinfo.gsid =order.gsid;
        selctCarArray = [[NSMutableArray alloc] init];
        [selctCarArray addObject:carinfo];
        YMPayController *controller = [[YMPayController alloc] init];
        controller.backstring = self.title;
        controller.selectedArray = selctCarArray;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];

    }else{
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
    }
}
-(void)cancelButtonClick
{
    [self performSelector:@selector(removeView) withObject:nil afterDelay:0.25f];
}
-(void)removeView{
    self.collectionView.userInteractionEnabled = YES;
    [self.orderView removeFromSuperview];
    self.orderView = nil;
}

#pragma mark -- HomeCellDelegate

-(void)timedownDidEnd:(YMHomeCell *)cell
{
    [self reloadDataWith:cell];
}
-(void)reloadDataWith:(YMHomeCell*)cell
{
    __weak typeof(self) weakSelf = self;
    NSIndexPath *index = [NSIndexPath indexPathForRow:cell.row inSection:0];
    HomeFlowList *model = flowListArray[index.row];
    
    [CATransaction begin];
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager] homeRefreshCellStatusWithModle:model.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            YMRefreshResult *re = result;
            for (HomeFlowList *list in flowListArray) {
                if (list.gsid == model.gsid) {
                    list.phone =re.phone;
                    list.sname = re.sname;
                    list.showPhone = YES;
                }
            }
            [weakSelf.collectionView reloadItemsAtIndexPaths:@[index]];
            if (re.uid == [YMInfoCenter userID]&&self.isshow) {
                NSString *messageStr = [NSString stringWithFormat:@"您成为宝物%@\n第%@期的幸运儿",model.name,re.period];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"恭喜您中奖了!" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上领奖", nil];
                self.productionName = model.name;
                self.grPeriod = re.period;
                [alterView show];
            }
            
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
    [CATransaction commit];
}
-(void)buyViewclick:(YMHomeCollectionViewCell *)cell
{
    NSIndexPath *path = [self.collectionView indexPathForCell:cell];
    HomeHotList *model = hotListArray[path.row];
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager] homeBuyStatusWithGsid:model.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            order = result;
            if (order.left <1) {
                [weakSelf.view makeToast:@"该商品已经卖完,或者其他客户\n处于购买状态,请稍后购买"];
                return ;
            }

            [weakSelf makeTheAltView];
             weakSelf.collectionView.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.25f animations:^{
                weakSelf.orderView.tmri_top = kHEIGHT - 385-49;
            } completion:nil];
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)carViewclick:(YMHomeCollectionViewCell *)model
{
    NSIndexPath *path = [self.collectionView indexPathForCell:model];
    HomeHotList *detailResult = hotListArray[path.row];
    [self.view makeToastActivity:kLoadingText];
    SAFE;
    if ([YMInfoCenter userID]) {
        [[HomeManager sharedManager] AddGoodsToCarStatusWithGid:detailResult.gid andGsid:detailResult.gsid andUid:[YMInfoCenter userID] completion:^(id result, NSInteger statusCode, NSString *msg) {
            [weakSelf.view hideToastActivity];
            if (statusCode == 0) {
            [[NSNotificationCenter defaultCenter]postNotificationName:CAR_ISCHANGE object:nil];
                [weakSelf.view makeToast:msg];
            }else if (statusCode == 6){
                [weakSelf.view makeToast:msg];
            }else{
                [weakSelf.view makeToast:msg];
            }
        }];
    }else{
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
    }
}
//-(void)ui
-(void)addMoreHotstatus
{
    [self.view makeToastActivity:kLoadingText];
    SAFE;
    [[HomeManager sharedManager] homeMoreStatusWithPage:++self.pageNumber completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            YMHomeResult *homeResult= result;
            [hotListArray addObjectsFromArray:homeResult.hotList];
            if (homeResult.hotList.count  == 0) {
                [weakSelf.view makeToast:@"加载完毕"];
                self.collectionView.footer = nil;
            }
            [self.collectionView reloadData];
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
}

-(void)makeTheAltView
{
    self.orderView.backgroundColor = [UIColor whiteColor];
    self.orderView.orderResult = order;
    [self.orderView.steper setup];

    [self.view addSubview:self.orderView];
    self.orderView.steper.stepInterval = 1.0f;
    self.orderView.steper.value = order.left> 10.0?10.0:order.left;
    [self.orderView.steper setup];
    NSString *allsting = [NSString stringWithFormat:@"总需求%ld/剩余%ld ",(long)order.expected,(long)order.left];
    NSString *leftString = [NSString stringWithFormat:@"%ld ",(long)order.left];
    self.orderView.allLable.attributedText = [allsting alllString:allsting andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:14] subString:leftString andColor:[UIColor colorWithHex:@"#DD2727"] andsubFont:[UIFont systemFontOfSize:14]];
    
    [self.orderView.iconView sd_setImageWithURL:[NSURL URLWithString:order.imageUrl] placeholderImage:placeHolder];
    self.orderView.steper.maximum = order.left;
    
    self.orderView.productionLable.text = order.name;
}
-(void)nextMessge
{
    NSInteger page = 0;
    if (attention.currentPage == messageArray.count -1) {
        page = 0;
    }else{
        page = attention.currentPage+1;
    }
    CGPoint  offset = self.attentionSrollView.contentOffset;
    offset.y  = page * 22.5;
    attention.currentPage = page;

    [self.attentionSrollView setContentOffset:offset animated:YES];

}
@end
