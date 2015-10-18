//
//  YMDetailProductionController.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//
#define HEADERHEIGHT  10
#define ZERO 0.001
#import "YMDetailProductionController.h"
#import "YMDetailProgressCell.h"
#import "YMRewardPersonCell.h"
#import "YMAdvertisementView.h"
#import "YMDetailViewCell.h"
#import "YMPastRewardController.h"
#import "YMProductionListController.h"
#import "YMBuyView.h"
#import "YMOrderView.h"
#import "YMPayController.h"
#import "YMNotifiyController.h"
@interface YMDetailProductionController()<YMBuyViewDelegate,UITableViewDataSource,UITableViewDelegate,YMOrderViewDelegate>
@property (nonatomic ,strong) NSArray * dataArray;
@property (nonatomic ,strong) NSArray * titleArray;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)YMBuyView *footerCarView;
@property (nonatomic,strong)UIView *footerNotifyView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)YMOrderView *orderView;
@end

@implementation YMDetailProductionController
-(YMOrderView *)orderView
{
    if (_orderView == nil) {
        _orderView = [[YMOrderView alloc] initWithFrame:CGRectMake(0, kHEIGHT, kWIDTH, 223) withModel:nil];
        _orderView.delegate = self;
    }
    return _orderView;
}
-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kHEIGHT, kHEIGHT - 64 - 50)];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return  _tableView;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"商品详情";
    [self addTheFooterView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.orderView.steper.stepInterval = 1.0f;
    self.orderView.steper.value = 10.0f;
    __weak typeof(self)safeSelf = self;
    self.orderView.steper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        safeSelf.orderView.steper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
    };
    [self.orderView.steper setup];


    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    YMAdvertisementView *adVertisementView = [[YMAdvertisementView alloc] init];
    UIView *adView = [adVertisementView advertisementView];
    self.tableView.tableHeaderView = adView;
    self.titleArray = @[@"往期揭晓",@"晒单",@"所有参与人次"];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.orderView];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if(section == 1){
        return 3;
    }else{
        return 3;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 ) {
        if (self.state) {
            return 150;
        }else{
            return 80;
        }
    }else if(indexPath.section == 1){
        return 44;
    }else{
        return 55;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return HEADERHEIGHT;
    }else{
        return ZERO;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.state) {
            static NSString *rewardPersonCell = @"rewardPersonCell";
            YMRewardPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardPersonCell];
            if (cell == nil) {
                cell = [[YMRewardPersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rewardPersonCell];
            }
            cell = [cell congifgWithMode];
            return cell;
        }else{
            static NSString *progressCell = @"progressCell";
            YMDetailProgressCell *cell = [tableView dequeueReusableCellWithIdentifier:progressCell];
            if (cell == nil) {
                cell = [[YMDetailProgressCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:progressCell];
            }
            cell = [cell congifgWithMode];
            return cell;
        }
    }else if (indexPath.section == 1){
        static NSString *tableViewCell = @"tableViewCell";
        UITableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:tableViewCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.titleArray[indexPath.row];
        return cell;
        
    }else{
        static NSString *resuedID = @"YMDetailViewCell";
        YMDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resuedID];
        if (cell == nil) {
            cell = [[YMDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resuedID];
        }
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            YMPastRewardController *controller = [[YMPastRewardController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }else if(indexPath.row == 1){
            YMProductionListController *controller = [[YMProductionListController alloc] init];
            [self setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
            
        }
    }
}
-(void)addTheFooterView
{
    if (self.state) {
        self.footerCarView = [[YMBuyView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 64 - 50, kWIDTH, 50)];
        self.footerCarView.delegate = self;
        [self.view addSubview:self.footerCarView];
    }else{
        self.footerNotifyView = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 64 - 50, kWIDTH, 50)];
        UILabel *notifyLabel  = [UILabel labelWithFrame:CGRectMake(10, 15, kWIDTH*0.7, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        notifyLabel.text = @"第133期正在火热报名";
        

        UIButton *rightButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH-110, 5, 100, 40) target:self action:@selector(buyViewDidSelectAtIndex:) title:@"立即报名" cornerRadius:2];
        rightButton.backgroundColor = [UIColor redColor];
        [rightButton setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [self.footerNotifyView addSubview:notifyLabel];
        [self.footerNotifyView addSubview:rightButton];
        [self.view addSubview:self.footerNotifyView];
    }
}
-(void)buyViewDidSelectAtIndex:(NSInteger)index
{
    if (index == 10000) {
        [self.view makeToast:@"添加成功"];
    }else{
        if (self.state == nil) {
            [self orderButtonClick];
        }else{
            [UIView animateWithDuration:1.0 animations:^{
                self.orderView.tmri_top = kHEIGHT - 223;
            } completion:nil];
        }
    }
}
-(void)orderButtonClick
{
    if (self.state == nil) {
        
        YMNotifiyController *controller = [[YMNotifiyController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }else {
        YMPayController *controller = [[YMPayController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }
}
@end
