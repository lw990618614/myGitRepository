//
//  MyCarViewController.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MyCarViewController.h"
#import "YMPayController.h"
#import "MyCarViewCell.h"
#import "MyCarManager.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
typedef void(^TextFiledBlock)();

@interface MyCarViewController ()<UITableViewDataSource,UITableViewDelegate,MyCarViewCellDelegate,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray *carArray;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *messageLabel;
@property (nonatomic, strong)UIView  *footView;
@property (nonatomic,strong)NSMutableArray *selctCarArray;
@property (nonatomic,strong)UIButton *clickButton;
@property (nonatomic,strong)NSTimer *timer;
@property (nonatomic,strong)UIButton *submintButton;
@property (nonatomic,strong)UIView *notiView;
@property (nonatomic,copy)TextFiledBlock edtingBlock;
@property (nonatomic,copy)TextFiledBlock endEdtingBlock;

@end

@implementation MyCarViewController
-(NSMutableArray *)selctCarArray
{
    if (_selctCarArray == nil) {
        _selctCarArray = [[NSMutableArray alloc] init];
        
    }
    return _selctCarArray;
}
-(UIView *)notiView
{
    if (_notiView == nil) {
        _notiView = [[UIView alloc] initWithFrame:self.view.bounds];
        _notiView.backgroundColor  =[UIColor colorWithHex:@"#EAEAEA"];
        
        UIImageView *iconView = [UIImageView new];
        iconView.image = [UIImage imageNamed:@"空购物车"];
        [_notiView addSubview:iconView];
        
        UILabel *lable = [UILabel labelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        lable.text = @"购物车里啥都没有,主人快去夺宝吧!";
        lable.font = [UIFont systemFontOfSize:16];
        [_notiView addSubview:lable];
        
        UIButton *notibutton = [UIButton buttonWithFrame:CGRectZero target:self action:@selector(goshopping) title:@"立即抢购" cornerRadius:1];
        notibutton.backgroundColor  =  [UIColor colorWithHex:@"#DD2727"];
        notibutton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_notiView addSubview:notibutton];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(lable);
            make.bottom.mas_equalTo(lable.mas_top).mas_offset(-20);
        }];
        
        [lable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_notiView);
            make.width.mas_equalTo(kWIDTH);
            make.height.mas_equalTo(16);
        }];
        
        [notibutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(lable.mas_bottom).mas_offset(20);
            make.width.mas_equalTo(200);
            make.height.mas_equalTo(50);
            make.centerX.mas_equalTo(_notiView);
        }];
    }
    return _notiView;
}
-(UITableView*)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64- 50) style:UITableViewStyleGrouped];
    }
    return _tableView;
}
-(UIView *)footView
{
    if (_footView == nil) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, kHEIGHT  - 64- 50 - 45, kWIDTH, 45)];
        UIView *headView = [[UIView alloc] initWithFrame:_footView.bounds];
        headView.tmri_width = kWIDTH -85;
        _footView.backgroundColor = [UIColor whiteColor];
        [_footView addSubview:headView];
        
        UIButton *submintButton =[UIButton buttonWithType:UIButtonTypeCustom];
        submintButton.frame =CGRectMake(kWIDTH - 85, 0, 85, 45);
        [submintButton addTarget:self action:@selector(btnClcik:) forControlEvents:UIControlEventTouchUpInside];
        [submintButton setTitle:@"提交订单" forState:UIControlStateNormal];
        submintButton.titleLabel.font = [UIFont systemFontOfSize:15];
        submintButton.tag = 50;
        submintButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [submintButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_footView addSubview:submintButton];
        
        UIButton *clickButton = [UIButton buttonWithFrame:CGRectMake(0, 5, 40, 40) target:self action:@selector(btnClcik:) title:nil cornerRadius:1];
        [clickButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
        clickButton.tag =51;
        clickButton.selected= YES;
        self.clickButton = clickButton;
        [headView addSubview:clickButton];
        
        UILabel *allLabel = [UILabel labelWithFrame:CGRectMake(clickButton.tmri_right, 5, 30, 40) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        allLabel.text = @"全选";
        [headView addSubview:allLabel];
        
        UILabel *messageLabel =  [UILabel labelWithFrame:CGRectMake(allLabel.tmri_right, 15, kWIDTH *0.75 - allLabel.tmri_right, 20) textAlignment:NSTextAlignmentCenter textColor:[UIColor grayColor]];
        messageLabel.text = @"共0件商品,需要消耗0抢币";
        self.messageLabel =messageLabel;
        [headView addSubview:messageLabel];
        
        self.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
            [self.tableView.header endRefreshing];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textchange) name:TEXT_CHANGE object:nil];
    }
    return _footView;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"购物车";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(loadData) name:CAR_ISCHANGE object:nil];
    SAFE;
    self.edtingBlock= ^{
        weakSelf.tableView.header = nil;
//        weakSelf.tableView.userInteractionEnabled = NO;
    };
    self.endEdtingBlock= ^{
        weakSelf.tableView.header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
            [weakSelf.tableView.header endRefreshing];
        }];
    };
    [self loadData];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.carArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCarViewCell = @"myCarViewCell";
    MyCarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCarViewCell];
    if (cell == nil) {
        cell = [[MyCarViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCarViewCell];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    YMCarInfo*model = self.carArray[indexPath.row];
    cell.edtingBlock = self.edtingBlock;
    cell.endEdtingBlock = self.endEdtingBlock;
    cell = [cell configWithMode:model];
    return cell;
}
-(UITableViewCellEditingStyle)tableView:(UITableView*)tableView  editingStyleForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    YMCarInfo *model = self.carArray[indexPath.row];
//    [self.view makeToastActivity:kLoadingText];
    [self.selctCarArray removeObject:model];

    SAFE;
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        [[MyCarManager sharedManager] deletmyCarStatusWith:model.gid completion:^(id result, NSInteger statusCode, NSString *msg) {
            [weakSelf.view hideToastActivity];
            if (statusCode == 0) {
                NSInteger row = [indexPath row];
                [weakSelf.carArray removeObjectAtIndex:row];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                NSLog(@"%ld",weakSelf.selctCarArray.count);
                if (weakSelf.carArray.count == 0) {
                    weakSelf.footView.hidden = YES;
                    [weakSelf.view addSubview:self.notiView];
                }
            }
        }];
    }
}
-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexpath
{
    return @"删除";
}
-(void)loadData
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[MyCarManager sharedManager] myCarStatuscompletion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if ( statusCode == 0) {
            YMCarResult *carresult = result;
            [weakSelf.selctCarArray removeAllObjects];
            for (YMCarInfo *carInfo in carresult.carList) {
                carInfo.buyCount=[carInfo.leftAmount integerValue]>10?10:[carInfo.leftAmount integerValue];
                carInfo.allPrice = carInfo.buyCount *[carInfo.price integerValue];
                carInfo.buyCount = [carInfo.leftAmount intValue]>10?10.0:[carInfo.leftAmount intValue];
                carInfo.is_selete = YES;
                carInfo.lastis_selete = NO;
            }
            weakSelf.carArray = carresult.carList;
            [weakSelf.selctCarArray addObjectsFromArray:weakSelf.carArray];

            [weakSelf.clickButton setImage:[UIImage imageNamed:@"0"] forState:UIControlStateNormal];
            if (weakSelf.carArray.count > 0) {
                weakSelf.footView.hidden = NO;
                [weakSelf.notiView removeFromSuperview];
                [weakSelf.view addSubview:self.footView];
            }else{
                [self.view addSubview:self.notiView];
                weakSelf.footView.hidden  = YES;
            }
            [_clickButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
            _clickButton.selected= YES;
            [weakSelf.tableView reloadData];
        }else{
            [weakSelf.view makeToast:msg];
        }
    }];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)btnClcik:(UIButton *)button
{
    if (button.tag == 51) {
        button.selected = !button.selected;

        UIButton*btn = (UIButton *)[button viewWithTag:button.tag];
        if (!button.selected) {
            [self.selctCarArray removeAllObjects];
            [btn setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
            for (YMCarInfo *carInfo in self.carArray) {
                carInfo.is_selete = NO;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:DELETE_MYCAR object:nil];
            
        }else
        {
            [self.selctCarArray removeAllObjects];
            for (YMCarInfo *info in self.carArray) {
                info.is_selete = YES;
            }
            [self.selctCarArray addObjectsFromArray:self.carArray];
            [btn setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
            [[NSNotificationCenter defaultCenter] postNotificationName:ADDALL_MYCAR object:nil];

        }
        [[NSNotificationCenter defaultCenter] postNotificationName:TEXT_CHANGE object:nil];
        
    }else{
        [self submitTheOrder];
    }
}
-(void)selectedCell:(MyCarViewCell*)cell
{
    
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    YMCarInfo *model = self.carArray[path.row];
    [self.selctCarArray addObject:model];
    if (self.selctCarArray.count == self.carArray.count) {
        self.clickButton.selected = YES;
        [self.clickButton setImage:[UIImage imageNamed:CellSelectImage] forState:UIControlStateNormal];
    }else{
        self.clickButton.selected = NO;
        [self.clickButton setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
    }
    
    
    
}
-(void)deselectedCell:(MyCarViewCell *)cell
{
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    YMCarInfo *model = self.carArray[path.row];
    [self.selctCarArray removeObject:model];
    self.clickButton.selected = NO;
    [self.clickButton setImage:[UIImage imageNamed:CellUnSelectImage] forState:UIControlStateNormal];
    
    
}
-(void)submitTheOrder
{
    if (self.selctCarArray.count == 0) {
        [self.view makeToast:@"请选择购买物品"];
        return;
    }
    for (YMCarInfo *info in self.carArray) {
        if (info.buyCount == 0) {
            [self.selctCarArray removeObject:info];
        }
    }
    
    if (self.selctCarArray.count == 0) {
        [self.view makeToast:@"您所选的商品数量\n只剩0份,请重新选择"];
        return ;

    }

    NSMutableArray *carArray  = [[NSMutableArray alloc] init];
    [carArray addObjectsFromArray:self.selctCarArray];
    YMPayController *controller = [[YMPayController alloc] init];
    controller.backstring = self.title;
    controller.selectedArray = carArray;
    [self setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
    [self setHidesBottomBarWhenPushed:NO];

}
-(void)textchange
{
    int money =0 ;
    
    for (YMCarInfo *goodInfo in self.selctCarArray) {
        if (goodInfo.is_end) {
            money += [goodInfo.leftAmount intValue] *[goodInfo.price intValue];
        }else{
            money =  money +goodInfo.allPrice;
        }
    }
    self.messageLabel.text = [NSString stringWithFormat:@"共%ld件商品,需要消耗%d抢币",(unsigned long)self.selctCarArray.count,money];
}
-(void)goshopping
{
    AppDelegate *delegate =  (AppDelegate *)[UIApplication sharedApplication].delegate;
    YMTabBarController *tabbar =  (YMTabBarController *)delegate.window.rootViewController;
    [tabbar setSelectedIndex:0];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
