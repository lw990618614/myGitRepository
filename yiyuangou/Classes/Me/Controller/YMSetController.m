//
//  YMSetController.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSetController.h"
#import "YMClientController.h"
#import "YMQuestionController.h"
#import "YMNegotiateController.h"
@interface YMSetController()
{
    UIView *footView;
}
@end
@implementation YMSetController
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
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 88)];
    UIButton *footButton = [UIButton buttonWithFrame:CGRectMake(0, 44, kWIDTH, 44) target:self action:@selector(footButtonClick) title:@"退出当前帐号" cornerRadius:2];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = [UIColor redColor];
    [footView addSubview:footButton];

    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 88;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *coinCell = @"coinCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coinCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
    }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
                cell.textLabel.text = @"客户咨询";
                break;
            case 1:
                cell.textLabel.text = @"常见问题";
                break;
            case 2:
                cell.textLabel.text = @"用户协议";
                break;
            default:
                break;
        }
        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0) {
        YMClientController *controller = [[YMClientController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }else if(indexPath.row == 1){
        YMQuestionController *controller = [[YMQuestionController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        YMNegotiateController *controller = [[YMNegotiateController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
-(void)footButtonClick
{
    NSLog(@"footButtonClick");
}
@end
