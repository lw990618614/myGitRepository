//
//  YMPayResultController.m
//  yiyuangou
//
//  Created by roen on 15/11/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPayResultController.h"
#import "YMPayResultCell.h"
#import "MyCarManager.h"
#import "YMCheckRusult.h"
#import "YMTreasureListController.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"

@interface YMPayResultController ()
{
    YMCheckRusult *model;
}
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic,strong)UIButton *backBtn;
@end

@implementation YMPayResultController
-(void)viewWillAppear:(BOOL)animated
{
    [[MyCarManager sharedManager] dismissTheordercompletion:^(id result, NSInteger statusCode, NSString *msg) {
        if (statusCode == 0) {
            
        }else{
            [self.view makeToast:msg];
        }
    }];

}
-(UIView *)headerView
{
    if (_headerView == nil) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 170)];
        UIButton *resultButton  = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, kWIDTH, 18)];
        [resultButton setTitleColor:[UIColor colorWithHex:@"#4AD107"] forState:UIControlStateNormal];
        if (model.status == 0) {
            [resultButton setTitle:@" 参与失败" forState:UIControlStateNormal];
            [resultButton setTitleColor:[UIColor colorWithHex:@"#DD2727"] forState:UIControlStateNormal];

            [resultButton setImage:[UIImage imageNamed:@"支付失败_03"] forState:UIControlStateNormal];
//            [resultButton setClipsToBounds:YES];

        }else{
            [resultButton setImage:[UIImage imageNamed:@"支付成功_03"] forState:UIControlStateNormal];
            [resultButton setTitle:@" 参与成功" forState:UIControlStateNormal];
        }
        resultButton.imageView.contentMode =  UIViewContentModeScaleAspectFit;

        UILabel *messageLable = [UILabel labelWithFrame:CGRectMake(0, resultButton.tmri_bottom+15, kWIDTH, 14) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        messageLable.text = @"请耐心等待开奖,还有其他商品在火热抢购中";
        messageLable.numberOfLines =0;
        messageLable.font = [UIFont systemFontOfSize:14];
        
        UILabel *comeLable = [UILabel labelWithFrame:CGRectMake(0, messageLable.tmri_bottom+10, kWIDTH, 14) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        comeLable.text = @"快去看看吧!";
        comeLable.numberOfLines =0;
        comeLable.font = [UIFont systemFontOfSize:14];

        UIButton *leftButton = [UIButton buttonWithFrame:CGRectMake(10, comeLable.tmri_bottom+10, (kWIDTH - 30)*0.5, 37) target:self action:@selector(buttonClick:) title:@"查看夺宝记录" cornerRadius:2];

        leftButton.titleLabel.font  = [UIFont systemFontOfSize:14];
        leftButton.tag = 100;
        leftButton.backgroundColor = [UIColor colorWithHex:@"#999999"];
        [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        UIButton *rightButton = [UIButton buttonWithFrame:CGRectMake(leftButton.tmri_right +10, comeLable.tmri_bottom +10, leftButton.tmri_width, 37) target:self action:@selector(buttonClick:) title:@"继续夺宝" cornerRadius:2];
        rightButton.titleLabel.font  = [UIFont systemFontOfSize:14];
        rightButton.tag = 101;
        rightButton.backgroundColor = [UIColor colorWithHex:@"#DD2727"];
        [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_headerView addSubview:resultButton];
        [_headerView addSubview:messageLable];
        [_headerView addSubview:comeLable];
        [_headerView addSubview:rightButton];
        [_headerView addSubview:leftButton];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付";
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64) style:UITableViewStyleGrouped];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
     [ self.tableView setSeparatorColor : [UIColor groupTableViewBackgroundColor]];
    [self.view makeToastActivity:kLoadingText];
    UIImage *btnImage = [UIImage imageNamed:@"返回"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(poptoMysetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = barBtn;
    self.backBtn= backBtn;
    self.backBtn.enabled = NO;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5];
}
#pragma Mark tableViewDelegale&& tableViewDataSouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return model.detailList.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return HEIGHT_SERO;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"  参与奖品信息";
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *payResult = @"payResult";
    YMPayResultCell *cell = [tableView dequeueReusableCellWithIdentifier:payResult];
    if (cell == nil) {
        cell = [[YMPayResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:payResult];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GoodInfos *info = model.detailList[indexPath.row];
    cell = [cell configWithMode:info];
    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)makeUI
{
    self.tableView.tableHeaderView = self.headerView;
}
-(void)buttonClick:(UIButton *)sender
{
    if (sender.tag == 100) {
        YMTreasureListController *controller = [[YMTreasureListController alloc] init];
        controller.isHidenRight = YES;
        [self.navigationController pushViewController:controller animated:YES];
    }else{
        AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
        YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
        [tabbar setSelectedIndex:0];
        [self.navigationController popToRootViewControllerAnimated:YES];

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
-(void)loadData
{
    
    SAFE;
  [[MyCarManager sharedManager] payresultWith:self.oid :^(id result, NSInteger statusCode, NSString *msg) {
      [weakSelf.view hideToastActivity];
      self.backBtn.enabled = YES;
      if (statusCode == 0) {
          model = result;
          [self makeUI];
          [self.tableView reloadData];
      }else{
          [weakSelf.view makeToast:msg];
      }
  }];
    
}
-(void)poptoMysetting{
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}
@end
