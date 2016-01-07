//
//  YMGetCoinController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMGetCoinController.h"
#import "YMRuleController.h"
#import "YMCoinCell.h"
#import "YMRuleController.h"
#import "YMPayController.h"
#import "YMTabBarController.h"
#import "AppDelegate.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsService.h"
#import "YMHelpViewController.h"
@interface YMGetCoinController()<YMCoinCellDeleagte,UMSocialUIDelegate>
{
    UIView *footView;
}
@property(nonatomic,strong) NSArray *taskArray;
@property(nonatomic,strong) UILabel  *days;
@property(nonatomic,strong) NSNumber *day;
@property(nonatomic,strong) NSMutableDictionary *shareDic;//分享字典
@property(nonatomic,assign) BOOL      isCompete;//任务是否完成
@property(nonatomic,assign) BOOL      isReward;//是否领取奖励
@property(nonatomic,strong) NSMutableArray   *isCompeteTask;//单个任务是否完成
@property(nonatomic,assign) platformType platform;
@property(nonatomic,strong) NSNumber   *currentTaskId;//当前任务ID
@end

@implementation YMGetCoinController
- (void)viewDidLoad {
    [super viewDidLoad];
    _isCompete = YES;
    _isReward =  NO;
//    self.taskArray = @[@{@"title":@"了解一元赚",
//                         @"key":@"start"
//                         },
//                       @{@"title":@"邀请好友注册"},
//                       @{@"title":@"参与抢购一次"},
//                       @{@"title":@"成功充值一次",
//                         @"key":@"end"
//
//                         }
//                      ];
    self.title = @"赚抢币";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    footView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, kWIDTH , 70)];
    UIButton *footButton = [UIButton buttonWithFrame:CGRectMake(0, 10, kWIDTH , 44) target:self action:@selector(footButtonClick) title:@"领取奖励" cornerRadius:2];
    [footButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    footButton.backgroundColor = [UIColor  whiteColor];
    UILabel *desclbl = [[UILabel alloc] initWithFrame:CGRectMake(0, footButton.tmri_bottom, kWIDTH, 15)];
    desclbl.font = [UIFont systemFontOfSize:14.0];
    desclbl.textColor = [UIColor redColor];
    desclbl.text =  @"完成所有任务即奖励2个抢币";
    desclbl.textAlignment = NSTextAlignmentCenter;
    [footButton addSubview:desclbl];
    [footView addSubview:footButton];
    self.shareDic = [[NSMutableDictionary alloc] init];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadData) name:ymNotificationTaskCompete object:nil];
    self.day = @0;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.taskArray.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if ((indexPath.row == 0)) {
//        return 130;
//    }
//    else if(indexPath.row == 5)
//        return 55;
//    else
        return 55;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return footView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *coinCell = @"coinCell";
    static NSString *signCell = @"signCell";
    static NSString *receiveCell = @"signCell";
    UITableViewCell *cell;
    if (indexPath.row  != 5) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:signCell];
//        UIButton *signPerDay = [[UIButton alloc] init];
//        [signPerDay setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
//        [signPerDay addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
//        [cell.contentView addSubview:signPerDay];
//         [signPerDay mas_makeConstraints:^(MASConstraintMaker *make) {
//             make.centerX.equalTo(cell.contentView);
//             make.top.equalTo(@0);
//             make.width.equalTo(@70);
//             make.height.equalTo(@70);
//         }];
//        UILabel *daysSign = [[UILabel alloc] init];
//        daysSign.text = @"每日签到";
//        daysSign.textColor = [UIColor lightColor];
//        daysSign.font = [UIFont systemFontOfSize:16.0];
//        [cell.contentView addSubview:daysSign];
//        [daysSign mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(signPerDay.mas_bottom).offset(0);
//            make.centerX.equalTo(cell.contentView);
//        }];
//        _days = [[UILabel alloc] init];
//        _days.attributedText = [self genAttibuteStr:self.day];
//        [cell.contentView addSubview:_days];
//        [_days mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(daysSign.mas_bottom).offset(5);
//            make.centerX.equalTo(cell.contentView);
//        }];
        cell = [[YMCoinCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
        YMCoinCell *coinCell = (YMCoinCell *)cell;
        if (cell == nil) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        coinCell.delegate = self;
        NSDictionary *dict = self.taskArray[indexPath.row];
        [coinCell configWithDictionary:dict];

    }
    else if (indexPath.row == 5)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:receiveCell];
        cell.backgroundColor = [UIColor clearColor];
        [cell.contentView addSubview:footView];
    }
