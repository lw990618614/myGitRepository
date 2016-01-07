//
//  YMVirtualGoodsViewController.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/20.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMVirtualGoodsViewController.h"
#import "YMReceiveListController.h"
@interface YMVirtualGoodsViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate>
{
    UITableView *mainTableView;
    UITextField *phoneTextFiled;
    UITextField *QQTextFiled;
    UIView      *footView;
    NSArray     *virtualReward;
}
@end

@implementation YMVirtualGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"领取奖励";
    virtualReward = @[@"手机号",@"QQ号"];
    [self initWithSubViews];
    // Do any additional setup after loading the view.
}

-(void) initWithSubViews
{
    self.navigationItem.leftBarButtonItem =  [self backItemRecevice];
    self.view.backgroundColor = kViewControllerBackgroundColor;
    mainTableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - kNav) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.backgroundColor = [UIColor clearColor];
    [mainTableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:mainTableView];
    //手机号码
    phoneTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, kWIDTH - 80 - 15,24 )];
    phoneTextFiled.font = [UIFont systemFontOfSize:15];
    phoneTextFiled.textColor = [UIColor heightBlacKColor];
    phoneTextFiled.clearButtonMode =  YES;
    phoneTextFiled.placeholder =  @"请输入手机号码";
    phoneTextFiled.delegate = self;
    phoneTextFiled.keyboardType = UIKeyboardTypeNumberPad;//设置键盘类型
    [phoneTextFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    NSString *key = [NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),@"phone"];
    phoneTextFiled.text = [[YMInfoCenter sharedManager] mobile:key];

    //QQ号码
    QQTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(80, 10, kWIDTH - 80 - 15,24 )];
    QQTextFiled.font = [UIFont systemFontOfSize:15];
    QQTextFiled.textColor = [UIColor heightBlacKColor];
    QQTextFiled.clearButtonMode =  YES;
    QQTextFiled.delegate = self;
    QQTextFiled.placeholder =  @"请输入QQ号码";
    QQTextFiled.keyboardType = UIKeyboardTypeNumberPad;//设置键盘类型
    [QQTextFiled setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [QQTextFiled setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    key = [NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),@"qq"];
    QQTextFiled.text = [YMInfoCenter getforkey:key];
    //footView
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 120)];
    UILabel *deslbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, kWIDTH - 15*2, 35)];
    deslbl.text = @"手机号码用于手机话费,支付宝红包中奖后的充值,QQ号码用于Q币中奖后的充值";
    deslbl.font = [UIFont systemFontOfSize:12.0];
    deslbl.textColor = [UIColor lightColor];
    deslbl.numberOfLines =  2;
    [footView addSubview:deslbl];
    deslbl.backgroundColor = [UIColor clearColor];

    UIButton *saveBtn = [UIButton buttonWithFrame:CGRectMake(15, deslbl.tmri_bottom + 10, deslbl.width, 42) target:self action:@selector(saveBtnAction:) title:@"保存" cornerRadius:1];
    saveBtn.backgroundColor = [UIColor redColor];
    saveBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [footView addSubview:saveBtn];
    footView.backgroundColor = [UIColor clearColor];
}

#pragma mark -----------tableViewDelegate and  DataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return virtualReward.count;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    static NSString *identifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    if (indexPath.row == 0) {
        [cell.contentView addSubview:phoneTextFiled];
    }
    else if(indexPath.row == 1)
    {
        [cell.contentView addSubview:QQTextFiled];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor heightBlacKColor];
    cell.textLabel.text = virtualReward[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
//领取奖励
-(void)saveBtnAction:(id) sender
{
    BOOL isReturn = NO;
    if (![[phoneTextFiled.text trim] isValidPhoneNumber] && [phoneTextFiled.text trim].length > 0) {
        [self.view makeToast:@"电话号码错误"];
        return;
    }
    if (![[QQTextFiled.text trim] isValid] && [QQTextFiled.text trim].length > 0) {
        [self.view makeToast:@"请输入QQ号码"];
        return;
    }
    if([[QQTextFiled.text trim] isValidQQ])
    {
        isReturn = YES;
    }
    if ([[phoneTextFiled.text trim] isValidPhoneNumber]) {
        isReturn  = YES;
    }
    if (!isReturn) {
        [self.view makeToast:@"手机号码与QQ号码至少填写一项"];
        return;
    }
    NSString *phone = [phoneTextFiled.text trim];
    NSString *qq = [QQTextFiled.text trim];

    NSString *key = [NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),@"phone"];
    [YMInfoCenter savestr:phone forkey:key];
    key = [NSString stringWithFormat:@"%@%@",NSStringFromClass([self class]),@"qq"];
    [YMInfoCenter savestr:qq forkey:key];
    [self.view makeToastActivity:kLoadingText];
    SAFE;
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    [dict setValue:self.goodsDic[@"grid"] forKey:@"grid"];
    [dict setValue:[phoneTextFiled.text trim] forKey:@"phone"];
    [dict setValue:[QQTextFiled.text trim] forKey:@"qqNumber"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/get"];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];
        
        NSDictionary *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            //提交申请
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提交成功!" message:@"请等待工作人员充值" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alertView.tag = 202;
            [alertView show];        }
    } failure:^(NSError *error) {
        
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------TextFieldDelegate-----
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSUInteger maxLength;
    if (textField == phoneTextFiled) {
        maxLength = 12;
    }
    else if (textField == QQTextFiled)
    {
        maxLength = 12;
    }
    else
     return YES;
    return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:maxLength];

}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == phoneTextFiled) {
        NSString *phone = [phoneTextFiled.text trim];
        if (![phone isValidPhoneNumber]) {
            [self.view makeToast:@"电话号码错误"];
        }
    }
}
#pragma mark ------UIAlertDelegate---
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSArray *viewcontrollers =  self.navigationController.viewControllers;
        UIViewController *vc ;
        for (UIViewController *v in viewcontrollers) {
            if ([v isKindOfClass:[YMReceiveListController class]]) {
                vc =  v;
                break;
            }
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:ReceiveList object:nil];
        [self.navigationController popToViewController:vc animated:YES];
    }
}
-(UIBarButtonItem *) backItemRecevice
{
    UIImage *btnImage = [UIImage imageNamed:@"nav_back"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popSelfToRecevice:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return barBtn;
}
- (void)popSelfToRecevice:(id)sender{
    NSArray *viewcontrollers =  self.navigationController.viewControllers;
    UIViewController *vc ;
    for (UIViewController *v in viewcontrollers) {
        if ([v isKindOfClass:[YMReceiveListController class]]) {
            vc =  v;
            break;
        }
    }
    
    [self.navigationController popToViewController:vc animated:YES];
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
