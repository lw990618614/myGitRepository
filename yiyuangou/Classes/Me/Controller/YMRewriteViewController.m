//
//  YMRewriteViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMRewriteViewController.h"
#import "YMAcceptViewController.h"
#import "YMTextFieldInputHandle.h"
@interface YMRewriteViewController()<UITextFieldDelegate,UIActionSheetDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UITextField *contactField;
    UITextField *phoneField;
    UITextField *placeField;
    UITextField *postField;
    UITextField *bigPlace;
}
@property(nonatomic,strong)UIView *rewriteView;
@property (nonatomic ,strong)UIButton *sureButton;
@property (strong, nonatomic) NSDictionary *pickerDic;
@property (strong, nonatomic) NSArray *provinceArray;
@property (strong, nonatomic) NSArray *cityArray;
@property (strong, nonatomic) NSArray *townArray;
@property (strong, nonatomic) NSArray *selectedArray;
@property (strong, nonatomic) UIPickerView *myPicker;
@property(nonatomic,strong) NSString *bigPlaceStr; //地址字符串
@end

@implementation YMRewriteViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"编辑地址";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteClick)];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-64- 100) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    [self getPickerData];

    
    contactField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    contactField.delegate = self;;
    contactField.placeholder = @"请输入联系人";
    contactField.keyboardType = UIKeyboardTypeDefault;
    contactField.clearButtonMode = YES;
    contactField.returnKeyType = UIReturnKeyDone;
    contactField.text   = self.addressDic[@"linkman"];
    [contactField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [contactField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    contactField.textColor = [UIColor heightBlacKColor];
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    phoneField.delegate = self;;
    phoneField.placeholder = @"请输入联系电话";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = YES;
    phoneField.returnKeyType = UIReturnKeyDone;
    phoneField.text = self.addressDic[@"phone"];
    [phoneField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phoneField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    phoneField.textColor = [UIColor heightBlacKColor];

    //省市县
    bigPlace = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    bigPlace.delegate = self;;
    bigPlace.placeholder = @"省 市 县";
    bigPlace.keyboardType = UIKeyboardTypeDefault;
    bigPlace.clearButtonMode = YES;
    bigPlace.returnKeyType = UIReturnKeyDone;
    [bigPlace setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [bigPlace setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    bigPlace.textColor = [UIColor heightBlacKColor];
    
    self.myPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 216, kWIDTH, 216)];
    self.myPicker.delegate = self;
    self.myPicker.dataSource = self;

    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor heightBlacKColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(kWIDTH - 100, 0, 80, 30)];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor heightBlacKColor] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:leftBtn];
    [bgView addSubview:rightBtn];
    bigPlace.inputView = self.myPicker;
    bigPlace.inputAccessoryView = bgView;
