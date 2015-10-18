//
//  YMCreatePlaceController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCreatePlaceController.h"

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
    contactField.keyboardType = UIKeyboardTypeASCIICapable;
    contactField.clearButtonMode = YES;
    contactField.returnKeyType = UIReturnKeyDone;
    
    phoneField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    phoneField.delegate = self;;
    phoneField.placeholder = @"您的手机号";
    phoneField.keyboardType = UIKeyboardTypeNumberPad;
    phoneField.clearButtonMode = YES;
    phoneField.returnKeyType = UIReturnKeyDone;
    
    placeField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    placeField.delegate = self;;
    placeField.placeholder = @"你的收货详细地址";
    placeField.keyboardType = UIKeyboardTypeASCIICapable;
    placeField.clearButtonMode = YES;
    placeField.returnKeyType = UIReturnKeyDone;
    
    postField = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, kWIDTH - 120, 44)];
    postField.delegate = self;;
    postField.placeholder = @"选填";
    postField.keyboardType = UIKeyboardTypeNumberPad;
    postField.clearButtonMode = YES;
    postField.returnKeyType = UIReturnKeyDone;
    
    self.rewriteView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 100)];
    self.sureButton = [UIButton buttonWithFrame:CGRectMake(10, 50, kWIDTH - 20, 50) target:self action:@selector(sureClick) title:@"保存" cornerRadius:2];
    [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rewriteView addSubview:self.sureButton];
    [self.sureButton setBackgroundColor:[UIColor redColor]];
    self.tableView.tableFooterView = self.rewriteView;
    
    
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
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)sureClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end