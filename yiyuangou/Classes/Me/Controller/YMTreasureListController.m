//
//  YMTreasureListController.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTreasureListController.h"
#import "YMListCell.h"
#import "YMCustomSegmentView.h"
@interface YMTreasureListController()<CustomSegmentViewDelegate>

@end
@implementation YMTreasureListController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"夺宝记录";
    YMCustomSegmentView *segmentView = [[YMCustomSegmentView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 44)];
    segmentView.delegate = self;
    segmentView.titles = @[@"进行中",@"已开奖"];
    self.tableView= [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64 -44) style:UITableViewStyleGrouped];
    self.view.backgroundColor =[UIColor whiteColor];
    self.tableView.tableHeaderView = segmentView;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    // Do any additional setup after loading the view.
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
    return 65;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *settingCell = @"settingCell";
        YMListCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCell];
        if (cell == nil) {
            cell = [[YMListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:settingCell];
        }
        cell = [cell congfigWithModle];
        return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)segmentView:(YMCustomSegmentView *)segmentView selectedAtIndex:(NSInteger)index
{

}
@end
