//
//  YMRewardPersonCell.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMRewardPersonCell.h"

@implementation YMRewardPersonCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.productionLable = [UILabel labelWithFrame:CGRectMake(10, 0, kWIDTH *0.65, 44) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.productionLable.text = @"(第132 iPhone 6S 玫瑰金 16GB)";
        self.productionLable.font  = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.productionLable];
        
        self.stateView = [UILabel labelWithFrame:CGRectMake(kWIDTH - 60, 10, 50, 16) textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
        self.stateView .backgroundColor = [UIColor colorWithHex:@"#999999"];
        self.stateView.font  =[UIFont  systemFontOfSize:14];
        self.stateView.layer.cornerRadius = 8;
        self.stateView.text =@"已开奖";
        [self.stateView setClipsToBounds:YES];
        self.stateView.centerY = self.productionLable.centerY;
        
        [self.contentView addSubview:self.stateView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.productionLable.tmri_bottom, kWIDTH, 0.5)];
        self.lineView.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        [self.contentView addSubview:self.lineView];
        
        self.iconView= [[UIImageView alloc] initWithFrame:CGRectMake(10, self.lineView.tmri_bottom+ 15, 40, 40)];
        [self.iconView.layer setCornerRadius:self.iconView.frame.size.width/2];
        [self.iconView setClipsToBounds:YES];

        [self.contentView addSubview:self.iconView];

        self.pastGetterLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right+5, self.lineView.tmri_bottom+15, 69, 17) textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
        self.pastGetterLable.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        self.pastGetterLable.text = @"本期获奖者";
        [self.contentView addSubview:self.pastGetterLable];
        
        self.phoneLable = [UILabel labelWithFrame:CGRectMake(self.pastGetterLable.tmri_right + 5, self.lineView.tmri_bottom+10 , kWIDTH -self.pastGetterLable.tmri_right -10 , 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#DD2727"]];
        self.phoneLable.text = @"159****312";
        self.phoneLable.centerY = self.pastGetterLable.centerY;
        [self.contentView addSubview:self.phoneLable];

        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 5, self.pastGetterLable.tmri_bottom , 110, 25) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.totalLable.text = @"参与人次： 50人次";
        [self.contentView addSubview:self.totalLable];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.totalLable.tmri_right ,  self.pastGetterLable.tmri_bottom , kWIDTH -self.totalLable.tmri_right, 25) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.timeLable.text = @"开奖时间： 2015-8-17 17：08：23：23";
        [self.contentView addSubview:self.timeLable];
        if (kWIDTH <375) {
            self.timeLable.font = [UIFont systemFontOfSize:11];
            self.totalLable.font = [UIFont systemFontOfSize:11];
        }
        self.luckLable = [UILabel labelWithFrame:CGRectMake(10 ,  self.iconView.tmri_bottom +10 , (kWIDTH - 20)*0.5, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.luckLable.text = @"中奖号码:1001021";
        [self.contentView addSubview:self.luckLable];

        self.checkluckButton = [UIButton buttonWithFrame:CGRectMake(kWIDTH - 160, self.iconView.tmri_bottom + 10, 150, 20) target:nil action:nil title:@"查看我的幸运码" cornerRadius:1];
        [self.checkluckButton setTitleColor:[UIColor colorWithHex: @"#DD2727"] forState:UIControlStateNormal];
        self.checkluckButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [self.contentView addSubview:self.checkluckButton];

        
    }
    return self;
}
-(id)congifgWithMode:(YMDetailResult *)model
{
    self.productionLable.text = [NSString stringWithFormat:@"(第%ld期) %@",(long)model.period,model.name];
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:headIconHolder];
    self.phoneLable.text = [NSString stringWithFormat:@"%@",model.phone.length?model.phone:model.sname];
        self.totalLable.text = [NSString stringWithFormat: @"本期参与:%@人次",model.actually];
        self.timeLable.text = [NSString stringWithFormat:@"开奖时间:%@",model.time?model.time:@""];
        NSString *totalString = [NSString stringWithFormat:@"中奖号码:  %@",model.luckyNumber];
        self.luckLable.attributedText = [totalString alllString:totalString andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:12] subString:model.luckyNumber andColor:[UIColor colorWithHex:@"4AD107"] andsubFont:[UIFont systemFontOfSize:12]];
    return self;
}

@end
