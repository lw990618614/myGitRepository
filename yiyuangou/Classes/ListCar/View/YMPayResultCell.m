//
//  YMPayResultCell.m
//  yiyuangou
//
//  Created by roen on 15/11/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPayResultCell.h"

@implementation YMPayResultCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor groupTableViewBackgroundColor];
        
        UIView *backgrundView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, kWIDTH -20, 100)];
        [self.contentView addSubview:backgrundView];
        backgrundView.backgroundColor = [UIColor whiteColor];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 2, 100)];
        self.lineView.backgroundColor = [UIColor colorWithHex:@"#DD2727"];
        [backgrundView addSubview:self.lineView];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.lineView.tmri_right +10, 10, 80, 80)];
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        self.iconView.layer.borderWidth = 0.5;
        [backgrundView addSubview:self.iconView];

        self.productionLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, 10, kWIDTH - 120, 34) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.productionLable.numberOfLines =2;
        [backgrundView addSubview:self.productionLable];
        
        self.timeLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.productionLable.tmri_bottom, kWIDTH, 12) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.timeLabel.centerY = self.iconView.centerY;
        [backgrundView addSubview:self.timeLabel];
        
        self.allNumber = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.timeLabel.tmri_bottom, kWIDTH, 34) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        [backgrundView addSubview:self.allNumber];

    }
    return self;
}
-(id)configWithMode:(GoodInfos*)result
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:result.goodsImage] placeholderImage:carPlaceHolder];
    self.productionLable.text = result.name;
    NSString *allstring = [NSString stringWithFormat:@"期数: %@期",result.period];
    self.timeLabel.attributedText = [allstring alllString:allstring andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:12] subString:result.period andColor:[UIColor colorWithHex:@"#DD2727"] andsubFont:[UIFont systemFontOfSize:12]];
    NSString *numberstring = [NSString stringWithFormat:@"本期参与: %ld人次",(long)result.actually];
    NSString *substring = [NSString stringWithFormat:@"%ld",(long)result.actually];
    self.allNumber.attributedText = [numberstring alllString:numberstring andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:12] subString:substring andColor:[UIColor colorWithHex:@"#4AD107"] andsubFont:[UIFont systemFontOfSize:12]];
    
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
