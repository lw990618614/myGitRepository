//
//  MySettingViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MySettingViewController.h"
#import "YMSettingCell.h"
#import "YMAcceptViewController.h"
#import "YMReceiveListController.h"
#import "YMTreasureListController.h"
#import "YMGetCoinController.h"
#import "YMRuleController.h"
#import "YMSetController.h"
#import "SettingManager.h"
#import "YMSettingResult.h"
#import "YMPayController.h"
#import "YMAccountChangeViewController.h"
#import "YMNotifiyController.h"
@interface MySettingViewController ()<YMSettingProtol>
{
    YMSettingResult *settiingResult;
    YMNotifiyController *notifi;
}
@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"我的";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    //隐藏返回按钮
    self.navigationItem.hidesBackButton = YES;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
   
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:REFRESH_SELF object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserInfo) name:ymNotificationRefreshUserInfo object:nil];

    [self loadData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self showTabBar];
    YMInfoCenter *center = [YMInfoCenter sharedManager];
    if ([center getUserID]) {
        [self noLogin];
    }
    else
    {
        [self didLogin];
    }
}
//没有登录
-(void) didLogin
{
    if (notifi == nil) {
        notifi = [[YMNotifiyController alloc]init];

    }
    [self.view addSubview:notifi.view];
    [self addChildViewController:notifi];
}
-(void) noLogin
{
    [notifi.view removeFromSuperview];
    [notifi removeFromParentViewController];
}
-(void)refreshUserInfo
{
    YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
    YMUser       *mainUsr = infoCenter.mainUser;
    YMSettingCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.userNameLable.text = mainUsr.YMNickName;
    cell.iconView.image  = [UIImage imageWithData:mainUsr.YMUserHeaderImg];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 2) {
        return 2;
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100;
    }else{
        return 44;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *settingCell = @"settingCell";
        YMSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if (cell == nil) {
            cell = [[YMSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
            cell.delegate = self;

        }
        cell.fillButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 85, 65, 60, 25) target:self action:@selector(fillClick)  title:@"充值" cornerRadius:3];
        [cell.fillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cell.fillButton setBackgroundColor:[UIColor  colorWithHex:@"#DD2727"]];
        [cell.contentView addSubview:cell.fillButton];
//        cell.fillButton.centerY = 50;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell = [cell congifgWithMode:settiingResult];
        return cell;
        
    }else{
        static NSString *tableviewCell = @"tableviewCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableviewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableviewCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.section) {
            case 0:
                
                break;
            case 1:
                cell.textLabel.text = @"收货地址";
                cell.imageView.image = [UIImage imageNamed:@"收货地址"];

                break;
            case 2:
                if (indexPath.row == 0) {
                    cell.textLabel.text = @"夺宝记录";
                    cell.imageView.image = [UIImage imageNamed:@"夺宝记录"];

                }else{
                    cell.textLabel.text = @"中奖记录";
                    cell.imageView.image = [UIImage imageNamed:@"中奖记录"];

                }
                break;
            case 3:
                cell.imageView.image = [UIImage imageNamed:@"赚抢币"];
                cell.textLabel.text = @"赚抢币";
                break;
            case 4:
                cell.imageView.image = [UIImage imageNamed:@"设置"];
                cell.textLabel.text = @"设置";
                break;
            default:
                break;
        }
        cell.textLabel.font = [UIFont systemFontOfSize:16.0];
        cell.textLabel.textColor = [UIColor heightBlacKColor];
        return cell;

    }
    
}
-(void)fillClick
{
    YMPayController *controller = [[YMPayController alloc] init];
    controller.pay_operation = 1;
    controller.backstring = self.title;
    controller.coin =[settiingResult.LeftMoney intValue];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        YMAcceptViewController *controller = [[YMAcceptViewController alloc] init];
        controller.type = YMMySetting;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            YMTreasureListController *controller = [[YMTreasureListController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }else{
            YMReceiveListController *controller = [[YMReceiveListController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
            [self setHidesBottomBarWhenPushed:NO];
        }
    }else if(indexPath.section == 3){
        YMGetCoinController *controller = [[YMGetCoinController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }else if (indexPath.section == 4)
    {
        YMSetController *controller = [[YMSetController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }
}
-(void)loadData
{
    [self.view makeToastActivity:kLoadingText];
    SAFE;
    [[SettingManager sharedManager] settingStatuscompletion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];
        if (statusCode == 0) {
            settiingResult = result;
            YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
            YMUser       *mainUser = infoCenter.mainUser;
            mainUser.YMUserAvatarURL = settiingResult.picture_ulr;
            mainUser.YMAccount  = settiingResult.account;
            mainUser.YMNickName = settiingResult.name;
            mainUser.YMTotalIncome = settiingResult.LeftMoney;
            mainUser.YMAddressArray = settiingResult.addressList;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark ----YMSettingDelegate---
-(void)accoutChange
{
    YMAccountChangeViewController *accountChange = [[YMAccountChangeViewController alloc]init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:accountChange animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}
//-(void)dealloc
//{
//    [[NSNotificationCenter defaultCenter] removeObserver:ymNotificationRefreshUserInfo];
//    [[NSNotificationCenter defaultCenter] removeObserver:REFRESH_SELF];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
