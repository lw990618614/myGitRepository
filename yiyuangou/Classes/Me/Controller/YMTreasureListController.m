//
//  YMTreasureListController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTreasureListController.h"
#import "YMListCell.h"
#import "YMCustomSegmentView.h"
#import "LuckNumView.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
#import "YMDetailProductionController.h"
@interface YMTreasureListController()<CustomSegmentViewDelegate,YMListCellProtol,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *contiuesArray;          //进行中数组
@property(nonatomic,strong)NSMutableArray *finishArray;            //已经开奖数组
@property(nonatomic,strong)NSArray *showArray;              //展示的数组
@property(nonatomic,assign)NSUInteger  index;
@property(nonatomic,strong) UITableView *countinueTableView;//进行中表格
@property(nonatomic,strong) UITableView *finishTableView;   //已开奖表格
@property(nonatomic,assign)  BOOL       isFirstFinsh;//是否是第一次进入已经开奖页面
@property(nonatomic,assign)  NSUInteger countiuns;
@property(nonatomic,assign)  NSUInteger finish;
@property(nonatomic,assign)  NSUInteger refreshCountiuns;
@property(nonatomic,assign)  NSUInteger refreshFinish;
@end
@implementation YMTreasureListController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contiuesArray = [[NSMutableArray alloc] init];
    _finishArray = [[NSMutableArray alloc] init];
    _countiuns  = _finish = 1;
    _refreshFinish =_refreshCountiuns =0;
    self.title =@"夺宝记录";
    YMCustomSegmentView *segmentView = [[YMCustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    segmentView.delegate = self;
    segmentView.titles = @[@"进行中",@"已开奖"];
    [self.view addSubview:segmentView];
    self.view.backgroundColor =[UIColor whiteColor];
    
    UIImage *btnImage = [UIImage imageNamed:@"nav_back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(poptoMysetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

//    UIButton *leftBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 40, 44) target:self action:@selector(poptoMysetting) title:@"返回" cornerRadius:0];
//    leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    leftBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    
//    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:barBtn];
    self.navigationItem.leftBarButtonItem=self.isHidenRight?barBtn:nil;

    self.countinueTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kWIDTH, kHEIGHT - 64 -44) style:UITableViewStyleGrouped];
    self.countinueTableView.delegate = self;
    self.countinueTableView.dataSource = self;
    if ([self.countinueTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.countinueTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.countinueTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.countinueTableView setLayoutMargins:UIEdgeInsetsZero];
    }

    [self.countinueTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    self.countinueTableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self loadMoreProcess];
        [self.countinueTableView.footer endRefreshing];
    }];
    
    self.countinueTableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 结束刷新
        [self loadDataProcess];
        [self.countinueTableView.header endRefreshing];
    }];
    
    [self.view addSubview:self.countinueTableView];
    self.finishTableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kWIDTH, kHEIGHT - 64 -44) style:UITableViewStyleGrouped];
    self.finishTableView.dataSource = self;
    self.finishTableView.delegate = self;
    if ([self.finishTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.finishTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.finishTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.finishTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.finishTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

    
    self.finishTableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 结束刷新
        [self loadDataFinsh];
        [self.finishTableView.header endRefreshing];
    }];
    self.finishTableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self loadMoreFinish];
        [self.countinueTableView.footer endRefreshing];
    }];
    [self.view addSubview:self.finishTableView];
    [self rightCar];
    self.index = 0;
    self.isFirstFinsh = YES;
    [self loadDataProcess];
    [self.view bringSubviewToFront:self.countinueTableView];
    
}
//购物车
-(void) rightCar
{
    UIImage *shopImage  = [UIImage imageNamed:@"navibar_08"];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithImage:shopImage style:UIBarButtonItemStylePlain target:self action:@selector(shopCarAction:)];
    self.navigationItem.rightBarButtonItem  = rightItem;
}
-(void)shopCarAction:(id) sender
{
    AppDelegate *delegate  = (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabBar = (YMTabBarController *)delegate.window.rootViewController;
    [tabBar setSelectedIndex:3];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.index == 0 ) {
        return self.contiuesArray.count;
    }
    return self.finishArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *settingCell = @"settingCell";
    NSDictionary *dict;
    if (self.index == 0) {
        dict = self.contiuesArray[indexPath.row];
    }
    else
        dict = self.finishArray[indexPath.row];
        YMListCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if (cell == nil) {
            cell = [[YMListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
    cell = [cell congfigWithModle:dict];
    cell.delegate  = self;
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //夺宝记录 进行中跳转到已经开奖的列表
    //进行中
    NSDictionary *dict;
    if (self.index == 0) {
        dict = self.contiuesArray[indexPath.row];
    }
    //已经开奖
    else if (self.index == 1)
    {
        dict = self.finishArray[indexPath.row];

    }
    
    YMDetailProductionController *detailProductVC = [[YMDetailProductionController alloc]init];
    detailProductVC.gid = [dict[@"gid"] integerValue];
    detailProductVC.gsid = [dict[@"gsid"]integerValue];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailProductVC animated:YES];
}
#pragma mark ---segmentdelgegate ----
-(void)segmentView:(YMCustomSegmentView *)segmentView selectedAtIndex:(NSInteger)index
{
    //进行中
   if(index == 0 )
   {
       if (self.contiuesArray.count == 0) {
           [self.countinueTableView showEmptyView];
       }
       else
       {
           [self.countinueTableView hideEmptyView];
           [self.view bringSubviewToFront:self.countinueTableView];
       }

   }
    //开奖
     if(index ==1 )
    {
        if (self.isFirstFinsh) {
            [self.view bringSubviewToFront:self.finishTableView];
            [self loadDataFinsh];
        }
        else
        {
          if (self.finishArray.count == 0) {
              [self.view bringSubviewToFront:self.finishTableView];
            [self.finishTableView showEmptyView];

          }
          else
          {
            [self.finishTableView hideEmptyView];
            [self.view bringSubviewToFront:self.finishTableView];
         }
        }
    }
    self.index =  index;
    
}
-(void)luckNum:(YMListCell *)cell
{
    NSIndexPath *indexPath = [self.countinueTableView indexPathForCell:cell];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/luckyNumber"];
    NSDictionary *goodsDic = self.contiuesArray[indexPath.row];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    NSMutableDictionary   *muDic = [[NSMutableDictionary alloc]init];
    [dict setValue:goodsDic[@"gsid"] forKey:@"gsid"];
    [self.view makeToastActivity:kLoadingText];

    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            
            [muDic setValue:dict[@"data"][@"period"] forKey:@"period"];
            [muDic setValue:dict[@"data"][@"luckyNumList"] forKey:@"luckyNumList"];
            [muDic setValue:goodsDic[@"name"] forKey:@"name"];
            LuckNumView *luckNum  = [[LuckNumView alloc]initWithDic:muDic frame:self.view.bounds];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            if (!window) {
                window  = [[UIApplication sharedApplication].windows objectAtIndex:0];
            }
            [[[window subviews] objectAtIndex:0] addSubview:luckNum];
        }
        else
        {
            
                
        }
    
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark   ---网络请求----------
//加载在进行中
-(void) loadDataProcess
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/processRecord"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [self.view makeToastActivity:kLoadingText];
    [dict setValue:[NSNumber numberWithInteger:self.refreshCountiuns] forKey:@"proceeStart"];
    [dict setValue:[NSNumber numberWithInteger:1] forKey:@"flag"];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            [weakSelf .contiuesArray removeAllObjects];
            NSArray *tmpArray =  dict[@"data"][@"proceedList"];
            [weakSelf.contiuesArray addObjectsFromArray:tmpArray];
            [weakSelf.view hideToastActivity];
            if (weakSelf.contiuesArray.count == 0) {
                [weakSelf.countinueTableView showEmptyView:0];
            }
            [weakSelf.countinueTableView reloadData];
        }
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];
        
    }];
}
-(void) loadDataFinsh
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/finishRecord"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [dict setValue:[NSNumber numberWithInteger:self.refreshFinish] forKey:@"finishStart"];
    [dict setValue:[NSNumber numberWithInteger:1] forKey:@"flag"];
    [self.view makeToastActivity:kLoadingText];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            [weakSelf.finishArray removeAllObjects];
            NSArray *tmpArray =  dict[@"data"][@"finishList"];
            [weakSelf.finishArray addObjectsFromArray:tmpArray];
            [weakSelf.view hideToastActivity];
            if (weakSelf.finishArray.count == 0) {
                weakSelf.isFirstFinsh = NO;
                [weakSelf.finishTableView showEmptyView:0];
            }
            else
            {
            weakSelf.isFirstFinsh = NO;
            [weakSelf.finishTableView reloadData];
            [weakSelf.view bringSubviewToFront:weakSelf.finishTableView];
            }
        }
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];
        
    }];
}
//更多进行中
-(void) loadMoreProcess
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/processRecord"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [dict setValue:[NSNumber numberWithInteger:self.countiuns] forKey:@"proceeStart"];
    [dict setValue:[NSNumber numberWithInteger:0] forKey:@"flag"];
    [self.view makeToastActivity:kLoadingText];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            NSArray *tmpAray =  dict[@"data"][@"proceedList"];
            [weakSelf.view hideToastActivity];
            if (tmpAray.count == 0) {
                weakSelf.countinueTableView.footer = nil;
            }
            else
            {
                [weakSelf.contiuesArray addObjectsFromArray:tmpAray];
                weakSelf.refreshCountiuns =  weakSelf.countiuns;
                weakSelf.countiuns ++;
                [weakSelf.countinueTableView reloadData];
            }
        }
        [weakSelf.countinueTableView.footer endRefreshing];
    } failure:^(NSError *error) {
        
    }];
}
//更多已完成
-(void) loadMoreFinish
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/finishRecord"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [dict setValue:[NSNumber numberWithInteger:self.finish] forKey:@"finishStart"];
    [dict setValue:[NSNumber numberWithInteger:0] forKey:@"flag"];
    [self.view makeToastActivity:kLoadingText];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            NSArray *tmpAray =  dict[@"data"][@"finishList"];
            if (tmpAray.count == 0) {
                weakSelf.finishTableView.footer = nil;
            }
            else
            {
                [weakSelf.finishArray addObjectsFromArray:tmpAray];
                weakSelf.refreshFinish =  weakSelf.finish;
                 weakSelf.finish ++;
                [weakSelf.finishTableView reloadData];
            }
        
        }
        else
        {
            [self.view makeToast:dict[@"msg"]];
        }
        [weakSelf.finishTableView.footer endRefreshing];

    } failure:^(NSError *error) {
        
    }];
}
-(void)poptoMysetting
{
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
    [tabbar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];

}
@end
