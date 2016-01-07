//
//  YMCheckDetailController.m
//  yiyuangou
//
//  Created by roen on 15/11/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCheckDetailController.h"
#import "YMCalculateCell.h"
#import "YMCaculateResult.h"
#import "HomeManager.h"
@interface YMCheckDetailController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL isShowPullDown;
    YMCaculateResult *model;
}
@property (nonatomic,strong)UITableView *messageTableView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *messageArray;
@property (nonatomic,strong) NSMutableArray *talbeViewArray;

@end

@implementation YMCheckDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"99夺宝计算详情";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, kWIDTH - 20, kHEIGHT - 64-20) style:UITableViewStyleGrouped];
    self.tableView.layer.cornerRadius=2;

    self.tableView.delegate = self;
    self.tableView.dataSource= self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    

    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    
    _messageTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT) style:UITableViewStyleGrouped];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    _messageTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)];
    _messageTableView.backgroundColor = [UIColor whiteColor];
    _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    if ([_messageTableView respondsToSelector:@selector(setSeparatorInset:)]){
        [_messageTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_messageTableView respondsToSelector:@selector(setLayoutMargins:)]){
        [_messageTableView setLayoutMargins:UIEdgeInsetsZero];
    }
    _talbeViewArray = [[NSMutableArray alloc] init];
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_talbeViewArray addObject:@"detail"];
    [_talbeViewArray addObject:@"detailA"];
    [_talbeViewArray addObject:@"detailB"];
    [_talbeViewArray addObject:@"detailAll"];
    [_talbeViewArray addObject:@"detailResult"];
    [self loadData];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!model) {
        return 0;
    }
    if (tableView == _messageTableView) {
        return model.processList.count;
    }else{
        return _talbeViewArray.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.tableView) {
        NSString *temp = [_talbeViewArray objectAtIndex:indexPath.row];
        if ([temp isEqualToString:@"1"]) {
            //最多显示3条记录的高度
            NSInteger height = [self getMaxHeightOfHistoryTableView];
            return height;
        }else{
            if (!isShowPullDown) {
                if (indexPath.row == 0) {
                    return 73;
                }else if (indexPath.row ==1){
                    return 100;
                }else if (indexPath.row == 2){
                    return 100;
                }else if (indexPath.row ==3){
                    return 70;
                }else if(indexPath.row ==4){
                    return 70;
                }
            }else{
                if (indexPath.row == 0) {
                    return 73;
                }else if (indexPath.row ==1){
                    return 100;
                }else if (indexPath.row == 2){
                    return 100;
                }else if (indexPath.row ==3){
                    return 100;
                }else if(indexPath.row ==4){
                    return 70;
                }else{
                    return 70;
                }
            }
            return 110;
        }
    }else{
        return 30;
    }

}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == self.messageTableView) {
        return 40;
    }
    return HEIGHT_SERO;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == self.tableView) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }else{
        UILabel *timelable =[UILabel labelWithFrame:CGRectMake(0, 0, tableView.tmri_width, 40) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#777777"]];
        timelable.text = @"   夺宝时间";
        UILabel *userLabel = [UILabel labelWithFrame:CGRectMake(tableView.tmri_width -100, 0, 90, 40) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#777777"]];
        userLabel.text = @"用户ID";
        [timelable addSubview:userLabel];
        return timelable;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableView) {
        static NSString *CellWithIdentifier = @"CheckCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
        if (cell==nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier];
        }else{
            while ([cell.contentView.subviews lastObject] != nil) {
                [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *string = [_talbeViewArray objectAtIndex:indexPath.row];

        if ([string isEqualToString:@"detail"]) {
            
            UILabel *lable = [UILabel labelWithFrame:CGRectMake(10, 15, 200, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor]];
            lable.font = [UIFont systemFontOfSize:15];
            lable.text = @"计算公式";
            
            UILabel *detalLabel = [UILabel labelWithFrame:CGRectMake(10, lable.tmri_bottom , tableView.tmri_width -20, 43) textAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor]];
            detalLabel.numberOfLines = 2;
            detalLabel.text = [NSString stringWithFormat: @"[(数字A + 数值B) ÷ 商品所需人次]取余数 + %@",model.baseNum];
            
            detalLabel.font = [UIFont systemFontOfSize:13];
            
            [cell.contentView addSubview:lable];
            [cell.contentView addSubview:detalLabel];
            cell.backgroundColor = [UIColor colorWithHex:@"DD2727"];
            return cell;
        }else if ([string isEqualToString:@"detailA"]){
            UIView *viewA = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 2, 13)];
            viewA.backgroundColor = [UIColor colorWithHex:@"DD2727"];
            
            UILabel *numberA = [UILabel labelWithFrame:CGRectMake(viewA.tmri_right + 10, 15, 200, 13) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
            numberA.text = @"数值A";
            [cell.contentView addSubview:viewA];
            [cell.contentView addSubview:numberA];

            UILabel *messgagelable = [UILabel labelWithFrame:CGRectMake(10, numberA.tmri_bottom+10,kWIDTH - 40 ,35) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            messgagelable.numberOfLines = 2;
            NSString *allString = [NSString stringWithFormat:@"=截至该奖品最后购买时间点前最后50条全站参与记录的参与时间"];
            messgagelable.text = allString;
            [cell.contentView addSubview:messgagelable];

            UILabel *detaiA  = [UILabel labelWithFrame:CGRectMake(10, messgagelable.tmri_bottom, 200, 25) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            detaiA.text = [NSString stringWithFormat:@"=%@",model.timeSum];
            [cell.contentView addSubview:detaiA];
            
            UIButton *displayButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 80, 80, 60, 20) target:self action:@selector(displayButton:) title:@"展开 " cornerRadius:1];
            
            [displayButton setImage:[UIImage imageNamed:@"下拉(1)"] forState:UIControlStateNormal];
            [displayButton setTitleColor:[UIColor colorWithHex:@"DD2727"] forState:UIControlStateNormal];
            displayButton.titleEdgeInsets = UIEdgeInsetsMake(0, -displayButton.imageView.bounds.size.width, 0, displayButton.imageView.bounds.size.width);
            displayButton.imageEdgeInsets = UIEdgeInsetsMake(0, displayButton.titleLabel.bounds.size.width + 10, 0, 0);
            [cell.contentView addSubview:displayButton];
            displayButton.centerY =detaiA.centerY;
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }else if ([string isEqualToString:@"detailB"]){
            UIView *viewB = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 2, 13)];
            viewB.backgroundColor = [UIColor colorWithHex:@"DD2727"];
            
            UILabel *numberB = [UILabel labelWithFrame:CGRectMake(viewB.tmri_right + 10, 15, 200, 13) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
            numberB.text = @"数值B";
            [cell.contentView addSubview:viewB];
            [cell.contentView addSubview:numberB];
            
            UILabel *messgagelable = [UILabel labelWithFrame:CGRectMake(10, numberB.tmri_bottom+10,kWIDTH - 40 ,35) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            messgagelable.numberOfLines = 2;
            NSString *allString = [NSString stringWithFormat:@"=最近一期中国福利彩票老时时彩的开奖结果"];
            messgagelable.text = allString;
            [cell.contentView addSubview:messgagelable];
            
            UILabel *detaiB  = [UILabel labelWithFrame:CGRectMake(10, messgagelable.tmri_bottom, 200, 25) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            detaiB.text= [NSString stringWithFormat:@"=%@ (第%@期)",model.cpResult,model.cpQihao];

            [cell.contentView addSubview:detaiB];
            cell.backgroundColor = [UIColor whiteColor];

            return cell;

        }else if ([string isEqualToString:@"detailAll"]){
            UIView *viewAll = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 2, 13)];
            viewAll.backgroundColor = [UIColor colorWithHex:@"DD2727"];
            
            UILabel *numberB = [UILabel labelWithFrame:CGRectMake(viewAll.tmri_right + 10, 15, 200, 13) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
            numberB.text = @"商品所需人次";
            [cell.contentView addSubview:viewAll];
            [cell.contentView addSubview:numberB];
            
            UILabel *messgagelable = [UILabel labelWithFrame:CGRectMake(10, numberB.tmri_bottom+10,kWIDTH - 40 ,20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            NSString *allString = [NSString stringWithFormat:@"=%@",model.expected];
            messgagelable.text = allString;
            [cell.contentView addSubview:messgagelable];
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
        }else if([string isEqualToString:@"detailResult"]){
            UIView *viewAll = [[UIView alloc] initWithFrame:CGRectMake(10, 15, 2, 13)];
            viewAll.backgroundColor = [UIColor colorWithHex:@"DD2727"];
            
            UILabel *numberB = [UILabel labelWithFrame:CGRectMake(viewAll.tmri_right + 10, 15, 200, 13) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"DD2727"]];
            numberB.text = @"计算结果";
            [cell.contentView addSubview:viewAll];
            [cell.contentView addSubview:numberB];
            
            UILabel *messgagelable = [UILabel labelWithFrame:CGRectMake(10, numberB.tmri_bottom+10,kWIDTH - 40 ,20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
            NSString *allString = [NSString stringWithFormat:@"幸运号码: %@",model.luckyNumber];
            ;
            messgagelable.text = allString;
            [cell.contentView addSubview:messgagelable];
            cell.backgroundColor = [UIColor whiteColor];

            return cell;
            
        }else{
            NSInteger height = [self getMaxHeightOfHistoryTableView];
            _messageTableView.frame = CGRectMake(0, 0, kWIDTH - 20, height);
            NSLog(@"%ld",height);
            [cell.contentView addSubview:self.messageTableView];
            cell.backgroundColor = [UIColor whiteColor];
            return cell;
        }

    }else{
        static NSString *CellWithIdentifier1 = @"detailCell1";
        YMCalculateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier1];
        if (cell==nil) {
            cell = [[YMCalculateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellWithIdentifier1];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        detailInfo *info = model.processList[indexPath.row];
        cell = [cell congfigWithModel:info];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
    }
    return nil;
}

-(void)displayButton:(UIButton *)button
{
    button.selected = !button.selected;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    NSInteger rotate = 1;
    if (isShowPullDown) {
        rotate = -1;
    }
    button.imageView.transform = CGAffineTransformRotate(button.imageView.transform, M_PI*rotate);
    [UIView commitAnimations];
    
    if (isShowPullDown) {
        
        UIButton *tempButton = (UIButton *)button;
        tempButton.userInteractionEnabled = NO;
        //关闭
        [button setTitle:@"展开" forState:UIControlStateNormal];

        isShowPullDown = NO;
        [_talbeViewArray removeObjectAtIndex:2];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [_messageTableView removeFromSuperview];
            button.userInteractionEnabled = YES;
        }];
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [self.tableView endUpdates];
        [CATransaction commit];
        
    }else{
        //展开
        [button setTitle:@"收起" forState:UIControlStateNormal];
        isShowPullDown = YES;
        [_talbeViewArray insertObject:@"1" atIndex:2];
        
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    }

}
- (NSInteger)getMaxHeightOfHistoryTableView{
    NSInteger height = [model.processList count]*30;
    if (height>30*6) {
        height = 180;
    }
    return height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData
{
    SAFE;
  [[HomeManager sharedManager] detailGetCalculateStatusWithWithGsid:self.gsid completion:^(id result, NSInteger statusCode, NSString *msg) {
      if (statusCode == 0) {
          model = result;
          [self.tableView reloadData];
      }else{
          [weakSelf.view makeToast:msg];

      }
      
  }];
}

@end
