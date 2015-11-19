//
//  YMDetailProductionController.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//
#define HEADERHEIGHT  10
#define IMAGE_HEIGHT 132.5

#import "YMDetailProductionController.h"
#import "YMDetailProgressCell.h"
#import "YMRewardPersonCell.h"
#import "YMAdvertisementView.h"
#import "YMDetailViewCell.h"
#import "YMPastRewardController.h"
#import "RewardViewController.h"
#import "TreasureViewController.h"
#import "YMBuyView.h"
#import "YMOrderView.h"
#import "YMNotifiyController.h"
#import "HomeManager.h"
#import "YMDetailResult.h"
#import "YMDetailTimeCell.h"
#import "YMRuleController.h"
#import "YMInfoCenter.h"
#import "YMPayController.h"
#import "YMRefreshResult.h"
#import "MyCarManager.h"
#import "YMCarResult.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
#import "YMMoreResult.h"
#import "LuckNumView.h"
#import "YMDetailRuleCell.h"
@interface YMDetailProductionController()<YMBuyViewDelegate,UITableViewDataSource,UITableViewDelegate,YMOrderViewDelegate,YMDetailTimeCellDelegate>
{
    UIScrollView *addScrollView;//广告滚动
    UIPageControl *pageControl;//广告控制器

    YMDetailResult *detailResult;
    NSInteger allCount;
    
    YMOrderResult *order;
}
@property (nonatomic ,strong) UIView  * footView;

@property (nonatomic ,strong) NSArray * dataArray;
@property (nonatomic ,strong) NSArray * titleArray;
@property (nonatomic,strong)NSMutableArray *selctCarArray;

@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)YMBuyView *footerCarView;
@property (nonatomic,strong)UIView *footerNotifyView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)YMOrderView *orderView;
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)BOOL isAdd;
@end

@implementation YMDetailProductionController

