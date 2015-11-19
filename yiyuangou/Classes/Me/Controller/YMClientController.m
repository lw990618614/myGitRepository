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
    self.title = @"客服咨询";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    lastView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kWIDTH, 88)];
    //没能解决问题
    UILabel *titleLabel = [UILabel labelWithFrame:CGRectMake(50, 10, kWIDTH -50,22.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor heightBlacKColor ]];
    titleLabel.text = @"发送邮件吐槽产品经理吧~";
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    //客服邮箱
    UILabel *emailLbl = [UILabel labelWithFrame:CGRectMake(50, titleLabel.tmri_bottom, 80,22.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor heightBlacKColor]];
    emailLbl.text = @"客服邮箱:";
    emailLbl.font  = [UIFont systemFontOfSize:15.0];
    
    UILabel *email = [[UILabel alloc] initWithFrame:CGRectMake(emailLbl.tmri_right, emailLbl.orignY,220 , 22.5)];
    email.textColor = [UIColor blueColor];
    email.font = [UIFont systemFontOfSize:14.0];
    email.text = @"2109700078@qq.com";
    
    [lastView addSubview:titleLabel];
    [lastView addSubview:emailLbl];
    [lastView addSubview:email];
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 65;
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
            cell.imageView.image = [UIImage imageNamed:@"qqIcon"];
            cell.textLabel.text = @"客户QQ:2109700078";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"wxIcon"];
            cell.textLabel.text = @"微信公众号:youmobi";
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"emailIcon"];
            [cell.contentView addSubview:lastView];
            break;
        default:
            break;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor heightBlacKColor];
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
