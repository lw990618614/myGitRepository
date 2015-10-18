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
        self.productionLable = [UILabel labelWithFrame:CGRectMake(10, 10, kWIDTH *0.65, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLable.text = @"(第132 iPhone 6S 玫瑰金 16GB)";
        [self.contentView addSubview:self.productionLable];
        
        self.stateView = [[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH-70,10, 60, 15)];
        self.stateView.image = [UIImage imageNamed:@"discountDefIcon"];
        [self.contentView addSubview:self.stateView];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.stateView.tmri_bottom +5, kWIDTH, 1)];
        self.lineView.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:self.lineView];
        
        self.detailView = [[UILabel alloc] initWithFrame:CGRectMake(10, self.lineView.tmri_bottom + 10, kWIDTH - 20, 100)];
        self.detailView.layer.borderColor = [UIColor grayColor].CGColor;
        self.detailView.layer.borderWidth = 2;
        [self.contentView addSubview:self.detailView];
        
        self.pastGetterLable = [UILabel labelWithFrame:CGRectMake(10, 10, 100, 30) textAlignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
        self.pastGetterLable.backgroundColor = [UIColor redColor];
        self.pastGetterLable.text = @"上期获奖者";
        [self.detailView addSubview:self.pastGetterLable];
        
        self.iconView= [[UIImageView alloc] initWithFrame:CGRectMake(10, self.pastGetterLable.tmri_bottom+ 10, 45, 45)];
        self.iconView.image = [UIImage imageNamed:@"mySelIcon"];
        [self.detailView addSubview:self.iconView];
        
        self.phoneLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.pastGetterLable.tmri_bottom+10 , kWIDTH -self.iconView.tmri_right -10 , 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.phoneLable.text = @"获奖者: 159*****312";
        [self.detailView addSubview:self.phoneLable];
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.phoneLable.tmri_bottom , kWIDTH -self.iconView.tmri_right -10, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLable.text = @"参与人次： 50人次";
        [self.detailView addSubview:self.totalLable];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10,  self.totalLable.tmri_bottom , kWIDTH -self.iconView.tmri_right -10, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间： 2015-8-17 17：08：23：23";
        [self.detailView addSubview:self.timeLable];

    }
    return self;
}
-(id)congifgWithMode
{
    return self;
}

@end
