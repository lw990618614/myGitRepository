//
//  YMSetPassWordController.m
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSetPassWordController.h"
#import "YMLoginViewController.h"
#import "YMLoginCell.h"
#import "LoginManager.h"
#import "YMVerfyResult.h"
#import "YMLoginViewController.h"
#import "MySettingViewController.h"
#import "MyMD5.h"
#import "YMTextFieldInputHandle.h"
@interface YMSetPassWordController()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *telephoneFiled;
    UITextField *passwordFiled;
    UITableView *mainTableView;

}
@end
@implementation YMSetPassWordController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title =@"设置密码";
    self.view.backgroundColor  = [UIColor redColor];
    telephoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 110, 40)];
    telephoneFiled.keyboardType = UIKeyboardTypeASCIICapable;
    telephoneFiled.placeholder = @"请输入新密码";
    telephoneFiled.clearButtonMode = YES;
    telephoneFiled.delegate = self;
    telephoneFiled.secureTextEntry = YES;
    
    [telephoneFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [telephoneFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    passwordFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWIDTH - 110, 40)];
    passwordFiled.keyboardType = UIKeyboardTypeASCIICapable;
    passwordFiled.placeholder = @"请再次输入";
    passwordFiled.clearButtonMode = YES;
    passwordFiled.delegate = self;
    passwordFiled.secureTextEntry  = YES;
    [passwordFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                 style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    
    [mainTableView setTableFooterView: [[UIView alloc]initWithFrame:CGRectZero]];
    
    [self.view addSubview:mainTableView];
    if ([mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTableView setLayoutMargins:UIEdgeInsetsZero];
    }
//    self.view.backgroundColor = [UIColor clearColor];
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row !=2) {
        
        static NSString *loglinCell = @"loglinCell";
        YMLoginCell *cell = [tableView dequeueReusableCellWithIdentifier:loglinCell];
        if (cell == nil) {
            cell = [[YMLoginCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loglinCell];
        }
        if (indexPath.row == 0) {
            cell.iconView.image = [UIImage imageNamed:@"code"];
            [cell.loginView addSubview:telephoneFiled];
        }else if (indexPath.row == 1){
            cell.iconView.image = [UIImage imageNamed:@"code"];
            [cell.loginView addSubview:passwordFiled];
        }
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        return cell;
        
    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        UIButton *loginButton = [UIButton buttonWithFrame:CGRectMake(10, 20, kWIDTH -20, 40) target:self action:@selector(loginButtonClick) title:@"确认" cornerRadius:1];
        loginButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [cell.contentView addSubview:loginButton];
        cell.selectionStyle  = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];

        return cell;
    }
}
-(void)loginButtonClick
{

    [passwordFiled resignFirstResponder];
    [telephoneFiled resignFirstResponder];
    if(![[passwordFiled.text trim] isValidPassword])
    {
        [self.view makeToast:[NSString stringWithFormat:@"账户密码应在6-12位之间"]];
        return;
    }
    if ([passwordFiled.text isEqualToString:telephoneFiled.text]) {
        if (self.ways == YMRegistUser) {
            YMLoginModel *model = [[YMLoginModel alloc] init];
            model.mobile = self.model.mobile;
            model.password = [passwordFiled.text trim];
            model.flag = @"0";
            WEAKSELF;
            [[LoginManager sharedManager] LoginStatusWithModle:model completion:^(id result, NSInteger statusCode, NSString *msg) {
                if (statusCode == 0) {
                    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
                    YMUser *mainUser = infoCenter.mainUser;
                    mainUser.YMAccount = weakSelf.model.mobile;
                    mainUser.YMUserPassword = [passwordFiled.text trim];
                    YMLoginViewController *loginVC = [[YMLoginViewController alloc]init];
                    [weakSelf.navigationController pushViewController:loginVC animated:YES];
                }else if(statusCode == 6){
                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"登录失败" message:@"请输入正确的帐号和密码" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                    [alterView show];
                }
            }];

        }
        else if (self.ways == YMRestPhone)
        {
            NSString *str = @"/user/updateInfo";
            NSMutableDictionary *dict  = [BaseParamDic baseParam];
            
            NSString *passwd = [telephoneFiled.text trim];
            NSString *mobile =  self.model.mobile;
            [dict setValue:mobile  forKey:@"mobile"];
            [dict setValue:passwd forKey:@"password"];
            //判断电话是否正确
            NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,str];
            WEAKSELF;
            [YMBaseHttpTool POST:url params:dict name:@"_face" data:nil success:^(id result) {
                YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
                YMUser *mainUser = infoCenter.mainUser;
                mainUser.YMAccount = weakSelf.model.mobile;
                mainUser.YMUserPassword = [passwordFiled.text trim];
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            } failure:^(NSError *error) {
                
                
            } uploadProgressBlock:^(float uploadPercent, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
                
            }];
        }


    }
    else
    {
        [self.view makeToast:@"两次密码输入不一致"];
    }

}
#pragma mark ---textFiled--
/**
 textField 中的文本是否是可以替换的
 range     当前选中的范围(删除长度范围为1 插入长度的访问0)
 string    将被插入的文本
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == telephoneFiled) {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:13];
    }
    else if (textField == passwordFiled)
    {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:13];
    }
    return YES;
    
}
@end