//    else
//    {
//        cell = [[YMCoinCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:coinCell];
//        YMCoinCell *coinCell = (YMCoinCell *)cell;
//        if (cell == nil) {
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            }
//        coinCell.delegate = self;
//        NSDictionary *dict = self.taskArray[indexPath.row - 1];
//        [coinCell configWithDictionary:dict];
//
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self doTaskAction:indexPath];
}
#pragma mark -----YMCoinCellDelegate-------
-(void)doTaskAction:(id)cell
{
    //用户的分享次数

    NSIndexPath *indexPath;
    if ([cell isKindOfClass:[YMCoinCell class]]) {
        indexPath   = [self.tableView indexPathForCell:cell];

    }
    else if([cell isKindOfClass:[NSIndexPath class]])
    {
        indexPath =  cell;
    }
    NSDictionary *dict = self.taskArray[indexPath.row];
    self.currentTaskId =  dict[@"tiid"];
    //了解一元购
    if (indexPath.row == 0) {
        
        NSString *url =  dict[@"url"];
        YMHelpViewController *controller = [[YMHelpViewController alloc] initWithAddress:@"开奖规则" address:url];
        controller.taskID = self.currentTaskId;
        controller.isFinishTask = [dict[@"createTime"] isValid]?YES:NO;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
    //分享注册好友
    else if (indexPath.row == 1)
    {
        
        [self shareAction];
    }
    //参与抢购一次
    else if (indexPath.row == 2)
    {
        //参与抢购
        [[NSNotificationCenter defaultCenter] postNotificationName:ymNotificationBug object:nil];
        
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:0];
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    //成功充值一次
    else if(indexPath.row == 3)
    {
        YMPayController *controller = [[YMPayController alloc] init];
        controller.backstring = self.title;
        [[NSNotificationCenter defaultCenter] postNotificationName:ymNotificationChongzhi object:nil];
        //进入充值界面
        controller.pay_operation =  1;
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];

    }
}
-(void) shareAction
{
//    /shareinfo/getInfo
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/shareinfo/getInfo"];
    NSMutableDictionary *dict = [BaseParamDic baseParam];
    [self.view makeToastActivity:kLoadingText];

    WEAKSELF;


    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        [weakSelf.view hideToastActivity];
        if ([dict[@"code"] integerValue] == 0) {
            
            NSArray *shareArray = dict[@"data"][@"infoList"];
            for (NSDictionary *dict in shareArray) {
                if ([dict[@"source"] isEqualToString:@"微信"])
                {
                    [weakSelf.shareDic setValue:dict forKey:@"wx"];
                }
                else if([dict[@"source"] isEqualToString:@"新浪微博"])
                {
                    [weakSelf.shareDic setValue:dict forKey:@"wb"];
                }
                else if([dict[@"source"] isEqualToString:@"QQ"])
                {
                    [weakSelf.shareDic setValue:dict forKey:@"qq"];
                }
            }
            [UMSocialSnsService presentSnsIconSheetView:weakSelf
                                                 appKey:UMKey                                          shareText:@"你要分享的文字"
                                             shareImage:carPlaceHolder
                                        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToQzone,nil]
                                               delegate:weakSelf];

        }
        
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark  ------友盟分享Delegate-----
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    NSDictionary *dict;
    //分享到微博
    if ([platformName isEqualToString:UMShareToSina]) {
        dict = self.shareDic[@"wb"];
        self.platform =  YMWeiBo;
    }
    //分享到微信
    else if ([platformName isEqualToString:UMShareToWechatSession] || [platformName isEqualToString:UMShareToWechatTimeline])
    {
    
        dict = self.shareDic[@"wx"];
        self.platform = YMWeiXin;
        socialData.extConfig.wechatSessionData.url = dict[@"url"];
        socialData.extConfig.wechatTimelineData.url = dict[@"url"];
        socialData.extConfig.wechatSessionData.title = dict[@"title"];
        socialData.extConfig.wechatTimelineData.title = dict[@"title"];


    }
    //分享到QQ
    else if ([platformName isEqualToString:UMShareToQQ] || [platformName isEqualToString:UMShareToQzone])
    {
        dict = self.shareDic[@"qq"];
        self.platform = YMQQ;
        socialData.extConfig.qqData.title = dict[@"title"];
        socialData.extConfig.qzoneData.title = dict[@"title"];
        socialData.extConfig.qqData.url = dict[@"url"];
        socialData.extConfig.qzoneData.url = dict[@"url"];

    }
    else{
        dict = self.shareDic[@"wx"];
        socialData.extConfig.wechatSessionData.url = dict[@"url"];
        socialData.extConfig.wechatTimelineData.url = dict[@"url"];

    }
    socialData.shareText = dict[@"descript"];
    
    NSString *imgUrl = [NSString stringWithFormat:@"%@%@",BaseServerImagesURL,dict[@"imageUrl"]];
    UIImage *img;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgUrl]];
    img = [UIImage imageWithData:data];
    socialData.shareImage = img;
    
}
//分享成功
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    NSDictionary *curDic;
    if (response.responseCode == UMSResponseCodeSuccess) {
        for (NSDictionary *dict in self.taskArray) {
            if ([dict[@"tiid"] integerValue] == [self.currentTaskId integerValue]) {
                curDic  = dict;
                break;
            }
        }
        //如果任务没有做
        if ((curDic[@"createTime"] == nil || [curDic[@"createTime"] isEqualToString:@""])) {
            [self taskCompete:self.currentTaskId];
        }
        //用户分享次数
        [MobClick event:ymShare];
    }

}
#pragma mark ----------按钮事件-------------------
//领取奖励
-(void)footButtonClick
{
    //领取任务奖励
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/task/getCoin"];
    NSDictionary *param = [BaseParamDic baseParam];
    UIButton *btn = (UIButton *)[footView subviews][0];
    WEAKSELF;
    [YMBaseHttpTool POST:url params:param success:^(id result) {
        NSDictionary *dict = [param keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            [btn setTitle:@"奖励已经领取" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor lightGrayColor];
            btn.enabled  = NO;
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [weakSelf.view makeToast:@"领取奖励成功"];
            [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil];
            
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
//点击签到
-(void)signAction:(id) sender
{
    NSLog(@"点击签到");
    [self sign];
}
//签到
-(void) sign
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/sysuser/sign"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];

    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        NSDictionary *dict = [result keyValues];
        if([dict[@"code"] integerValue] == 0)
        {
            _days.attributedText = [self genAttibuteStr:dict[@"data"][@"points_num"]];
            [weakSelf.view makeToast:dict[@"msg"]];
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];

        }
        [weakSelf.view hideToastActivity];
    } failure:^(NSError *error) {
        [weakSelf.view hideToastActivity];
    }];
}
//加载数据
-(void) loadData
{
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/task//list"];
    WEAKSELF;
    [self.view makeToastActivity:kLoadingText];

    
    NSMutableDictionary  *dict = [BaseParamDic baseParam];
    [YMBaseHttpTool POST:url params:dict success:^(id result) {
        [weakSelf.view hideToastActivity];

        NSDictionary *dict = [result keyValues];
        _isReward =  [dict[@"data"][@"is_enabled"] boolValue];
        _isCompete = YES;
        if([dict[@"code"] integerValue] == 0)
        {
            weakSelf.taskArray =  dict[@"data"][@"taskList"];
            weakSelf.day = dict[@"data"][@"points_num"];
            for (NSDictionary *dict in weakSelf.taskArray) {
                //如果任务没有完成
                if ((dict[@"createTime"] == nil || [dict[@"createTime"] isEqualToString:@""])) {
                    //任务并没有完成
                    weakSelf.isCompete = NO;
                    break;
                }

            }
            UIButton *btn = (UIButton *)[footView subviews][0];
            //如果任务完成并且没有领取过奖励
            if (_isCompete &&  !_isReward) {
                [btn setTitle:@"领取奖励" forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor whiteColor];
                [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                btn.enabled  = YES;
            }
            //任务完成 但有领取奖励
            if (_isCompete && _isReward) {
                [btn setTitle:@"奖励已经领取" forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor lightGrayColor];
                btn.enabled  = NO;
            }
            //任务未完成
            if (!_isCompete) {
                
                [btn setTitle:@"任务未完成" forState:UIControlStateNormal];
                btn.backgroundColor = [UIColor lightGrayColor];
//                btn.enabled =  YES;
                btn.enabled  = NO;
            }
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
//任务上报
-(void) taskCompete:(NSNumber *)taskId
{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/task/complete"];
    NSMutableDictionary *muDic = [BaseParamDic baseParam];
    [muDic setValue:taskId forKey:@"tiid"];
    WEAKSELF;
    [YMBaseHttpTool POST:url params:muDic success:^(id result) {
        NSDictionary  *dict = [result keyValues];
        if ([dict[@"code"] integerValue] == 0) {
            [weakSelf.view makeToast:@"任务上报成功"];
            //重新刷新数据
            [weakSelf loadData];
        }
        else
        {
            [weakSelf.view makeToast:dict[@"msg"]];
        }
    } failure:^(NSError *error) {
        
    }];
}
-(NSMutableAttributedString *) genAttibuteStr:(NSNumber *)num
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    NSDictionary *attGray = @{
                              NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                              NSForegroundColorAttributeName:[UIColor heightBlacKColor]
                              };
    NSDictionary *attRed = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:24.0],
                               NSForegroundColorAttributeName:[UIColor  colorWithHex:@"#DD2727"]
                          };
    if (num  == nil) {
        num = @0;
    }
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"累积" attributes: attGray]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",num] attributes: attRed]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:@"天" attributes: attGray]];
    return attStr;
}
-(void)dealloc
{
    //移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:ymNotificationTaskCompete];
}
@end
