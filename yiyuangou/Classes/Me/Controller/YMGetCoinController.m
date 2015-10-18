//
//  YMGetCoinController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMGetCoinController.h"
#import "YMRuleController.h"
@interface YMGetCoinController()
{
    UIView *footView;
}
@end

@implementation YMGetCoinController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赚抢币";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 88)];
    UIButton *footButton = [UIButton buttonWithFrame:CGRectMake(0, 44, kWIDTH, 44) target:self action:@selector(footButtonClick) title:@"领取奖励" cornerRadius:2];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = [UIColor redColor];
    [footView addSubview:footButton];

    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else
    {
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 4) {
        return 88;
    }else{
        return 44;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *coinCell = @"coinCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coinCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
    }
    if (indexPath.section == 0) {
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.text = @"每日签到";
        cell.detailTextLabel.text = @"本月累计2天";
        return cell;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"了解一元赚";
                cell.detailTextLabel.text = @"奖励1个抢币  做任务";
                break;
            case 1:
                cell.textLabel.text = @"邀请好友参加";
                cell.detailTextLabel.text = @"奖励1个抢币  做任务";
                break;
            case 2:
                cell.textLabel.text = @"参与抢购一次";
                cell.detailTextLabel.text = @"奖励1个抢币  做任务";
                break;
            case 3:
                cell.textLabel.text = @"立即充值";
                cell.detailTextLabel.text = @"奖励1个抢币  做任务";
                break;
            case 4:
               [cell.contentView addSubview:footView];
                cell.accessoryType = UITableViewCellAccessoryNone;
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
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YMRuleController *controller = [[YMRuleController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }
    }
}
-(void)footButtonClick
{
    NSLog(@"footButtonClick");
}
@end
