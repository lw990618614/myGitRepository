//
//  YMPayController.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPayController.h"
@interface YMPayController()
@property (nonatomic,strong)NSArray *titleArry;
@property (nonatomic,strong)UIView *footerView1;

@end

@implementation YMPayController
-(UIView *)footerView1
{
    if (_footerView1 == nil) {
        _footerView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];
    }
    return _footerView1;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"调教订单";
    self.titleArry = [[NSArray alloc] initWithObjects:@"微信支付",@"支付宝支付",@"银联支付支付",nil];
    UIButton *payButton = [UIButton buttonWithFrame:CGRectMake(10, 25, kWIDTH- 20, 50) target:self action:@selector(btnClick) title:@"确认支付" cornerRadius:2];
    [self.footerView1 addSubview:payButton];
    payButton.backgroundColor = [UIColor redColor];
    [payButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else{
        return 4;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        return 60;
    }else{
        if (indexPath.row == 0) {
            return 60;
        }else{
            return 44;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.001;
    }else{
        return 10;
    }
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 100;
    }else{
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footerView1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *payViewCell = @"payViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:payViewCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payViewCell];
        UIImageView*accessoryImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        cell.accessoryView=accessoryImageView;
    }else{
        while ([cell.contentView.subviews lastObject] != nil) {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];  //
        }
    }

    if (indexPath.section == 0) {
        cell.textLabel.text = @"奖品合计";
        return cell;
    }else{
        if (indexPath.row == 0) {
            cell.textLabel.text = @"使用第三方平台支付";
            return cell;

        }else if(indexPath.row == 1){
            UIImageView*accessoryView=(UIImageView*)cell.accessoryView;
            accessoryView.image=[UIImage imageNamed:@"searchSelIcon"];
        }else{
            UIImageView*accessoryView=(UIImageView*)cell.accessoryView;
            accessoryView.image=[UIImage imageNamed:@"round"];
        }
        cell.imageView.image = [UIImage imageNamed:@"main_location"];
        cell.textLabel.text = self.titleArry[indexPath.row-1];
        return cell;

    }
}

-(void)btnClick
{
    NSLog(@"ndfdf");
}
@end
