//
//  YMNegotiateController.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMNegotiateController.h"

@implementation YMNegotiateController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"常见问题";
    //    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel*titleLabel=[UILabel labelWithFrame:CGRectMake(0, 0, kWIDTH, 44) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#DD2727"]];
    if (section==0) {
        titleLabel.text=@"  抢购规则";
    }else
    {
        titleLabel.text=@"  幸运号码计算规则";
    }
    return titleLabel;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reciveCell = @"reciveCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reciveCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reciveCell];
    }
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"1. 用户花费1远获得夺宝币";
                break;
            case 1:
                cell.textLabel.text = @"2. 选择商品，商品分配幸运号码；";
                break;
            case 2:
                cell.textLabel.text = @"3. 幸运号码分配完毕，系统根据规则计算出1个幸运号码，持有该幸运号码的用户获奖。";
                break;
                
            default:
                break;
        }
        return cell;
    }else{
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"1. 去掉商品最后购买时间前网站所有的商品的最后十条购买时间记录";
                break;
            case 1:
                cell.textLabel.text = @"2. 每个时间记录按时,分,秒,一次排列取数值";
                break;
            case 2:
                cell.textLabel.text = @"3. 讲这10个数值之和除以该商品总参与人次后取余数，余数加上10000001即为幸运号码";
                break;
                
            default:
                break;
        }
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
