//
//  YMAcceptViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMAcceptViewController.h"
#import "YMRewriteViewController.h"
#import "YMCreatePlaceController.h"
#import "Masonry.h"
#import "YMReceiveListController.h"
#define kymPhoneaTag 201
#define kymEditAddress 202
#define kymUsrName 203
#define kymAddress 204
#define kymAddressCount 1024
@interface YMAcceptViewController()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView * bottomView;
@property(nonatomic,strong)NSArray  *addressArray;
@property(nonatomic,assign)NSUInteger lastTap; //上次点击
@property(nonatomic,strong)UIView *noAddress;
@property(nonatomic,strong)NSDictionary *currentDic;
@end
@implementation YMAcceptViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.type == YMMySetting) {
        self.title = @"收货地址";
    }
    //选择收货地址
    else if (self.type == YMRewardList)
    {
        self.title = @"选择收货地址";
    }
    _lastTap = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-64- 60) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    //去除多余的分割线
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    [self.view addSubview:self.tableView];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 60- 64, kWIDTH, 60)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    if (self.type == YMMySetting) {
        UIButton *bottomButton = [UIButton buttonWithFrame:CGRectMake((kWIDTH - 150)*0.5, 15, 150, 30) target:self action:@selector(createPlace) title:@"新增收货地址" cornerRadius:0];
        [bottomButton setTitleColor:[UIColor heightBlacKColor] forState:UIControlStateNormal];
        [bottomButton setImage:[UIImage imageNamed:@"+"] forState:UIControlStateNormal];
        bottomButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        //设置图片和文字之间的距离
        bottomButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        for (UIView *subView in self.bottomView.subviews) {
            [subView removeFromSuperview];
        }
        [self.bottomView addSubview:bottomButton];
    }
    else if (self.type == YMRewardList)
    {
        for (UIView *subView in self.bottomView.subviews) {
            [subView removeFromSuperview];
        }
        UIButton *bottomSubmitButton = [UIButton buttonWithFrame:CGRectMake(0, 0, kWIDTH, 60) target:self action:@selector(submit:) title:@"提交" cornerRadius:0];
        bottomSubmitButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [bottomSubmitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        bottomSubmitButton.backgroundColor = [UIColor redColor];
        self.bottomView.backgroundColor = [UIColor clearColor];
        [self.bottomView addSubview:bottomSubmitButton];
        self.view.backgroundColor  = kViewControllerBackgroundColor;
    }
    self.bottomView.hidden = YES;
    [self.view addSubview:self.bottomView];
    [self loadData];
}
//

