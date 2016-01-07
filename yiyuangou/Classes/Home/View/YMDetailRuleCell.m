//
//  YMDetailRuleCell.m
//  yiyuangou
//
//  Created by roen on 15/11/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMDetailRuleCell.h"

@implementation YMDetailRuleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor= [UIColor whiteColor];
        self.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.ruleButton = [UIButton buttonWithFrame:CGRectMake(15, 10, kWIDTH-30, 30) target:nil action:nil title:@"查看计算方式" cornerRadius:1];
        self.ruleButton.layer.borderColor = [UIColor colorWithHex:@"#DD2727"].CGColor;
        self.ruleButton.layer.borderWidth = 1;
        self.ruleButton.backgroundColor = [UIColor whiteColor];
        [self.ruleButton setTitleColor:[UIColor colorWithHex:@"#DD2727"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.ruleButton];
        
        self.declareLable = [UILabel labelWithFrame:CGRectMake(0, self.ruleButton.tmri_bottom , kWIDTH, 30) textAlignment:NSTextAlignmentCenter textColor:[UIColor heightBlacKColor]];
        self.declareLable.text = @"声明:所有商品抽奖活动与苹果公司(Apple lnc.)无关";
        self.declareLable.font = [UIFont boldSystemFontOfSize:12];
        [self.contentView addSubview:self.declareLable];
    }
    return self;
}
@end
