//
//  MySettingViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MySettingViewController.h"
#import "YMSettingCell.h"
#import "YMAcceptViewController.h"
#import "YMReceiveListController.h"
#import "YMTreasureListController.h"
#import "YMGetCoinController.h"
#import "YMRuleController.h"
#import "YMSetController.h"
@interface MySettingViewController ()

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"一元购";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 0.01;
    }else{
        return 10;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *settingCell = @"settingCell";
        YMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if (cell == nil) {
            cell = [[YMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        [cell.fillButton addTarget:self action:@selector(fillClick) forControlEvents:UIControlEventTouchDragInside];
        return cell;
        
    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"share_01"];
        switch (indexPath.section) {
            case 0:
                
                break;
            case 1:
                cell.textLabel.text = @"收货地址";
                break;
            case 2:
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"夺宝记录";
                }else{
                    cell.textLabel.text = @"中奖记录";
                }
                break;
            case 3:
                cell.textLabel.text = @"赚抢币";
                break;
            case 4:
                cell.textLabel.text = @"设置";
                break;
            default:
                break;
        }
        return cell;

    }
    
}
-(void)fillClick
{
    NSLog(@"充值");
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        YMAcceptViewController *controller = [[YMAcceptViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            YMTreasureListController *controller = [[YMTreasureListController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else{
            YMReceiveListController *controller = [[YMReceiveListController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
    }else if(indexPath.section == 3){
        YMGetCoinController *controller = [[YMGetCoinController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }else if (indexPath.section == 4)
    {
        YMSetController *controller = [[YMSetController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
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
