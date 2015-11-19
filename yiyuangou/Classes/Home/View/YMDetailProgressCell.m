//
//  YMDetailProgressCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMDetailProgressCell.h"
#import "UILabel+tmri.h"
@implementation YMDetailProgressCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       //商品名称
        self.productionLable = [UILabel labelWithFrame:CGRectMake(10, 0, kWIDTH *0.65, 44) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.productionLable.text = @"(第132 iPhone 6S 玫瑰金 16GB)";
        self.productionLable.font  = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.productionLable];

        //开奖进度
        self.progressLable = [UILabel labelWithFrame:CGRectMake(10, self.productionLable.tmri_bottom+5, 70, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.progressLable.font  = [UIFont systemFontOfSize:14];
        self.progressLable.text = @"开奖进度";
        
        //开奖百分比
        self.progressNumber = [UILabel labelWithFrame:CGRectMake(kWIDTH - 60, self.productionLable.tmri_bottom +5, 50, 15) textAlignment:NSTextAlignmentCenter textColor:[UIColor  colorWithHex:@"#DD2727"]];
        
        //进度条
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(self.progressLable.tmri_right, self.productionLable.tmri_bottom + 5, kWIDTH - 20 - self.progressNumber.frame.size.width - self.progressLable.frame.size.width, 10)];
        self.progressView.progressTintColor = [UIColor  colorWithHex:@"#DD2727"];
        self.progressView.transform = CGAffineTransformMakeScale(1.0f,2.0f);
        
        //总量
        self.totalLabel = [UILabel labelWithFrame:CGRectMake(self.progressView.MinX, self.progressView.tmri_bottom + 10, 120, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#999999"]];
        self.totalLabel.font  = [UIFont systemFontOfSize:10];
        self.totalLabel.text = @"总量 5086";

        //剩余数量
        self.leftLable = [UILabel labelWithFrame:CGRectMake(self.totalLabel.tmri_right, self.progressView.tmri_bottom+10, 100, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor  colorWithHex:@"#DD2727"]];
        self.leftLable.tmri_right = self.progressView.tmri_right;
        self.leftLable.font  = [UIFont systemFontOfSize:10];
        self.leftLable.text  = @"剩余1322";

        [self.contentView addSubview:self.productionLable];
        [self.contentView addSubview:self.progressLable];
        [self.contentView addSubview:self.progressView];
        [self.contentView addSubview:self.totalLabel];
        [self.contentView addSubview:self.leftLable];
        [self.contentView addSubview:self.progressNumber];
        self.progressView.centerY =  self.progressLable.centerY = self.progressNumber.centerY;
    }
    return  self;
}
-(id)congifgWithMode:(YMDetailResult *)model
{
    self.productionLable.text = [NSString stringWithFormat: @"(第%ld期) %@",(long)model.period,model.name];
    
    self.progressNumber.text =[NSString stringWithFormat:@"%@%%",model.progress];

    self.progressView.progress = [model.progress floatValue]/100.0;
    self.totalLabel.text = [NSString stringWithFormat:@"总量 %@",model.expected];
    
    NSString *leftString  = [NSString  stringWithFormat:@"剩余 %@",model.LeftAmount];
    self.leftLable.attributedText = [leftString alllString:leftString andallcolor:[UIColor colorWithHex:@"#999999"] andallFont:[UIFont systemFontOfSize:10] subString:model.LeftAmount andColor:[UIColor colorWithHex:@"#DD2727"] andsubFont:[UIFont systemFontOfSize:10]];
    return self;
}
@end
