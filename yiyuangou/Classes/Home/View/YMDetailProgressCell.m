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
        self.productionLable = [UILabel labelWithFrame:CGRectMake(10, 10, kWIDTH - 20, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLable.text = @"(第132期) IPhone 6S 玫瑰金 16GB";
        self.progressLable = [UILabel labelWithFrame:CGRectMake(10, self.productionLable.tmri_bottom+5, kWIDTH-20, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.progressLable.text = @"开奖进度 75%";

        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, self.progressLable.tmri_bottom + 5, kWIDTH - 20, 10)];
        [self.progressView setProgress:0.75];
        self.progressView.progressTintColor = [UIColor redColor];
        self.totalLabel = [UILabel labelWithFrame:CGRectMake(10, self.progressView.tmri_bottom + 5, kWIDTH * 0.3, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLabel.text = @"总量 5086";

        self.leftLable = [UILabel labelWithFrame:CGRectMake(kWIDTH *0.5, self.progressView.tmri_bottom+10, kWIDTH * 0.5 - 10, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.leftLable.text  = @"剩余1322";
        [self.contentView addSubview:self.productionLable];
        [self.contentView addSubview:self.progressLable];
        [self.contentView addSubview:self.progressView];
        [self.contentView addSubview:self.totalLabel];
        [self.contentView addSubview:self.leftLable];
    }
    return  self;
}
-(id)congifgWithMode
{
    return self;
}
@end
