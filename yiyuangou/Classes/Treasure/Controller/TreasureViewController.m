//
//  TreasureViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "TreasureViewController.h"
#import "YMProductionCell.h"
#import "YMProductionListController.h"
@interface TreasureViewController ()

@end

@implementation TreasureViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"夺宝圈";
    UIButton *rightBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 60, 44) target:self action:@selector(rightTopClick) title:@"我的晒单" cornerRadius:0];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem=rightItem;

    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *productionCell = @"productionCell";
    YMProductionCell *cell = [tableView dequeueReusableCellWithIdentifier:productionCell];
    if (cell == nil) {
        cell = [[YMProductionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:productionCell];
    }
    cell = [cell configWithMode];
    cell.stateLable.hidden = YES;
    return cell;
}
-(void)rightTopClick
{
    YMProductionListController *controller = [[YMProductionListController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

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
