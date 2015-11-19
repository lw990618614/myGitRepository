//
//  LuckNumView.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/11.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "LuckNumView.h"

@interface LuckNumView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) NSDictionary *dict;
@property(nonatomic,strong) UITableView  *tableview;
@property(nonatomic,strong) UIButton     *sureBtn;
@property(nonatomic,strong) UIView       *footView;
@property(nonatomic,strong) NSArray      *luckNameArray;
@end
@implementation LuckNumView
-(instancetype)initWithDic:(NSDictionary *)dict frame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        _dict = dict;
        self.luckNameArray = dict[@"luckyNumList"];
        [self initWithSubVew];
    }
    return self;
}
//初始化子视图
-(void) initWithSubVew
{
    _tableview = [[UITableView alloc]init];
    _tableview.frame  = CGRectMake(0, 0, 260, 300);
    _tableview.center = self.center;
    _tableview.dataSource = self;
    _tableview.delegate = self;
    _tableview.layer.borderWidth = 1;
    _tableview.layer.borderColor  = [UIColor lightColor].CGColor;
    _tableview.layer.cornerRadius =  3.0;
    [self addSubview:_tableview];
    
        self.footView = [[UIView alloc] initWithFrame:CGRectMake(10, 4, 240, 30)];
        self.sureBtn  = [[UIButton alloc]init];
        [self.footView addSubview:self.sureBtn];
        [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        self.sureBtn.backgroundColor = [UIColor colorWithHex:@"#DD2727"];
        [self.sureBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
         self.sureBtn.layer.cornerRadius = 5;
        self.sureBtn.frame = CGRectMake(20, 2,200, 28);
        self.sureBtn.center = self.footView.center;
    //去掉多余的分割线
    [self.tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,kWIDTH,0)]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(okAction:)];
    [self addGestureRecognizer:tap];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.luckNameArray.count + 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier1 = @"cell1";
    static NSString *identifier2 = @"cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    if (indexPath.row == 0) {
        NSString *goodsName  = [NSString stringWithFormat:@"您的商品:%@",self.dict[@"name"]];
        cell.textLabel.text = goodsName;
        cell.textLabel.textColor = [UIColor heightBlacKColor];
    }
    else if (indexPath.row == 1)
    {

        NSDictionary *attBlack = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:17.0],
                                   NSForegroundColorAttributeName:[UIColor heightBlacKColor]
                                   };
        NSDictionary *attRed = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:17.0],
                                 NSForegroundColorAttributeName:[UIColor redColor],
                                 };
        NSString *period = [NSString stringWithFormat:@"您购买的期数:第%@期",self.dict[@"period"]];
                            cell.textLabel.text = period;
        cell.textLabel.attributedText = [self genAttibuteStr:period newhandleStr:[NSString stringWithFormat:@"%@",self.dict[@"period"]] commonAttDic:attBlack handleDic:attRed];

    }
    else if (indexPath.row ==2 )
    {
        cell.textLabel.text = @"您的幸运码:";
        cell.textLabel.textColor = [UIColor heightBlacKColor];
    }
    else if (indexPath.row == self.luckNameArray.count + 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier2];
        }
        [cell addSubview:self.footView];
        return cell;
    }
    else
    {
        cell.textLabel.text = self.luckNameArray[indexPath.row - 3];
        cell.textLabel.textColor = [UIColor redColor];
    }
    return cell;
}
-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSRange range = [str rangeOfString:subStr];
    NSString *str1 = [str substringToIndex:range.location];
    NSString *str2 = subStr;
    NSString *str3 = [str substringFromIndex:range.location + range.length];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str1 attributes: commonDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2] attributes: handleDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str3 attributes: commonDic]];
    return attStr;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 30;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 30)];
//    self.sureBtn  = [[UIButton alloc]init];
//    [self.footView addSubview:self.sureBtn];
//    [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
//    self.sureBtn.backgroundColor = [UIColor redColor];
//    [self.sureBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
//    self.sureBtn.frame = CGRectMake(0, 0,180, 28);
//    self.sureBtn.center = self.footView.center;
////    WEAKSELF;
////     [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
////         make.center.equalTo(weakSelf.footView);
////         make.size.mas_equalTo(CGSizeMake(80, 28));
////     }];
//    return self.footView;
//}
-(void)okAction:(id) sender
{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
