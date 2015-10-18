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
@interface YMAcceptViewController()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSArray *titleArray;
@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView * bottomView;
@end
@implementation YMAcceptViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"收货地址";
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
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    [self.view addSubview:self.tableView];
    
    self.bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT - 60- 64, kWIDTH, 60)];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    UIButton *bottomButton = [UIButton buttonWithFrame:CGRectMake((kWIDTH - 150)*0.5, 15, 150, 30) target:self action:@selector(createPlace) title:@"新增收货地址" cornerRadius:0];
    [bottomButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomButton setImage:[UIImage imageNamed:@"round"] forState:UIControlStateNormal];
    [self.bottomView addSubview:bottomButton];
    [self.view addSubview:self.bottomView];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *acceptCell = @"acceptCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:acceptCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:acceptCell];
    }
    cell.textLabel.text = @"程先生";
    cell.detailTextLabel.text = @"广州市天河区津滨腾大厦1234";
    UIButton *accessoryButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 60,10 , 50, 40) target:self action:@selector(rewriteThePlace) title:nil cornerRadius:2];
    accessoryButton.backgroundColor =[UIColor blueColor];
    [cell.contentView addSubview:accessoryButton];
    if (indexPath.row== 0) {
        cell.imageView.image = [UIImage imageNamed:@"searchSelIcon"];
    }else{
        cell.imageView.image = [UIImage imageNamed:@"searchDefIcon"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)createPlace
{
    YMCreatePlaceController *controller = [[YMCreatePlaceController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];

}
-(void)rewriteThePlace
{
    YMRewriteViewController *controller = [[YMRewriteViewController alloc] init];
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    NSLog(@"rewriteThePlace");
}

@end