//没有地址
-(void) noAddressList
{
    _noAddress = [[UIView alloc] init];
    [self.view addSubview:_noAddress];
    WEAKSELF;
   [_noAddress mas_makeConstraints:^(MASConstraintMaker *make) {
       make.center.equalTo(weakSelf.view);
       make.size.mas_equalTo(CGSizeMake(200, 250));
   }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@"address"];
    [_noAddress addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(120, 130));
        make.centerX.equalTo(_noAddress);
        make.top.equalTo(_noAddress).offset(10);
    }];
    UILabel *noDes = [[UILabel alloc] init];
    noDes.text = @"您还没有填写过收货地址";
    noDes.textColor = [UIColor lightColor];
    noDes.font = [UIFont systemFontOfSize:16.0];
    [_noAddress addSubview:noDes];
    [noDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_noAddress);
        make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    }];
    UIButton *addAddress = [[UIButton alloc] init];
    addAddress.backgroundColor = [UIColor redColor];
    [addAddress setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAddress addTarget:self action:@selector(createPlace) forControlEvents:UIControlEventTouchUpInside];
    [_noAddress addSubview:addAddress];
    [addAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_noAddress);
        make.top.equalTo(noDes.mas_bottom).offset(10);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(350/2.0);
    }];
    
}
//收货地址列表
-(void) loadData
{
    [self.view makeToastActivity:kLoadingText];

    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/address/list"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
       NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
          weakSelf.addressArray =  dict[@"data"][@"addressList"];
            if (weakSelf.addressArray.count == 0) {
                weakSelf.bottomView.hidden = YES;
                [weakSelf.tableView removeFromSuperview];
                [weakSelf noAddressList];
            }
            else
            {
                weakSelf.bottomView.hidden = NO;
                [_noAddress removeFromSuperview];
                [weakSelf.view addSubview:weakSelf.tableView];
                weakSelf.bottomView.backgroundColor = [UIColor whiteColor];
                int i = 0;
                for (NSDictionary *dict in weakSelf.addressArray) {
                    if ([dict[@"isDefault"] integerValue] == 1 ) {
                        _lastTap = i;
                    }
                    i++;

                }
                [weakSelf.tableView reloadData];

            }
        }
        [weakSelf.view hideToastActivity];
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];

    }];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 84;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *acceptCell = @"acceptCell";
    NSDictionary *addressInfo =  self.addressArray[indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acceptCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acceptCell];
        //电话号码
        UILabel *phoneLbl = [[UILabel alloc]initWithFrame:CGRectMake(kWIDTH - 160, 20, 140, 20)];
        phoneLbl.font  = [UIFont systemFontOfSize:16.0];
        phoneLbl.textColor = [UIColor heightBlacKColor];
        phoneLbl.tag = kymPhoneaTag;
        
        //编辑按钮
        UIButton *accessoryButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 50,phoneLbl.tmri_bottom+ 10 , 20, 20) target:self action:@selector(rewriteThePlace:) title:nil cornerRadius:2];
        accessoryButton.tag = kymEditAddress;
        accessoryButton.backgroundColor = [UIColor clearColor];
        [accessoryButton setBackgroundImage:[UIImage imageNamed:@"edit"] forState:UIControlStateNormal];
        [cell.contentView addSubview:phoneLbl];
        [cell.contentView addSubview:accessoryButton];
        //用户姓名
        UILabel *userName  = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 100, 25)];
        userName.font = [UIFont systemFontOfSize:16.0];
        userName.textColor = [UIColor heightBlacKColor];
        userName.tag =  kymUsrName;
        [cell.contentView addSubview:userName];
        //地址
        UILabel *address  = [[UILabel alloc] initWithFrame:CGRectMake(50, userName.tmri_bottom + 10, 180, 25)];
        address.font = [UIFont systemFontOfSize:14.0];
        address.textColor = [UIColor lightColor];
        address.tag =  kymAddress;
        [cell.contentView addSubview:address];
    }
    //电话号码
    UILabel *phonelbl = (UILabel *)[cell.contentView viewWithTag:kymPhoneaTag];
    phonelbl.text  = addressInfo[@"phone"];
    //用户姓名
    UILabel *userlbl = (UILabel *)[cell.contentView viewWithTag:kymUsrName];
    userlbl.text  = addressInfo[@"linkman"];
    //联系地址
    UILabel *address = (UILabel *)[cell.contentView viewWithTag:kymAddress];
    address.text  = addressInfo[@"address"];
    if (indexPath.row == _lastTap) {
        cell.imageView.image = [UIImage imageNamed:CellSelectImage];
    }
    else
        cell.imageView.image = [UIImage imageNamed:CellUnSelectImage];

    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == _lastTap) {
        return;
    }
    /**
     
     */
    //如果是领奖页面进入
    if (self.type == YMRewardList) {
        UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_lastTap == -1?0:_lastTap inSection:0]];
        lastCell.imageView.image = [UIImage imageNamed:CellUnSelectImage];
        UITableViewCell *curCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        curCell.imageView.image = [UIImage imageNamed:CellSelectImage];
        _lastTap = indexPath.row;
    }
    NSDictionary *dict = self.addressArray[indexPath.row];
    //如果我的页面进入
    if (self.type ==  YMMySetting) {
        UIAlertView *alertInfo = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否将此地址设为默认收货地址?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
        [alertInfo show];
        alertInfo.tag =  201;
        self.currentDic = dict;
    }

}
//设置默认地址
-(void) setDefaultAddress:(NSString *)gaid
{
    
    [self.view makeToast:@"正在设置默认地址"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/address/setDefault"];
    WEAKSELF;
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [dict setValue:gaid forKey:@"uaid"];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        [weakSelf.view hideToastActivity];
        if ([dict[@"code"] integerValue]  == 0) {
            [weakSelf.view makeToast:@"默认地址设置成功"];
            [weakSelf setCellSelected];
        }
    } failure:^(NSError *error) {
        
        
    }];
}
-(void) setCellSelected
{
    UITableViewCell *lastCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_lastTap == -1?0:_lastTap inSection:0]];
    lastCell.imageView.image = [UIImage imageNamed:CellUnSelectImage];
    NSUInteger index = [self.addressArray indexOfObject:self.currentDic];
    UITableViewCell *curCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    curCell.imageView.image = [UIImage imageNamed:CellSelectImage];
    _lastTap = index;
}
//新增
-(void)createPlace
{
    if (self.addressArray.count > kymAddressCount) {
        [self.view makeToast:@"您的收货地址已经超过最大限制条数"];
        return;
    }
    YMCreatePlaceController *controller = [[YMCreatePlaceController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    controller.addListViewController = self;
    [self.navigationController pushViewController:controller animated:YES];

}
//编辑
-(void)rewriteThePlace:(id) sender
{
    UIButton *btn = (UIButton *) sender;
    UITableViewCell *cell = (UITableViewCell *) [[btn superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSUInteger index = indexPath.row;
    YMRewriteViewController *controller = [[YMRewriteViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    controller.addListViewController = self;
    controller.addressDic = self.addressArray[index];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"rewriteThePlace");
}
-(void) refreshData:(NSDictionary *)dict
{
    [self loadData];
}
-(void) submit:(id) sender
{
//    grid
    [self.view makeToastActivity:kLoadingText];
    SAFE;
    NSMutableDictionary *dict  = [BaseParamDic baseParam];
    [dict setValue:self.rewardDic[@"grid"] forKey:@"grid"];
    [dict setValue:self.addressArray[_lastTap][@"uaid"] forKey:@"uaid"];
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/get"];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSDictionary *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            //提交申请
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提交成功!" message:@"小二将在三个工作日内发货，请保持电话畅通，方便与快递员联系" delegate:self cancelButtonTitle:nil otherButtonTitles:@"好的", nil];
            alertView.tag = 202;
            [alertView show];        }
    } failure:^(NSError *error) {
        
    }];
   
//    /reward/get
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //设置默认地址
    if (alertView.tag == 201) {
        if (buttonIndex == 0) {
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        }
        else if (buttonIndex == 1)
        {
            
            [self setDefaultAddress:self.currentDic[@"uaid"]];
        }
    }
    else if (alertView.tag == 202)
    {
        //如果点击按钮
        if (buttonIndex == 0) {
            if (self.isFromBindPhone) {
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
            else
            {
               [self.navigationController popViewControllerAnimated:YES];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:ReceiveList object:nil];

        }
    }

}
@end
