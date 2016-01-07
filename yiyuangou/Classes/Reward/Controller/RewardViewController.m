//
//  RewardViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "RewardViewController.h"
#import "RewardViewControllerCell.h"
#import "YMDetailProductionController.h"
#import "RewardManager.h"
#import "YMRewardResult.h"
#import "HomeManager.h"
#import "YMRefreshResult.h"
#import "YMPastRewardResult.h"
@interface RewardViewController ()<RewardCellDelegate>
{
    YMRewardResult *rewardResult;
    NSMutableArray *flowListArray;
    NSMutableArray *lotteryListArray;
}
@property (nonatomic,assign)NSInteger lotteryStart;
@property (nonatomic,assign)BOOL isFirstLoad;
@end

@implementation RewardViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.isFirstLoad) {
        [self loadData];
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"最新揭晓";
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    flowListArray = [[NSMutableArray alloc] init];
    lotteryListArray = [[NSMutableArray alloc] init];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    self.tableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self addMoreHotstatus];
        [self.tableView.footer endRefreshing];
    }];
    self.isFirstLoad = YES;
    
    self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 结束刷新
        [self loadData];
        [self.tableView.header endRefreshing];
    }];
    [self loadData];


}

#pragma mark -- UITableViewDelegate & UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return flowListArray.count + lotteryListArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rewardViewCell12 = @"rewardViewCell12";
    RewardViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardViewCell12];
    if (cell == nil) {
        cell = [[RewardViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rewardViewCell12];
        cell.delegate = self;
    }
    if (indexPath.row <  flowListArray.count) {
        RewardFlowList *list = flowListArray[indexPath.row];
        cell = [cell configWithMode:list];
        cell.row = indexPath.row;
        return cell;
       
    }else{
         RewardLotteryList *list = lotteryListArray[indexPath.row- flowListArray.count];
         cell = [cell configWithMode:list];
         return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
    YMDetailProductionController *controller = [[YMDetailProductionController alloc] init];
    if (indexPath.row < flowListArray.count) {
        RewardFlowList *list = flowListArray[indexPath.row];
        controller.gid = list.gid;
        controller.gsid = list.gsid;
    }else{
        NSLog(@"row =%ld  count = %ld %ld",indexPath.row,(unsigned long)rewardResult.flowList.count,rewardResult.lotteryList.count);
        RewardFlowList *list = lotteryListArray[indexPath.row - flowListArray.count];
        controller.gid = list.gid;
        controller.gsid = list.gsid;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}
-(void)loadData
{
//    [self.view makeToastActivity:kLoadingText];
    SAFE;
    [[RewardManager sharedManager] rewardStatusWith:self.lotteryStart completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            
            [flowListArray removeAllObjects];
            [lotteryListArray removeAllObjects];
            
            rewardResult = result;
            rewardResult.flowList = [rewardResult.flowList sortedArrayUsingComparator:
                               ^NSComparisonResult(RewardFlowList *obj1, RewardFlowList *obj2) {
                                   
                                   NSComparisonResult result =!( obj1.left >= obj2.left);
                                   
                                   return result;
                               }];
          
            [flowListArray addObjectsFromArray:rewardResult.flowList];
            for (RewardFlowList *list in rewardResult.flowList) {
                if (list.left >= 60 *60*1000 - 6000) {
                    [flowListArray removeObject:list];
                }
            }
            [lotteryListArray addObjectsFromArray:rewardResult.lotteryList];
            
            [[NSNotificationCenter defaultCenter]postNotificationName:TIME_RECENT object:nil];

            [weakSelf.tableView reloadData];
        }else
        {
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)timedownDidEnd:(RewardViewControllerCell *)cell
{
    [self reloadDataWith:cell];
}
-(void)reloadDataWith:(RewardViewControllerCell*)cell
{
    [CATransaction begin];

    __weak typeof(self) weakSelf = self;
    NSIndexPath *path = [NSIndexPath indexPathForRow:cell.row inSection:0];

    RewardFlowList *model = rewardResult.flowList[path.row];
    
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager] homeRefreshCellStatusWithModle:model.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            YMRefreshResult *re = result;
            for (RewardFlowList *list in rewardResult.flowList) {
                if (list.gsid == model.gsid) {
                    model.phone =re.phone;
                    model.showPhone = YES;
                    model.menber = re.menber;
                    model.createTime = re.createTime;
                }
            }
            [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
    [CATransaction commit];
    
    
}
-(void)addMoreHotstatus
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager] pastRewardStatusWithGid:0 and:++self.lotteryStart and:1 completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            YMPastRewardResult *re = result;
            [lotteryListArray addObjectsFromArray:re.lotteryList];
            [weakSelf.tableView reloadData];
            if (re.lotteryList.count < 1) {
               weakSelf.tableView.footer = nil;
            }
        }else{
            [weakSelf.view makeToast:msg];
        }
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
