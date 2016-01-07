//
//  YMListCell.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMListCell.h"
#import "UIImageView+WebCache.h"
@implementation YMListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 90, 90)];
        self.iconView.layer.borderWidth = 0.5;
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        [self.contentView addSubview:self.iconView];
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.iconView.orignY, kWIDTH - self.iconView.tmri_right -10, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabel.font = [UIFont systemFontOfSize:15.0];
        self.productionLabel.textColor = [UIColor colorWithHex:@"777777"];
        self.productionLabel.text = @"iphone 6s 就这么吊";
        [self.contentView addSubview:self.productionLabel];
        self.reawardLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.productionLabel.orignX, self.productionLabel.tmri_bottom + 10, 50, 20)];
        self.reawardLbl.textColor = [UIColor lightColor];
        self.reawardLbl.font = [UIFont systemFontOfSize:14.0];
        self.reawardLbl.text = @"获奖者:";
        [self.contentView addSubview:self.reawardLbl];
        
        //获奖电话
        self.rewardPhone = [[UILabel alloc] initWithFrame:CGRectMake(self.reawardLbl.tmri_right, self.reawardLbl.orignY, 140, self.reawardLbl.height)];
        self.rewardPhone.textColor = [UIColor  colorWithHex:@"#DD2727"];
        self.rewardPhone.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:self.rewardPhone];
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.reawardLbl.tmri_bottom + 10, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    
        self.totalLable.text = @"参与次数： 123次";
        self.totalLable.font  = [UIFont systemFontOfSize:14.0];
        self.totalLable.textColor = [UIColor lightColor];
        [self.contentView addSubview:self.totalLable];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom + 10, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.textColor = [UIColor lightColor];
        self.totalLable.font  = [UIFont systemFontOfSize:14.0];
        self.timeLable.text = @"开奖时间：2015-19-09 14：34：34";
        [self.contentView addSubview:self.timeLable];
        
        self.luckNumBtn = [[UIButton alloc]initWithFrame:CGRectMake(kWIDTH - 120, self.productionLabel.tmri_bottom + 10, 90, 30)];
        [self.luckNumBtn setTitle:@"查看幸运码" forState:UIControlStateNormal];
//        self.luckNumBtn.backgroundColor  = [UIColor colorWithHex: @"#DD2727"];
        self.luckNumBtn.layer.cornerRadius = 5.0;
        self.luckNumBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.luckNumBtn setTitleColor:[UIColor colorWithHex:@"#DD2727"] forState:UIControlStateNormal];
        [self.luckNumBtn addTarget:self action:@selector(luckNumBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.luckNumBtn];
    
    }
    return self;
}
-(id)congfigWithModle:(NSDictionary *)dict
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:dict[@"goodsImage"]] placeholderImage:carPlaceHolder];
    self.timeLable.text = [NSString stringWithFormat:@"开奖时间:%@",dict[@"endTime"]];
//    self.productionLabel.text  = dict[@"name"];
    self.productionLabel.text = [NSString stringWithFormat:@"第%@期 %@",dict[@"period"],dict[@"name"]];
    NSDictionary *attGray = @{
                                  NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                  NSForegroundColorAttributeName:[UIColor lightColor]
                                  };
    NSDictionary *attGreen = @{
                                   NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                                   NSForegroundColorAttributeName:[UIColor colorWithHex:@"4ad107"]
                                   };
    NSDictionary *attRed = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                               NSForegroundColorAttributeName:[UIColor  colorWithHex:@"#DD2727"],
                               };
    if(dict[@"phone"] == nil)
    {
       [self.rewardPhone removeFromSuperview];
       [self.reawardLbl removeFromSuperview];
        self.luckNumBtn.hidden = NO;        
        NSString *str =  [NSString stringWithFormat:@"开奖时间:还需要%@名用户购买",dict[@"leftAmount"]];
//        self.productionLabel.text  = dict[@"name"];
        if ([dict[@"leftAmount"] integerValue] == 0) {
            self.timeLable.text =  @"开奖时间:待开奖";
        }
        else
        self.timeLable.attributedText = [self genAttibuteStr:str newhandleStr:[NSString stringWithFormat:@"%@",dict[@"leftAmount"]] commonAttDic:attGray handleDic:attRed];
        NSString *takePart  = [NSString stringWithFormat:@"我的购买份数:%@",dict[@"actually"]];
        self.totalLable.attributedText = [self genAttibuteStr:takePart newhandleStr:[NSString stringWithFormat:@"%@",dict[@"actually"]] commonAttDic:attGray handleDic:attGreen];

    }
    else
    {
        [self.contentView addSubview:self.rewardPhone];
        [self.contentView addSubview:self.reawardLbl];
        self.luckNumBtn.hidden =  YES;
        NSString *name = (dict[@"phone"] == nil || [dict[@"phone"] isEqualToString:@""])?dict[@"sname"]:dict[@"phone"];
        self.rewardPhone.text = [NSString stringWithFormat:@"%@",name];
        NSString *str =  [NSString stringWithFormat:@"开奖时间:%@",dict[@"endTime"]];
        if (![dict[@"endTime"] isValid]) {
            self.timeLable.attributedText = [self genAttibuteStr:str newhandleStr:[NSString stringWithFormat:@"%@",dict[@"endTime"] ] commonAttDic:attGray handleDic:attGray];
        }
        NSString *takePart  = [NSString stringWithFormat:@"参与次数:%@",dict[@"actually"]];
        self.totalLable.attributedText = [self genAttibuteStr:takePart newhandleStr:[NSString stringWithFormat:@"%@",dict[@"actually"]] commonAttDic:attGray handleDic:attGreen];

    }
    return self;
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
-(void)luckNumBtnAction:(id) sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(luckNum:)]) {
        [self.delegate luckNum:self];
    }
}
@end
