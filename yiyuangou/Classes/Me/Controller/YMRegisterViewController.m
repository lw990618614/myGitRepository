//
//  YMRegisterViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMRegisterViewController.h"
#import "YMSetPassWordController.h"
#import "YMLoginCell.h"
#import "YMPassWordCell.h"
#import "LoginManager.h"
#import "YMVerfyResult.h"
#import "YMWebViewController.h"
#import "YMAcceptViewController.h"
#import "YMTextFild.h"
#import "UILabel+convenice.h"
#import "YMVirtualGoodsViewController.h"
#define kMax 60
#define KMAXLength 12
#define KMaxLengthVerCode 7
@interface YMRegisterViewController()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *telephoneFiled;
    YMTextFild *passwordFiled;
    UIView *footerView;
    UIButton *testButton;
    UIButton    *verfiyCodeBtn;
    YMVerfyResult *verifyResult;
    UITableView *mainTableView;
    NSTimer     *timer;
    int  sec;
    BOOL      isAgreen;
    NSString  *agreementAddress;
}
@end
@implementation YMRegisterViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kViewControllerBackgroundColor;
    self.title =self.titleName;
    UIImageView *phoneImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    phoneImg.image = [UIImage imageNamed:@"phone"];
    verfiyCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 110, 30)];
    [verfiyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [verfiyCodeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    verfiyCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [verfiyCodeBtn addTarget:self action:@selector(verifyNumber) forControlEvents:UIControlEventTouchUpInside];
    
    telephoneFiled = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 40)];
    telephoneFiled.keyboardType = UIKeyboardTypeNumberPad;
    telephoneFiled.placeholder = @"请输入手机号码";
    telephoneFiled.clearButtonMode = YES;
    telephoneFiled.delegate = self;
    telephoneFiled.leftView = phoneImg;
    telephoneFiled.rightView =verfiyCodeBtn;
    telephoneFiled.leftViewMode = UITextFieldViewModeAlways;
    telephoneFiled.rightViewMode = UITextFieldViewModeAlways;
    [telephoneFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [telephoneFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    passwordFiled = [[YMTextFild alloc] initWithFrame:CGRectMake(0, 0,  kWIDTH , 40)];
    passwordFiled.keyboardType = UIKeyboardTypeNumberPad;
    passwordFiled.placeholder = @"请输入验证码";
    passwordFiled.clearButtonMode = YES;
    passwordFiled.delegate = self;
    passwordFiled.leftViewMode = UITextFieldViewModeAlways;
    passwordFiled.rightViewMode =UITextFieldViewModeAlways;
    [passwordFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passwordFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    
    UIImageView *CodeImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    CodeImg.image = [UIImage imageNamed:@"code"];
    passwordFiled.leftView = CodeImg;
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - kNav) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    [mainTableView setTableFooterView: [[UIView alloc]initWithFrame:CGRectZero]];
    [self.view addSubview:mainTableView];
    
    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];
//    mainTableView.tableFooterView = footerView;
    //验证手机
    UIButton *regesterButton = [UIButton buttonWithFrame:CGRectMake(10, 15, kWIDTH -20, 40) target:self action:@selector(registerButtonClick) title:@"验证手机 " cornerRadius:1];
    regesterButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
    [footerView addSubview:regesterButton];
    isAgreen = YES;
    //同意一元购协议
    UIButton *agreenBtn = [[UIButton alloc] initWithFrame:CGRectMake(regesterButton.orignX, regesterButton.tmri_bottom + 5, regesterButton.width, 30)];
    [agreenBtn setTitle:@"我已经阅读同意" forState:UIControlStateNormal];
    agreenBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    agreenBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [agreenBtn setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
    agreenBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
//    agreenBtn.enabled =  YES;
    [agreenBtn addTarget:self action:@selector(agreenProAction:) forControlEvents:UIControlEventTouchUpInside];
    [agreenBtn setTitleColor:[UIColor lightColor] forState:UIControlStateNormal];
    
    UILabel *protolbl = [[UILabel alloc] initWithFrame:CGRectMake(115,0, 130, agreenBtn.height)];
    protolbl.font  = [UIFont systemFontOfSize:14.0];
    protolbl.text =  @"《99夺宝协议》";
    [agreenBtn addSubview:protolbl];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [protolbl addGestureRecognizer:tap];
    protolbl.userInteractionEnabled = YES;
    [tap addTarget:self action:@selector(readProtol:)];
    footerView.backgroundColor = [UIColor clearColor];
    [footerView addSubview:agreenBtn];
//    footerView.backgroundColor = [UIColor redColor];
    
    if ([mainTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [mainTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([mainTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [mainTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    mainTableView.backgroundColor = [UIColor clearColor];
    //设置定时器
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeStatus:) userInfo:self repeats:YES];
    //暂停定时器
    [timer setFireDate:[NSDate distantFuture]];
    sec = kMax;
    [self.view addTap];
    [self leftItem];
    [self loadData];
}
-(void) leftItem
{
    if (self.method == YMRegistUser && !self.isFromLogin) {
        UIBarButtonItem *leftItem  =[[ UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancellAction:)];
        self.navigationItem.leftBarButtonItem =  leftItem;
    }

}
-(void)cancellAction:(id) sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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
    return 41;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *loglinCell = @"loglinCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loglinCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loglinCell];
            [cell.contentView addSubview:telephoneFiled];
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(kWIDTH - 114, 5, 1,30)];
            line.backgroundColor = [UIColor lightColor];
            [cell addSubview:line];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor  = [UIColor whiteColor];
        return cell;
    }else if (indexPath.row == 1){
        static NSString *passWordCell = @"passWordCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:passWordCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:passWordCell];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:passwordFiled];
        return cell;

    }
    return nil;
}
-(void)registerButtonClick
{
    [telephoneFiled resignFirstResponder];
    [passwordFiled resignFirstResponder];
    if (!isAgreen) {
        [self.view makeToast:@"请同意99夺宝协议"];
        return;
    }
    if (![telephoneFiled.text isValidPhoneNumber]) {
        [self.view makeToast:@"您的手机号码有误"];
        return;
    }
    //绑定手机
    if (self.method == YMBindPhone)
    {
        if ([telephoneFiled.text isEqualToString:verifyResult.mobile]&&[passwordFiled.text isEqualToString:verifyResult.verifyCode])
        {
            [self saveAction:nil];
        }
        else
        {
            [self.view makeToast:@"您的验证码有误,请查证"];
        }
    }
    //注册用户
    else if (self.method == YMRegistUser)
    {
        if ([telephoneFiled.text isEqualToString:verifyResult.mobile]&&[passwordFiled.text isEqualToString:verifyResult.verifyCode])
        {
         
            WEAKSELF;
            YMSetPassWordController *controller = [[YMSetPassWordController alloc] init];
            controller.model = verifyResult;
            controller.ways = weakSelf.method;
            [weakSelf.navigationController pushViewController:controller animated:YES];
        }
       else
       {
           [self.view makeToast:@"您的验证码有误,请查证"];
       }
    }
    //重置密码
    else if(self.method == YMRestPhone)
    {
        if ([telephoneFiled.text isEqualToString:verifyResult.mobile]&&[passwordFiled.text isEqualToString:verifyResult.verifyCode])
        {
            YMSetPassWordController *controller = [[YMSetPassWordController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            controller.model = verifyResult;
            controller.ways = self.method;

            [self.navigationController pushViewController:controller animated:YES];
        }
        else
        {
            [self.view makeToast:@"您的验证码有误,请查证"];
        }
    }

}
//更改用户信息
-(void)saveAction:(id) sender
{
    [telephoneFiled resignFirstResponder];
    NSString *str = @"/user/updateInfo";
    NSString *tep = [telephoneFiled.text trim];
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    NSArray *dataArray = [[NSMutableArray alloc]init];
    //判断电话是否正确
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,str];
    [dict setValue:tep forKey:@"mobile"];
    WEAKSELF;
    [YMBaseHttpTool POST:url params:dict name:@"_face" data:dataArray success:^(id result) {
        NSDictionary *dict = [result keyValues];

        if ([dict[@"code"] integerValue] == 0) {
            YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
            YMUser *mainUser = infoCenter.mainUser;
            mainUser.YMUserMobile = tep;
            mainUser.YMAccount =  tep;
            [weakSelf.view makeToast:@"绑定手机成功"];
            
            YMBaseViewController *baseViewController;
            //虚拟货币
            if ([weakSelf.rewardDic[@"pattern"] integerValue] == 2) {
                YMVirtualGoodsViewController *virtual = [[YMVirtualGoodsViewController alloc] init];
                weakSelf.hidesBottomBarWhenPushed = YES;
                virtual.goodsDic = self.rewardDic;
                baseViewController =  virtual;
            }
            else if ([weakSelf.rewardDic[@"pattern"] integerValue] == 1)
            {
                YMAcceptViewController *accept = [[YMAcceptViewController alloc]init];
                weakSelf.hidesBottomBarWhenPushed  = YES;
                accept.type = YMRewardList;
                accept.isFromBindPhone =  YES;
                accept.rewardDic = weakSelf.rewardDic;
                baseViewController = accept;
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:ymNotificationRefreshUserInfo object:nil userInfo:@{@"type":@"bindPhone"}];
            
            [weakSelf.navigationController pushViewController:baseViewController animated:YES];
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];

        }

    } failure:^(NSError *error) {
        
        
    } uploadProgressBlock:^(float uploadPercent, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        
    }];
    
}
-(void)verifyNumber
{

    [telephoneFiled resignFirstResponder];
    if (![telephoneFiled.text isValidPhoneNumber]) {
        [self.view makeToast:@"您的手机号码有误"];
        return;
    }
    NSString *flag = nil;
    //重置密码
    if (self.method == YMRestPhone) {
        flag = @"2";
    }
    //绑定手机
    else if(self.method == YMBindPhone)
    {
        flag = @"1";
    }
    //注册用户
    else if(self.method ==YMRegistUser)
    {
        flag = @"3";
    }
    WEAKSELF;
    [timer setFireDate:[NSDate distantPast]];
    [[LoginManager sharedManager] registerStatusWithMobile:telephoneFiled.text flag:flag completion:^(id result, NSInteger statusCode, NSString *msg) {
        if (statusCode == 0) {
            verifyResult = result;
             //开启定时器

        }
        else
        {
            sec = kMax;
            verfiyCodeBtn.enabled  = YES;
            NSString *info = @"获取验证码";
            //关闭定时器
            [timer setFireDate:[NSDate distantFuture]];
            [verfiyCodeBtn setTitle:info forState:UIControlStateNormal];
            [weakSelf.view makeToast:msg];
        }
        
    }];
}
//改变状态
-(void) changeStatus:(id) sender
{
    if (sec >= 0) {
        NSString *info = [NSString stringWithFormat:@"%d秒后重新获取",sec];
        [verfiyCodeBtn setTitle:info forState:UIControlStateNormal];
        sec -- ;
        verfiyCodeBtn.enabled  = NO;
    }
    else
    {
        sec = kMax;
        verfiyCodeBtn.enabled  = YES;
        NSString *info = @"获取验证码";
        //关闭定时器
        [timer setFireDate:[NSDate distantFuture]];
        [verfiyCodeBtn setTitle:info forState:UIControlStateNormal];
    }
}
//阅读协议
-(void)readProtol:(id) sender
{
    NSLog(@"阅读协议");
    YMWebViewController *web = [[YMWebViewController alloc]initWithAddress:@"99夺宝协议" address:agreementAddress];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}
//同意协议
-(void)agreenProAction:(id) sender
{
    UIButton *btn = (UIButton *) sender;
    isAgreen = !isAgreen;
    if (isAgreen) {
        [btn setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
    }
    else
    {
        [btn setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
 
    }
}

//开始编辑
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    //开始编辑
    if (textField == telephoneFiled) {
        if (![telephoneFiled isAllNum]) {
            telephoneFiled.text = @"";
        }
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
      if (textField == telephoneFiled) {
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        BOOL change = YES;
        if ([newtxt length] >= KMAXLength) {
            change = NO;
        }
        //如果是删除的情况 则允许删除
        if (range.length == 1) {
            change = YES;
        }
        return change;
    }
    else if(textField == passwordFiled)
    {
        NSMutableString *newtxt = [NSMutableString stringWithString:textField.text];
        [newtxt replaceCharactersInRange:range withString:string];
        BOOL change = YES;
        if ([newtxt length] >= KMaxLengthVerCode) {
            change = NO;
        }
        //如果是删除的情况 则允许删除
        if (range.length == 1) {
            change = YES;
        }
        return change;
    }
    else
        return YES;

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == telephoneFiled) {
        if (![[telephoneFiled.text trim] isValidPhoneNumber]) {
            CGPoint center = CGPointMake(kWIDTH /2.0, 240);
            NSValue *pointValue = [NSValue valueWithCGPoint:center];
            [self.view makeToast:@"电话号码格式不正确" duration:1.5 position:pointValue];
        }
    }
}
//加载数据
-(void) loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/html/getResourceList"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [self.view makeToastActivity:kLoadingText];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            NSArray *itemArray =  dict[@"data"][@"htmlList"];
            for (NSDictionary *dict in itemArray) {
                if ([dict[@"shortName"] isEqualToString:@"agreement"]) {
                    agreementAddress =  dict[@"url"];
                }
            }
        }
        [weakSelf.view hideToastActivity];
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];
        
    }];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [timer invalidate];
//    verfiyCodeBtn.enabled = YES;
//    [verfiyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//    timer  = nil;
}
@end
