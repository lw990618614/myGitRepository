//
//  YMPastRewardController.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPastRewardController.h"
#import "YMPastViewCell.h"
#import "HomeManager.h"
@interface YMPastRewardController()
{
    NSMutableArray *lotterArray;
//    YMPastRewardResult *lotterArray;
}
@property (nonatomic,assign)NSInteger start;
@property (nonatomic,assign)NSInteger flag;
@end

@implementation YMPastRewardController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"往期开奖";
    //设置分割线
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.footer = [MJRefreshBackNormalFooter  footerWithRefreshingBlock:^{
        [self addMoreHotstatus];
        [self.tableView.footer endRefreshing];
    }];
    
    lotterArray =  [[NSMutableArray alloc] init];
    self.start = 0;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    [self.tableView setSeparatorColor:[UIColor colorWithHex:@"#EAEAEA"]];

    [self loadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return lotterArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *pastViewCell = @"pastViewCell";
    YMPastViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pastViewCell];
    if (cell == nil) {
        cell = [[YMPastViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pastViewCell];
    }
    YMLottery *model = lotterArray[indexPath.row];
    cell = [cell configWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)loadData
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[HomeManager sharedManager] pastRewardStatusWithGid:self.gid and:self.start++ and:1 completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
            YMPastRewardResult *past = result;
            [lotterArray addObjectsFromArray:past.lotteryList];
            [self.tableView reloadData];
            if (past.lotteryList.count == 0) {
                weakSelf.tableView.footer = nil;
            }

        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)addMoreHotstatus
{
    [self loadData];
}

//-(void)refresh
//{
//    [self.view makeToastActivity:kLoadingText];
//    WEAKSELF;
//    [[HomeManager sharedManager] pastRewardStatusWithGid:self.gid and:++self.start and:0 completion:^(id result, NSInteger statusCode, NSString *msg) {
//        [weakSelf.view hideToastActivity];
//
//        if (statusCode == 0) {
//            YMPastRewardResult *past = result;
//            if (past.lotteryList.count == 0) {
//                weakSelf.tableView.footer = nil;
//            }
//            else
//            {
//              [lotterArray addObjectsFromArray:past.lotteryList];
//              [self.tableView reloadData];
//            }
//        }else{
//            [weakSelf.view makeToast:msg];
//        }
//    }];
//
//}
@end
