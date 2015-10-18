//
//  YMClientController.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMClientController.h"
@interface YMClientController()
{
    UIView *lastView;
}
@end
@implementation YMClientController
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
    lastView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kWIDTH, 88)];
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(10, 0, kWIDTH, 44) textAlignment:NSTextAlignmentLeft textColor:[UIColor grayColor ]];
    titleLabel.text = @"没有解决疑问？发送邮件吐槽产品经理吧~";
    UIButton *footButton = [UIButton buttonWithFrame:CGRectMake(0, 44, kWIDTH, 44) target:self action:nil title:@"客户邮箱 wangzuan@youmobil.com" cornerRadius:2];
    footButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [footButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footButton setImage:[UIImage imageNamed:@"share_03"] forState:UIControlStateNormal];
    [lastView addSubview:titleLabel];
    [lastView addSubview:footButton];
    
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
    if(indexPath.row == 2){
        return 88;
    }else{
        return 44;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *coinCell = @"coinCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coinCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"share_03"];
            cell.textLabel.text = @"客户QQ 2321312312";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"share_02"];
            cell.textLabel.text = @"微信公众号 youmobi";
            break;
        case 2:
//            cell.imageView.image = [UIImage imageNamed:@"share_02"];
            [cell.contentView addSubview:lastView];
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    if (indexPath.section == 1) {
    //        if (indexPath.row == 0) {
    //            YMRuleController *controller = [[YMRuleController alloc] init];
    //            [self setHidesBottomBarWhenPushed:YES];
    //            [self.navigationController pushViewController:controller animated:YES];
    //        }
    //    }
}

@end
