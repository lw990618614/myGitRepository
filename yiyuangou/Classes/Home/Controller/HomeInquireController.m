//
//  HomeInquireController.m
//  yiyuangou
//
//  Created by roen on 15/11/20.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "HomeInquireController.h"
#import "YMRuleController.h"
#import "YMWebViewController.h"
#import "HomeManager.h"
#import "YMInquireResult.h"
@interface HomeInquireController ()
{
    NSString *kjgz;//开奖规则
    NSString *spsm;//商品申明
    NSString *yhxy;//用户协议
}
@end

@implementation HomeInquireController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"公告";
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setSeparatorColor:[UIColor colorWithHex:@"#EAEAEA"]];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self loadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *inquiredcell = @"inquiredcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:inquiredcell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:inquiredcell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"计算方式";
            break;
        case 1:
            cell.textLabel.text = @"商品声明";
            break;
        case 2:
            cell.textLabel.text = @"用户协议";
            break;
        default:
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor heightBlacKColor];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        YMRuleController *controller = [[YMRuleController alloc] init];
        controller.url = kjgz;
        controller.title =@"计算方式";
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }else if (indexPath.row == 1)
    {
        YMRuleController *controller = [[YMRuleController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        controller.title =@"商品声明";
        controller.url =spsm;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        YMRuleController *controller = [[YMRuleController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        controller.title = @"用户协议";
        controller.url =yhxy;
        [self.navigationController pushViewController:controller animated:YES];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)loadData
{
    SAFE;
     [[HomeManager sharedManager] homeInquirecompletion:^(id result, NSInteger statusCode, NSString *msg) {
         if (statusCode == 0) {
             YMInquireResult *re = result;
             for (YMInquqire *require in re.htmlList) {
                 if ([require.shortName isEqualToString:@"rewardRule"]) {//规则
                     kjgz = require.url;
                 }else if([require.shortName isEqualToString:@"privacy"]){//夺宝声明
                     spsm = require.url;
                 }else if([require.shortName isEqualToString:@"rule"])//用户协议
                 {
                     yhxy = require.url;
                 }
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
