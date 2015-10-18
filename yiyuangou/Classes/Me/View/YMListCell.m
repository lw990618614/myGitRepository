//
//  YMListCell.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMListCell.h"

@implementation YMListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 45, 45)];
        self.iconView.image = [UIImage imageNamed:@"searchSelIcon"];
        [self.contentView addSubview:self.iconView];
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabel.text = @"iphone 6s 就这么吊";
        [self.contentView addSubview:self.productionLabel];
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLable.text = @"我的参与次数： 123次";
        [self.contentView addSubview:self.totalLable];
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.totalLable.tmri_bottom, kWIDTH - 75, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间：2015-19-09 14：34：34";
        [self.contentView addSubview:self.timeLable];
        
        self.phoneLable = [UILabel labelWithFrame:CGRectMake(kWIDTH - 150, 10, 140, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor redColor]];
        self.phoneLable.text = @"获奖者 ：159****3435";
        [self.contentView addSubview:self.phoneLable];

    }
    return self;
}
-(id)congfigWithModle
{
    return self;
}
@end
