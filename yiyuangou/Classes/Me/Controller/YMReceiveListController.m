//
//  YMReceiveListController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMReceiveListController.h"
#import "YMRecievedCell.h"
@interface YMReceiveListController()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *headView;
}
@property (nonatomic,strong)UITableView *tableView;
@property  (nonatomic,strong)UIView *notiView;
@end

@implementation YMReceiveListController
-(UIView *)notiView
{
    if (_notiView == nil) {
        _notiView = [[UIView alloc] initWithFrame:self.view.bounds];
        _notiView.hidden = YES;
    }
    return _notiView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"中奖记录";
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(self.view.centerX, 0, kWIDTH, kHEIGHT - 64 -30) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.view.backgroundColor =[UIColor whiteColor];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
       [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 30)];
    headView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *headLable = [UILabel labelWithFrame:CGRectMake(0, 0, kWIDTH, 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    headLable.text  =@"恭喜您获得一个宝贝";
    [headView addSubview:headLable];
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    [self.view addSubview:self.tableView];
    
    UILabel *messageLabel = [UILabel labelWithFrame:CGRectMake(0, 0, kWIDTH, 40) textAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor]];
    messageLabel.centerY = self.view.centerY;
    messageLabel.text = @"暂无记录";
    [self.notiView addSubview:messageLabel];
    self.notiView.hidden = NO;
    [self.view addSubview:self.notiView];
// Do any additional setup after loading the view.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 0;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return headView;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reciveCell = @"reciveCell";
    YMRecievedCell *cell = [tableView dequeueReusableCellWithIdentifier:reciveCell];
    if (cell == nil) {
        cell = [[YMRecievedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reciveCell];
    }
    cell = [cell congfigWithModle];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
