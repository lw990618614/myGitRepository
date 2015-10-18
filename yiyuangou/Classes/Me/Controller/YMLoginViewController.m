//
//  YMLoginViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMLoginViewController.h"
#import "MySettingViewController.h"
#import "YMLoginCell.h"
@interface YMLoginViewController()<UITextFieldDelegate>
{
    UITextField *telephoneFiled;
    UITextField *passwordFiled;
    UIView *footerView;
}
@end
@implementation YMLoginViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    telephoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kWIDTH - 110, 40)];
    telephoneFiled.keyboardType = UIKeyboardTypeNumberPad;
    telephoneFiled.placeholder = @"请输入手机号码";
    telephoneFiled.clearButtonMode = YES;
    telephoneFiled.delegate = self;
    
    passwordFiled = [[UITextField alloc] initWithFrame:CGRectMake(45, 0, kWIDTH - 110, 40)];
    passwordFiled.keyboardType = UIKeyboardTypeNumberPad;
    passwordFiled.placeholder = @"请输入密码";
    passwordFiled.clearButtonMode = YES;
    passwordFiled.delegate = self;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self creatFooterView];
    
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
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footerView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=2) {
        static NSString *loglinCell = @"loglinCell";
        YMLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:loglinCell];
        if (cell == nil) {
            cell = [[YMLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loglinCell];
        }
        if (indexPath.row == 0) {
            cell.iconView.image = [UIImage imageNamed:@"icon_name"];
            [cell.loginView addSubview:telephoneFiled];
        }else if (indexPath.row == 1){
            cell.iconView.image = [UIImage imageNamed:@"icon_password"];
            [cell.loginView addSubview:passwordFiled];
        }
        return cell;

    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(10, 20, kWIDTH -20, 40) target:self action:@selector(loginButtonClick) title:@"登录" cornerRadius:1];
        loginButton.backgroundColor = [UIColor redColor];
        [cell.contentView addSubview:loginButton];
        return cell;
    }
    return nil;
}
-(void)loginButtonClick
{
    [self setHidesBottomBarWhenPushed:NO];
    MySettingViewController *controller = [[MySettingViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];

    NSLog(@"登录");
}
-(void)creatFooterView
{
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];
    UILabel *registerLable = [UILabel labelWithFrame:CGRectMake(10, 20, 60, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    registerLable.text =@"快速注册";
    registerLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(registerClick)];
    [registerLable addGestureRecognizer:gesture];
    [footerView addSubview:registerLable];
    
    UILabel *passworldLable = [UILabel labelWithFrame:CGRectMake(kWIDTH - 70, 20, 60, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    passworldLable.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(passworldClick)];
    [passworldLable addGestureRecognizer:gesture1];
    passworldLable.text =@"忘记密码";
    [footerView addSubview:passworldLable];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 2) {
    }
}
-(void)registerClick{
    NSLog(@"快速");
}
-(void)passworldClick
{
    NSLog(@"快速");

}
@end
