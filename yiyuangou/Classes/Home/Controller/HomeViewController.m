//
//  HomeViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//
#define IMAGE_COUNT  5
#define IMAGE_HEIGHT 132.5
#define NOTICE_HEIGHT 22.5
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
#import "HomeInquireController.h"
@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,YMOrderViewDelegate,HomeCellDelegate,homeCollectionViewCellDelegate,UIAlertViewDelegate>
{
    UIView *headView;
    UIScrollView *addScrollView;//广告滚动
    UIPageControl *pageControl;//
    UIPageControl *attention;//
    
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
//
@property (nonatomic,assign)BOOL  isShowlucky;
@property (nonatomic,assign)BOOL  isshow;
@property (nonatomic,copy)NSString *productionName;
@property (nonatomic,copy)NSString *grPeriod;//中奖期号


@property (nonatomic,strong)NSTimer *attentiontimer;
@property (nonatomic,strong)UIScrollView  *attentionSrollView;

@property (nonatomic,assign)BOOL isFirstLoad;

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
    [super viewDidDisappear:animated];
    [self.orderView removeFromSuperview];
    self.orderView = nil;
    self.isFirstLoad = YES;

    self.isshow = NO;
    self.collectionView.userInteractionEnabled = YES;

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.isshow = YES;
    if (self.isFirstLoad) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"99夺宝";
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"e-mail-1"] style:UIBarButtonItemStyleDone target:self action:@selector(RightButtonClick)];
    
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], UITextAttributeFont, [UIColor colorWithHex:@"#FFD1D1"], UITextAttributeTextColor, nil] forState:UIControlStateNormal];
    
    //初始化四个返回数据模型
    hotListArray = [[NSMutableArray alloc] init];
    flowListArray = [[NSMutableArray alloc] init];
    
    /******* dgfds大侠 ********/
    
    imageArray = [[NSMutableArray alloc] init];
    messageArray = [[NSMutableArray alloc] init];
    lotteryArray = [[NSMutableArray alloc] init];
    
    /********** 我是一只小熊********/
    /********** 我是一只sddgdf小熊猫********/
    /********** 我是一只dsf大熊猫********/
    /********** 我是一只都过的感受感受\熊猫********/
    /********** 我是一只大熊猫********/


    //初始化第一个headerView
    [self makeThefirstView];
    
    //初始化第二个sectionheader的头部
    secondeHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 51)];
    secondLabel = [UILabel labelWithFrame:CGRectMake(-1, 10, kWIDTH+2, 41) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
    secondLabel.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
    secondLabel.layer.borderWidth = 1;
    secondLabel.text= @"   热门商品";
    secondLabel.backgroundColor = [UIColor whiteColor];
    secondLabel.font = [UIFont systemFontOfSize:16];
    secondeHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [secondeHeaderView addSubview:secondLabel];
    
    //collecionView的初始化
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;//item间距
    layout.minimumLineSpacing = 0;     //行间距
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-66-48) collectionViewLayout:layout];
    self.collectionView.backgroundColor  =  [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
//    self.collectionView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT, 0, 0, 0);
    [self.view addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerClass:[YMHomeCollectionViewCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    [self.collectionView registerClass:[YMHomeCell class] forCellWithReuseIdentifier:@"homeCell"];
    
    //注册循环引用的header
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headeridentifier"];
    
    //添加下啦刷新
    SAFE;
    self.collectionView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [weakSelf addMoreHotstatus];
        [weakSelf.collectionView.footer endRefreshing];
    }];
//    self.collectionView.
    [self loadData];
    self.isFirstLoad = YES;

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
    CGSize size={kWIDTH,51+IMAGE_HEIGHT+22.5};
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
            [headerView addSubview:headView];
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
    //热门商品点击
    if (indexPath.section == 1) {
        HomeHotList *hotlist =  hotListArray[indexPath.row];
        controller.gid = hotlist.gid;
        controller.gsid = hotlist.gsid;
        NSDictionary *dict = @{
                               @"name":hotlist.name
                               };
        [MobClickHelper umengEvent:ymGoodsClick attributes:dict number:ymGoodsClickNum];
        
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
#pragma mark -- 广告图片轮播与公告
-(void)addTheAdvertisement
{
    //创建head 的背景View
    
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0 , kWIDTH, IMAGE_HEIGHT +51)];
    headView.backgroundColor = [UIColor whiteColor];

//    广告轮播
    addScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0 , kWIDTH, IMAGE_HEIGHT)];
    addScrollView.bounces = NO;
    for (int i = 0 ; i < imageArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, IMAGE_HEIGHT)];
        
        imageView.tag= 666+i;
        HomeBannerList *list = imageArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:list.url] placeholderImage:bannerPlaceHolder];
        UITapGestureRecognizer *buygesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
                imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:buygesture];
        [addScrollView addSubview:imageView];
    }
    pageControl.numberOfPages = imageArray.count;
    addScrollView.contentSize = CGSizeMake(imageArray.count *kWIDTH, 0);
    addScrollView.showsHorizontalScrollIndicator = NO;
    addScrollView.showsVerticalScrollIndicator = NO;
    addScrollView.pagingEnabled = YES;
    addScrollView.delegate = self;
    addScrollView.tag = 1;
    pageControl.currentPage = 0;
    //初始化第一个翻页
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, IMAGE_HEIGHT -20 , kWIDTH, 10)];
    pageControl.numberOfPages = imageArray.count;
    [headView  addSubview:addScrollView];
    [self.collectionView addSubview:headView];
    
    //设置广告的时间定时器
    [self setTheTimer];
    
    
    /**********************第二个******************/
    //创建公告栏
    self.attentionSrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(25, addScrollView.tmri_bottom, kWIDTH, 22.5)];
    [headView addSubview:self.attentionSrollView];
    
    for (int i = 0 ; i < messageArray.count; i ++) {
        UILabel *label = [UILabel labelWithFrame:CGRectMake(0, (i+1) *22.5, kWIDTH, 22.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
        HomeRewardList *list = messageArray[i];
        
        label.text = [NSString stringWithFormat:@"恭喜%@在第%ld期夺宝中获得%@",list.phone.length?list.phone:list.sname.length?list.sname:@"angle",list.period?list.period:12,list.name];
        
        [self.attentionSrollView addSubview:label];
    }
    
    self.attentionSrollView.showsHorizontalScrollIndicator = NO;
    self.attentionSrollView.showsVerticalScrollIndicator = NO;
    self.attentionSrollView.pagingEnabled = YES;
    self.attentionSrollView.bounces = YES;
    self.attentionSrollView.userInteractionEnabled = NO;
    self.attentionSrollView.delegate = self;
    self.attentionSrollView.tag = 102;
    
    attention = [[UIPageControl alloc]initWithFrame:CGRectZero]; //
    attention.currentPage = 0;
    attention.numberOfPages = messageArray.count;
    [attention addTarget:self action:@selector(turnPage) forControlEvents:UIControlEventValueChanged]; // 触摸mypagecontrol触发change这个方法事件
    [self.view addSubview:attention];

    UILabel *label = [UILabel labelWithFrame:CGRectMake(0, 0, kWIDTH, 22.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
    if (messageArray.count > 1) {
        HomeRewardList *list = messageArray[messageArray.count -1];
        label.text = [NSString stringWithFormat:@"恭喜%@在第%ld期夺宝中获得%@一台",list.phone.length?list.phone:list.sname?list.sname:@"angle",(long)(list.period?list.period:12),list.name];
    }
  
    [self.attentionSrollView addSubview:label];
    [self.attentionSrollView setContentSize:CGSizeMake(kWIDTH , 22.5 * ([messageArray count] + 2))];
    [self.attentionSrollView setContentOffset:CGPointMake(0, 0)];
    [self.attentionSrollView scrollRectToVisible:CGRectMake(0,22.5,kWIDTH,22.5) animated:NO];
    self.attentiontimer = [NSTimer scheduledTimerWithTimeInterval:6 target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    //添加公告喇叭
    UIImageView *labaiamge  = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 12, 10)];
    labaiamge.image = [UIImage imageNamed:@"喇叭"];
    labaiamge.centerY = self.attentionSrollView.centerY;
    [headView addSubview:labaiamge];
    
    [self makeThefirstView];
    
    [headView addSubview:firstHeaderView];

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

-(void)RightButtonClick
{
    
    HomeInquireController *controller = [[HomeInquireController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)loadData
{
    SAFE;
    if (!self.isFirstLoad) {
        [self.view makeToastActivity:kLoadingText];
    }
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
            [self removeSomeSubViews];
            [[NSNotificationCenter defaultCenter]postNotificationName:TIME_RELOAD object:nil];
                weakSelf.collectionView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                    self.isFirstLoad = NO;
                    [weakSelf loadData];
                    [weakSelf.collectionView.header endRefreshing];
                }];
                [weakSelf addTheAdvertisement];

            [weakSelf.collectionView reloadData];
            
            if (homeResult.grPeriod.length&&homeResult.grName&&![homeResult.grName isEqualToString:self.productionName]&&![self.grPeriod isEqualToString:homeResult.grPeriod]) {
                NSString *messageStr = [NSString stringWithFormat:@"您成为宝物%@ 第%@期的幸运儿",homeResult.grName,homeResult.grPeriod];
                UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"恭喜您中奖了!" message:messageStr delegate:self cancelButtonTitle:nil otherButtonTitles:@"马上领奖", nil];
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
    firstHeaderView  =  [[UIView alloc] initWithFrame:CGRectMake(0, IMAGE_HEIGHT+22.5, kWIDTH, 73.5 - 22.5)];
    firstHeaderView.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIView * lineView1  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 0.5)];
    lineView1.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [firstHeaderView addSubview:lineView1];

    UIView *bottonView  = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWIDTH, 41)];
    bottonView.backgroundColor = [UIColor whiteColor];
    [firstHeaderView addSubview:bottonView];
    
    UIView * lineView2  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 0.5)];
    lineView2.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
    [firstHeaderView addSubview:lineView2];
    
    UIView * lineView3  = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kWIDTH, 0.5)];
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
//    NSDictionary *dict = @{@"name":list.name};
//    [MobClickHelper umengEvent:ymGoodsClick attributes:dict number:ymGoodsClickNum];
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

        NSDictionary *dict = @{
                               @"name":order.name,
                               @"uid":[NSNumber numberWithInteger:[YMInfoCenter userID]]
                               };
        //抢购次数
        [MobClickHelper umengEvent:ymGoodsBuy attributes:dict number:[NSNumber numberWithInteger:order.buyCount]];
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
            if (re.uid == [YMInfoCenter userID]&&self.isshow==YES) {
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
                [weakSelf.view makeToast:@"该商品暂被抢光,再等等哦"];
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
//                [weakSelf.view makeToast:@"加载完毕"];
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
    
    [self.orderView.iconView sd_setImageWithURL:[NSURL URLWithString:order.imageUrl] placeholderImage:carPlaceHolder];
    self.orderView.steper.maximum = order.left;
    
    self.orderView.productionLable.text = order.name;
}
// pagecontrol 选择器的方法
- (void)turnPage
{
    int page = attention.currentPage; // 获取当前的page
    if (page == 0) {
        [self.attentionSrollView scrollRectToVisible:CGRectMake(0,22.5*(page+1),kWIDTH,22.5) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
    }else{
        CGPoint  offset = self.attentionSrollView.contentOffset;
        offset.y  = (page+1) * 22.5;
        [self.attentionSrollView setContentOffset:offset animated:YES];
    }
}
// 定时器 绑定的方法
- (void)runTimePage
{
    int page = attention.currentPage; // 获取当前的page
    page++;
    page = page > [messageArray count]- 1 ? 0 : page ;
    attention.currentPage = page;
    [self turnPage];
}
#pragma mark -- scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.tag ==1) {
        pageControl.currentPage = (scrollView.contentOffset.x +kWIDTH * 0.5)/kWIDTH;
    }
    if (scrollView.tag == 102) {
        CGFloat pagewidth = 22.5;
        int page = floor((self.attentionSrollView.contentOffset.y - pagewidth/([messageArray count]+2))/pagewidth)+1;
        page --;
        attention.currentPage = page;
    }
}
//设置广告的拖拽

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
    self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag ==1) {
        [self setTheTimer];
    }
}
-(void)setTheTimer
{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [self.collectionView addSubview:pageControl];
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)removeSomeSubViews
{
    [self.timer invalidate];
    
    [headView  removeFromSuperview];
    headView = nil;
    self.timer = nil;
    [addScrollView  removeFromSuperview];
    addScrollView = nil;
    [pageControl  removeFromSuperview];
    pageControl = nil;
    [attention  removeFromSuperview];
    attention = nil;
    
    [self.attentiontimer invalidate];
    self.attentiontimer = nil;
    [self.attentionSrollView removeFromSuperview];
    self.attentionSrollView = nil;
    

}
@end
