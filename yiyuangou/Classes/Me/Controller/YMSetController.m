//
//  YMSetController.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSetController.h"
#import "YMClientController.h"
#import "YMQuestionController.h"
#import "YMNegotiateController.h"
#import "YMNotifiyController.h"
#import "YMWebViewController.h"
@interface YMSetController()<UIAlertViewDelegate>
{
    UIView *footView;
    NSArray *itemArray;
}
@end
@implementation YMSetController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 88)];
    UIButton *footButton = [UIButton buttonWithFrame:CGRectMake(0, 20, kWIDTH, 44) target:self action:@selector(footButtonClick) title:@"退出当前帐号" cornerRadius:2];
    [footButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    footButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
    footButton.backgroundColor = [UIColor whiteColor];
    [footView addSubview:footButton];
    [self loadData];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
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
            itemArray =  dict[@"data"][@"htmlList"];
            [weakSelf.tableView reloadData];
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
    return itemArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 88;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *coinCell = @"coinCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:coinCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
    }
     NSDictionary *dict = itemArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.textLabel.textColor = [UIColor heightBlacKColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = dict[@"descript"];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = itemArray[indexPath.row];

//
    if ([dict[@"shortName"] isEqualToString:@"agreement"]) {
        YMClientController *controller = [[YMClientController alloc] init];
        controller.title =  dict[@"descript"];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        YMWebViewController *web  =[[YMWebViewController alloc] init];
        web.urlStr = dict[@"url"];
        web.title =  dict[@"descript"];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:web animated:YES];

    }
//    else if(indexPath.row == 1){
//        YMQuestionController *controller = [[YMQuestionController alloc] init];
//        [self setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:controller animated:YES];
//    }else{
//        YMNegotiateController *controller = [[YMNegotiateController alloc] init];
//        [self setHidesBottomBarWhenPushed:YES];
//        [self.navigationController pushViewController:controller animated:YES];
//    }
}
-(void)footButtonClick
{
    NSLog(@"footButtonClick");
    UIAlertView *alerInfo  = [[UIAlertView alloc] initWithTitle:nil message:@"确认退出当前账户?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认",@"取消", nil];
    [alerInfo show];
    //清楚本地缓存
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        YMInfoCenter *infoCenter = [YMInfoCenter sharedManager];
        YMUser *mainUser = infoCenter.mainUser;
        mainUser.YMUserID = 0;
        mainUser.YMNickName = nil;
        mainUser.YMUserAvatarURL = nil;
        mainUser.YMUserMobile = nil;
        mainUser.YMUserWeixin = nil;
        mainUser.YMUserHeaderImg  = nil;
        mainUser.YMTotalIncome = nil;
        mainUser.YMUserPassword = nil;
        [infoCenter saveUserID];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if(buttonIndex == 1)
    {
        [alertView dismissWithClickedButtonIndex:[alertView cancelButtonIndex] animated:YES];

    }
}

@end