-(YMOrderView *)orderView
{
    if (_orderView == nil) {
        _orderView = [[YMOrderView alloc] initWithFrame:CGRectMake(0, kHEIGHT, kWIDTH, 385) withModel:order.left];
        _orderView.delegate = self;
    }
    return _orderView;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64 -50) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return  _tableView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.orderView removeFromSuperview];
    self.orderView = nil;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"商品详情";
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    self.titleArray = @[@"往期揭晓",@"晒单",@"所有参与人次"];
    [self.view addSubview:self.tableView];
    SAFE;
    self.tableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [weakSelf addMoreHotstatus];
        [weakSelf.tableView.footer endRefreshing];
    }];
    
}
#pragma mark -- UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!detailResult) {
        return 0;
    }
    if (section == 0) {
        return 2;
    }else if(section == 1){
        return 2;
    }else{
        return detailResult.totalList.count+1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            if (detailResult.flag == 0) {//处于购买状态
                return 90;
            }else{
                if (detailResult.status == 1) {//已公布获奖用户
                    return 140;
                }else{//正在开奖状态
                    return 114;
                }
            }
        }else
        {
            return 90;
        }
    }else if(indexPath.section == 1){
        return 44;
    }else{
        return 55;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            if (detailResult.flag) {
                if (detailResult.status == 1) {
                    static NSString *rewardPersonCell = @"rewardPersonCell";
                    YMRewardPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardPersonCell];
                    if (cell == nil) {
                        cell = [[YMRewardPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rewardPersonCell];
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell = [cell congifgWithMode:detailResult];
                    [cell.checkluckButton addTarget:self action:@selector(showLuckView) forControlEvents:UIControlEventTouchUpInside];
                    return cell;
                    
                }else{
                    static NSString *detailTimeCell = @"detailTimeCell";
                    YMDetailTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:detailTimeCell];
                    if (cell == nil) {
                        cell = [[YMDetailTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailTimeCell];
                        cell.delegate = self;
                    }
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell = [cell congfigWithModel:detailResult];
                    return cell;
                }
            }else{
                
                static NSString *progressCell = @"progressCell";
                YMDetailProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:progressCell];
                if (cell == nil) {
                    cell = [[YMDetailProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:progressCell];
                }
                cell = [cell congifgWithMode:detailResult];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }
        }else{
            static NSString *ruleCell = @"ruleCell";
            YMDetailRuleCell *cell = [tableView dequeueReusableCellWithIdentifier:ruleCell];
            if (cell == nil) {
                cell = [[YMDetailRuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ruleCell];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.ruleButton addTarget:self action:@selector(ruleButtonClick) forControlEvents:UIControlEventTouchDown];
            return cell;
        }
    }else if (indexPath.section == 1){
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.titleArray[indexPath.row];
        return cell;
        
    }else{
        if (indexPath.row == 0) {
            static NSString *tableViewCell2 = @"tableViewCell2";
            UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell2];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell2];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.textLabel.text = @"所有人参与次数";
            return cell;

        }else{
            static NSString *resuedID = @"YMDetailViewCell";
            YMDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuedID];
            if (cell == nil) {
                cell = [[YMDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuedID];
            }
            YMTotalList *list = detailResult.totalList[indexPath.row-1];
            cell = [cell configWithModel:list];
            tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return  cell;

        }
    }
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if (indexPath.section == 2) {
        if (indexPath.row !=0) {
            if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
                UIEdgeInsets inset;
                inset.left = 60;
                [cell setSeparatorInset:inset];
            }
            if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
                UIEdgeInsets inset;
                inset.left = 60;
                [cell setLayoutMargins:inset];
            }
        }
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YMPastRewardController *controller = [[YMPastRewardController alloc] init];
            controller.gid =detailResult.gid;
            [self setHidesBottomBarWhenPushed:YES];

            [self.navigationController pushViewController:controller animated:YES];
        }else if(indexPath.row == 1){
            TreasureViewController *controller = [[TreasureViewController alloc] init];
            controller.gid =detailResult.gid;
            [self setHidesBottomBarWhenPushed:YES];
            controller.isHiden= YES;
            controller.titleName = @"商品晒单";
            [self.navigationController pushViewController:controller animated:YES];

        }
    }
}
-(void)addTheFooterView
{
    if (!detailResult.flag) {
        self.footerCarView = [[YMBuyView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 64 - 50, kWIDTH, 50)];
        self.footerCarView.delegate = self;
        
        [self.view addSubview:self.footerCarView];
    }else{
        self.footerNotifyView = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 64 - 50, kWIDTH, 50)];
        UIView *notifyView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH*0.66, 50)];
        notifyView.backgroundColor = [UIColor blackColor];
        UILabel *notifyLabel  = [UILabel labelWithFrame:CGRectMake(10, 15, kWIDTH*0.7, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor]];
        notifyLabel.text = [NSString stringWithFormat:@"第%ld期正在火热报名...",(long)detailResult.newPeriod];
        [notifyView addSubview:notifyLabel];
        
        UIView *buyView = [[UIView alloc] initWithFrame:CGRectMake(notifyView.tmri_right, 0, kWIDTH*0.34, 50)];
        UIButton *rightButton = [UIButton buttonWithFrame:buyView.bounds target:self action:@selector(showLatestInformation) title:@"立即抢购" cornerRadius:0];
        [buyView addSubview:rightButton];

        rightButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [rightButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [self.footerNotifyView addSubview:notifyView];
        [self.footerNotifyView addSubview:buyView];
        [self.view addSubview:self.footerNotifyView];
    }
}
-(void)buyViewDidSelectAtIndex:(NSInteger)index
{
    if (index == 10000) {
        [self addToCar];
    }else{
        self.footView = self.footerCarView;
        [self goShopping];
    }
}
-(void)showLatestInformation
{
    self.footView = self.footerNotifyView;
    YMDetailProductionController *controller = [[YMDetailProductionController alloc] init];
    controller.gid = detailResult.gid;
    controller.gsid = detailResult.newGsid;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)goShopping
{
    SAFE;
    YMInfoCenter *center = [YMInfoCenter sharedManager];
    if ([center getUserID]) {
        [self.view makeToastActivity:kLoadingText];

        [[HomeManager sharedManager] homeBuyStatusWithGsid:detailResult.newGsid?detailResult.newGsid:detailResult.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
            [weakSelf.view hideToastActivity];

            if (statusCode == 0) {
                order = result;
                if (order.left <1) {
                    [weakSelf.view makeToast:@"该商品已经卖完,或者其他客户\n处于购买状态,请稍后购买"];
                    return ;
                }
                weakSelf.footView.hidden = YES;

                [self makeTheAltView];
                weakSelf.tableView.userInteractionEnabled = NO;
                [UIView animateWithDuration:0.25f animations:^{
                weakSelf.orderView.tmri_bottom = kHEIGHT;
                } completion:nil];
                weakSelf.footerCarView.hidden = YES;

            }else{
                [weakSelf.view makeToast:msg];
            }
        }];
    }else{
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }

}
-(void)orderButtonClickWith:(YMOrderResult *)data
{
    YMOrderResult *order = data;
    YMInfoCenter *center  =[YMInfoCenter sharedManager];
    if ([center getUserID]) {
         YMCarInfo *carinfo = [[YMCarInfo alloc] init];
          carinfo.buyCount = order.buyCount;
          carinfo.gsid =order.gsid;
          carinfo.is_end = order.isAll;
          self.selctCarArray = [[NSMutableArray alloc] init];
         [self.selctCarArray addObject:carinfo];
        
        YMPayController *controller = [[YMPayController alloc] init];
       [self setHidesBottomBarWhenPushed:YES];
        controller.backstring = self.title;

        controller.selectedArray = self.selctCarArray;
       [self.navigationController pushViewController:controller animated:YES];
        self.footView.hidden = NO;
        self.tableView.userInteractionEnabled = YES;
    }else{
        
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)loadData
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager]detailStatusWithWithGid:self.gid andGsid:self.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            detailResult = result;
            if (!weakSelf.isAdd &&detailResult.bannerList.count) {
                [weakSelf makeTheheaderView];
                weakSelf.isAdd = YES;
                weakSelf.tableView.tableHeaderView = addScrollView;
            }
            
            [weakSelf addTheFooterView];
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)addToCar
{
    SAFE;
    if (![YMInfoCenter userID]) {
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:4];
        return;
    }
    [self.view makeToastActivity:kLoadingText];
     [[HomeManager sharedManager] AddGoodsToCarStatusWithGid:detailResult.gid andGsid:detailResult.gsid andUid:[YMInfoCenter userID] completion:^(id result, NSInteger statusCode, NSString *msg) {
         [weakSelf.view hideToastActivity];

         if (statusCode == 0) {
             [[NSNotificationCenter defaultCenter]postNotificationName:CAR_ISCHANGE object:nil];
             [weakSelf.view makeToast:@"添加成功"];
         }else if(statusCode == 6){
             [weakSelf.view makeToast:@"购物车已有该件物品"];
         }else{
             [weakSelf.view makeToast:msg];
         }
     }];
}
-(void)ruleButtonClick
{
    [self setHidesBottomBarWhenPushed:YES];
    YMRuleController *controller = [[YMRuleController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)cancelButtonClick
{
    [self performSelector:@selector(canceltheview) withObject:nil afterDelay:0.25f];
    self.tableView.userInteractionEnabled = YES;
}
-(void)canceltheview
{
    [self.orderView removeFromSuperview];
    self.orderView =nil;
    self.footView.hidden = NO;
}
-(void)timedownDidEnd:(YMDetailTimeCell *)cell
{
    [self loadData];
}

#pragma mark -- 广告图片轮播

-(void)makeTheheaderView
{
    addScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -IMAGE_HEIGHT , kWIDTH, IMAGE_HEIGHT)];
    addScrollView.bounces = NO;
    [self.collectionView addSubview:addScrollView];
    for (int i = 0 ; i <  detailResult.bannerList.count; i ++) {
        UIImage *placeholder = [UIImage imageNamed:GoodImage];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kWIDTH, 0, kWIDTH, IMAGE_HEIGHT)];
        
        imageView.tag= 666+i;
        BannerPicture *list = detailResult.bannerList[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:list.url] placeholderImage:placeholder];
        [addScrollView addSubview:imageView];
    }
    addScrollView.contentSize = CGSizeMake(detailResult.bannerList.count *kWIDTH, 0);
    addScrollView.showsHorizontalScrollIndicator = NO;
    addScrollView.showsVerticalScrollIndicator = NO;
    addScrollView.pagingEnabled = YES;
    addScrollView.delegate = self;
    addScrollView.tag = 1;
    pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 102.5 , kWIDTH, 40)];
    pageControl.numberOfPages = detailResult.bannerList.count;
    //设置时间定时器
    [self setTheTimer];
}
-(void)nextImage
{
    NSInteger page = 0;
    if (pageControl.currentPage == detailResult.bannerList.count-1) {
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
    [self.tableView addSubview:pageControl];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)makeTheAltView
{
    self.orderView.backgroundColor = [UIColor whiteColor];
    self.orderView.orderResult = order;
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
-(void)addMoreHotstatus
{
   [[HomeManager sharedManager] detailMoreStatusWithWithGid:++self.start andGsid:detailResult.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
       if (statusCode == 0) {
           YMMoreResult *re  =result;
           if (re.totalList.count == 0) {
               self.tableView.footer = nil;
           }
           [detailResult.totalList addObjectsFromArray:re.totalList];
           [self.tableView reloadData];
       }
    }];
}
-(void)showLuckView
{
    NSMutableDictionary   *muDic = [[NSMutableDictionary alloc]init];
    [self.view makeToastActivity:kLoadingText];
    SAFE;
     [[HomeManager sharedManager] detailGetMyNumberStatusWithWithGsid:detailResult.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
         [weakSelf.view hideToastActivity];
         if (statusCode == 0) {
             NSDictionary *dict = [result keyValues];
             [muDic setValue:dict[@"data"][@"period"] forKey:@"period"];
             [muDic setValue:dict[@"data"][@"luckyNumList"] forKey:@"luckyNumList"];
             [muDic setValue:detailResult.name forKey:@"name"];
             LuckNumView *luckNum  = [[LuckNumView alloc]initWithDic:muDic frame:self.view.bounds];
             UIWindow *window = [UIApplication sharedApplication].keyWindow;
             if (!window) {
                 window  = [[UIApplication sharedApplication].windows objectAtIndex:0];
             }
             [[[window subviews] objectAtIndex:0] addSubview:luckNum];
         }   }];
    
}
@end
