//
//  YMCreatePlaceController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCreatePlaceController.h"
#import "YMTextFieldInputHandle.h"
@interface YMCreatePlaceController()<UITextFieldDelegate>
{
    UITextField *contactField;
    UITextField *phoneField;
    UITextField *placeField;
    UITextField *postField;
    
}
@property(nonatomic,strong)UIView *rewriteView;
@property (nonatomic ,strong)UIButton *sureButton;
@end

@implementation YMCreatePlaceController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"新增地址";
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-64- 4 *44) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    
    contactField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    contactField.delegate = self;;
    contactField.placeholder = @"您的姓名";
    contactField.keyboardType = UIKeyboardTypeDefault;
    contactField.clearButtonMode = YES;
    contactField.returnKeyType = UIReturnKeyDone;
    contactField.textColor = [UIColor heightBlacKColor];

    [contactField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [contactField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    phoneField.delegate = self;;
    phoneField.placeholder = @"您的手机号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = YES;
    phoneField.returnKeyType = UIReturnKeyDone;
    [phoneField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    phoneField.textColor = [UIColor heightBlacKColor];

    placeField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    placeField.delegate = self;;
    placeField.placeholder = @"你的收货详细地址";
    placeField.keyboardType = UIKeyboardTypeDefault;
    placeField.clearButtonMode = YES;
    placeField.returnKeyType = UIReturnKeyDone;
    [placeField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [placeField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    placeField.textColor = [UIColor heightBlacKColor];


    postField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    postField.delegate = self;;
    postField.placeholder = @"选填";
    postField.keyboardType = UIKeyboardTypeNumberPad;
    postField.clearButtonMode = YES;
    postField.returnKeyType = UIReturnKeyDone;
    [postField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [postField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    postField.textColor = [UIColor heightBlacKColor];

    self.rewriteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];
    
    self.sureButton = [UIButton buttonWithFrame:CGRectMake(10, 50, kWIDTH - 20, 50) target:self action:@selector(sureClick) title:@"保存" cornerRadius:2];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rewriteView addSubview:self.sureButton];
    [self.sureButton setBackgroundColor:[UIColor  colorWithHex:@"#DD2727"]];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    self.rewriteView.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView = self.rewriteView;
    [self.view addTap];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *acceptCell = @"acceptCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acceptCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:acceptCell];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text =@"联系人";
            [cell.contentView addSubview:contactField];
            break;
        case 1:
            cell.textLabel.text =@"联系电话";
            [cell.contentView addSubview:phoneField];
            break;
        case 2:
            cell.textLabel.text =@"联系地址";
            [cell.contentView addSubview:placeField];
            break;
        case 3:
            cell.textLabel.text =@"联系编码";
            [cell.contentView addSubview:postField];
            break;
        default:
            break;
    }
    cell.textLabel.textColor  = [UIColor heightBlacKColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)sureClick
{
    NSString *contactName = [contactField.text trim];
    NSString *phoneNum = [phoneField.text trim];
    NSString *address =[placeField.text trim];
    NSString *post = [postField.text trim];
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    
    //失去焦点
    [contactField resignFirstResponder];
    [placeField resignFirstResponder];
    [postField resignFirstResponder];
    [phoneField resignFirstResponder];
    
    //判断电话是否正确
    //判断电话是否正确
    if (![phoneNum isValidPhoneNumber]) {
        [self.view makeToast:@"手机号码错误"];
        return;
    }
    if (![post isValidCode] && [post isValid]) {
        [self.view makeToast:@"邮政编码错误"];
        return;
    }
    if (![address isValidAdress]) {
        [self.view makeToast:@"联系地址长度过长"];
        return;
    }
    if(![contactName isValidUserName] )
    {
        [self.view makeToast:@"联系人姓名为空或者包含特殊字符"];
        return;
    }
    if (contactName.length  > 10) {
        [self.view makeToast:@"联系人姓名过长"];
        return;
    }
 

    [dict setValue:contactName forKey:@"linkman"];
    [dict setValue:phoneNum forKey:@"phone"];
    [dict setValue:address forKey:@"address"];
    [dict setValue:post forKey:@"postCode"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/address/add"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];

    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSDictionary *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            NSLog(@"新增地址成功");
            [weakSelf.addListViewController  refreshData:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark ---textFiled--
/**
 textField 中的文本是否是可以替换的
 range     当前选中的范围(删除长度范围为1 插入长度的访问0)
 string    将被插入的文本
 */
/**
 textField 中的文本是否是可以替换的
 range     当前选中的范围(删除长度范围为1 插入长度的访问0)
 string    将被插入的文本
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == phoneField) {
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:12];
    }
    else if (textField == postField)
        return [YMTextFieldInputHandle isInputText:textField range:range replaceStr:string maxLegnth:7];
    return YES;
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    CGPoint center = CGPointMake(kWIDTH /2.0, 200);
    NSValue *pointValue = [NSValue valueWithCGPoint:center];
    if (textField == phoneField) {
        if (![[phoneField.text trim] isValidPhoneNumber]) {
            [self.view makeToast:@"电话号码格式不对" duration:1.5 position:pointValue];
            return;
        }
        if ([[phoneField.text trim] isValid]) {
            [self.view makeToast:@"电话号码为空" duration:1.5 position:pointValue];
            return;
        }
        
    }
    else if (contactField == textField)
    {
        if ([contactField.text length] ) {
            if(![contactField.text isValid] )
            {
                [self.view makeToast:@"联系人姓名为空" duration:1.5 position:pointValue];
                return;
            }
            
            if (contactField.text.length  > 10) {
                [self.view makeToast:@"联系人姓名过长" duration:1.5 position:pointValue];
                return;
            }
        }
    }
    else if (postField == textField)
    {
        if (![postField.text isValidCode] && [postField.text isValid]) {
            [self.view makeToast:@"邮政编码错误" duration:1.5 position:pointValue];
            return;
        }
    }
    else if (placeField == textField)
    {
        
        if (![placeField.text isValidAdress]) {
            [self.view makeToast:@"联系地址需要为30位以内" duration:1.5 position:pointValue];
            return;
        }
    }
}
@end