//
//  RewardViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "RewardViewController.h"
#import "RewardViewControllerCell.h"
#import "YMDetailProductionController.h"
@interface RewardViewController ()

@end

@implementation RewardViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"最近开奖";
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *rewardViewCell = @"rewardViewCell";
    RewardViewControllerCell *cell = [tableView dequeueReusableCellWithIdentifier:rewardViewCell];
    if (cell == nil) {
        cell = [[RewardViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rewardViewCell];
    }
    if (indexPath.row < 3) {
        cell.messageView.hidden  = YES;
    }else{
        cell.timeClock.hidden = YES;
    }
    cell = [cell configWithMode];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self setHidesBottomBarWhenPushed:YES];
    YMDetailProductionController *controller = [[YMDetailProductionController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