//    bigPlace.text = self.addressDic[@"scope"];
    //设置默认显示
    NSString *scope = self.addressDic[@"scope"];
    NSArray *addressArray =  [scope componentsSeparatedByString:@":"];
    if (addressArray.count == 3)
    {
        if ([addressArray[0] isEqualToString:addressArray[1]])
         {
          bigPlace.text = [NSString stringWithFormat:@"%@%@",addressArray[0],addressArray[2]];
        }
       else
        {

        bigPlace.text = [self.addressDic[@"scope"] stringByReplacingOccurrencesOfString:@":" withString:@""];

         }
    }
    if (addressArray.count > 1)
    {
        NSString *province  = addressArray[0];
        NSString *city = addressArray[1];
        NSString *area = addressArray[2];
        NSUInteger proviceIndex =  [self.provinceArray indexOfObject:province];
        NSInteger  cityIndex;
        NSUInteger townIndex;
        self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:proviceIndex]];
        
        if (self.selectedArray.count > 0) {
            
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
            cityIndex =  [self.cityArray indexOfObject:city];
        }
        
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:cityIndex]];
            townIndex = [self.townArray indexOfObject:area];
        }
        if (proviceIndex < 1000) {
            [self.myPicker selectRow:proviceIndex inComponent:0 animated:YES];
            [self.myPicker reloadComponent:1];
        }
        if (cityIndex < 1000) {
            [self.myPicker selectRow:cityIndex inComponent:1 animated:YES];
            [self.myPicker reloadComponent:2];
        }
        if (townIndex < 1000) {
            [self.myPicker selectRow:townIndex inComponent:2 animated:YES];
        }
    }
  
    
    placeField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    placeField.delegate = self;;
    placeField.placeholder = @"请输入详细地址";
    placeField.keyboardType = UIKeyboardTypeDefault;
    placeField.clearButtonMode = YES;
    placeField.returnKeyType = UIReturnKeyDone;
    placeField.text = self.addressDic[@"address"];
    [placeField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [placeField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    placeField.textColor = [UIColor heightBlacKColor];

    postField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    postField.delegate = self;;
    postField.placeholder = @"请输入邮政编码";
    postField.keyboardType = UIKeyboardTypeNumberPad;
    postField.clearButtonMode = YES;
    postField.returnKeyType = UIReturnKeyDone;
    NSString *postCode = self.addressDic[@"postalcode"];
    if (![self.addressDic[@"postalcode"] isValid]) {
        postCode = @"";
    }
    postField.text = [NSString stringWithFormat:@"%@",postCode];
    [postField setValue:[UIColor lightColor] forKeyPath:@"_placeholderLabel.textColor"];
    [postField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    postField.textColor = [UIColor heightBlacKColor];

    self.rewriteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];

    self.sureButton = [UIButton buttonWithFrame:CGRectMake(10, 50, kWIDTH - 10*2, 50) target:self action:@selector(sureClick) title:@"保存" cornerRadius:2];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.sureButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
    self.sureButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [self.rewriteView addSubview:self.sureButton];
    [self.view addTap];
    self.tableView.tableFooterView = self.rewriteView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
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
            [cell.contentView addSubview:bigPlace];
            break;
        case 3:
            [cell.contentView addSubview:placeField];
            break;
        case 4:
            cell.textLabel.text =@"邮政编码";
            [cell.contentView addSubview:postField];
            break;
        default:
            break;
    }
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
    NSString *bigAddress =     self.bigPlaceStr;
 
    //失去焦点
    [contactField resignFirstResponder];
    [placeField resignFirstResponder];
    [postField resignFirstResponder];
    [phoneField resignFirstResponder];
    //判断电话是否正确
    if (![phoneNum isValidPhoneNumber]) {
        [self.view makeToast:@"请输入正确的手机号码"];
        return;
    }
    if (![post isValidCode] && [post isValid]) {
        [self.view makeToast:@"请输入正确的邮政编码"];
        return;
    }
    if (![address isValidAdress]) {
        [self.view makeToast:@"请输入正确的联系地址\n联系地址在30个字符以内"];
        return;
    }
    if(![contactName isValid] || contactField.text.length > 10 )
    {
        [self.view makeToast:@"请输入正确的联系人姓名\n最多10个字符"];
        return;
    }
    if (![bigPlace.text isValid]) {
        [self.view makeToast:@"请输入联系地址"];
        return;
    }
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    [dict setValue:contactName forKey:@"linkman"];
    [dict setValue:phoneNum forKey:@"phone"];
    [dict setValue:address forKey:@"address"];
    [dict setValue:post forKey:@"postCode"];
    [dict setValue:bigAddress forKey:@"scope"];
    [dict setValue:self.addressDic[@"uaid"] forKey:@"uaid"];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/address/edit"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];

    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            [weakSelf.view makeToast:@"修改地址成功"];
            YMAcceptViewController *accept =  (YMAcceptViewController *)self.addListViewController;
            [accept  refreshData:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)deleteClick
{
    [contactField resignFirstResponder];
    [placeField resignFirstResponder];
    [phoneField resignFirstResponder];
    [postField resignFirstResponder];
    
    UIActionSheet *sheet  =[[UIActionSheet alloc] initWithTitle:@"确定删除该地址吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:nil, nil];
    [sheet showInView:self.view];
    NSLog(@"deleteClick");
}
-(void) delArress
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/address/delete"];
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    [dict setValue:self.addressDic[@"uaid"] forKey:@"uaid"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];
    
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];
        
        NSDictionary *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            NSLog(@"删除地址成功");
            [weakSelf.view makeToast:@"删除地址成功"];
            YMAcceptViewController *accept =  (YMAcceptViewController *)self.addListViewController;
            [accept  refreshData:nil];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark ----ActionSheetDelegate ---
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [self delArress];
        [self.navigationController popViewControllerAnimated:YES];
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
        if(![phoneField.text isValidPhoneNumber])
        {
            [self.view makeToast:@"请输入正确的手机号码" duration:1.5 position:pointValue];
        }
        
    }
    else if (contactField == textField)
    {
        
        if(![contactField.text isValid] || contactField.text.length > 10 )
        {
            [self.view makeToast:@"请正确填写姓名\n最多10个字符" duration:1.5 position:pointValue];
            
        }
        
        
    }
    else if (postField == textField)
    {
        if (![postField.text isValidCode] && [postField.text isValid]) {
            [self.view makeToast:@"请正确填写邮政编码" duration:1.5 position:pointValue];
            return;
        }
    }
    else if (placeField == textField)
    {
        
        if (![placeField.text isValidAdress])
        {
            [self.view makeToast:@"请输入正确的联系地址\n最多30个字符" duration:1.5 position:pointValue];
            return;
        }
    }
}
#pragma mark - get data
- (void)getPickerData {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Address" ofType:@"plist"];
    self.pickerDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    self.provinceArray = [self.pickerDic allKeys];
    self.selectedArray = [self.pickerDic objectForKey:[[self.pickerDic allKeys] objectAtIndex:0]];
    
    if (self.selectedArray.count > 0) {
        self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
    }
    
    if (self.cityArray.count > 0) {
        self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
    }
    
}
#pragma mark - UIPicker Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return self.townArray.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row];
    } else {
        return [self.townArray objectAtIndex:row];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 0) {
        return 110;
    } else if (component == 1) {
        return 100;
    } else {
        return 110;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = [self.pickerDic objectForKey:[self.provinceArray objectAtIndex:row]];
        if (self.selectedArray.count > 0) {
            self.cityArray = [[self.selectedArray objectAtIndex:0] allKeys];
        } else {
            self.cityArray = nil;
        }
        if (self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:0]];
        } else {
            self.townArray = nil;
        }
    }
    [pickerView selectedRowInComponent:1];
    [pickerView reloadComponent:1];
    [pickerView selectedRowInComponent:2];
    
    if (component == 1) {
        if (self.selectedArray.count > 0 && self.cityArray.count > 0) {
            self.townArray = [[self.selectedArray objectAtIndex:0] objectForKey:[self.cityArray objectAtIndex:row]];
        } else {
            self.townArray = nil;
        }
        [pickerView selectRow:1 inComponent:2 animated:YES];
    }
    
    [pickerView reloadComponent:2];
}
#pragma mark ---取消  确定---
-(void) leftBtnAction:(id) sender
{
    [bigPlace resignFirstResponder];
}
-(void) rightBtnAction:(id)sender
{
    

    NSString *province  =  [self.provinceArray objectAtIndex:[self.myPicker selectedRowInComponent:0]];
    NSString *city = [self.cityArray objectAtIndex:[self.myPicker selectedRowInComponent:1]];
    
    //停止滚动的时候才输入
    NSArray   *cityArray =  [self.pickerDic objectForKey:province];
    NSString *area = [self.townArray objectAtIndex:[self.myPicker selectedRowInComponent:2]];

    NSDictionary *cityDict = cityArray[0];
    if (![[cityDict allKeys] containsObject:city]) {
        [self.view makeToast:@"请选择正确的地址"];

        return;
    }
    NSArray *townArray = cityDict[city];
    if (![townArray containsObject:area]) {
        [self.view makeToast:@"请选择正确的地址"];

        return;
    }
    
    NSString *adrees ;
    [bigPlace resignFirstResponder];
    if ([city isEqualToString:province]) {
        adrees = [NSString stringWithFormat:@"%@%@",province,area];
    }
    else
    {
        adrees = [NSString stringWithFormat:@"%@%@%@",province,city,area];
        
    }
    bigPlace.text = adrees;
    self.bigPlaceStr = [NSString stringWithFormat:@"%@:%@:%@",province,city,area];

}
@end