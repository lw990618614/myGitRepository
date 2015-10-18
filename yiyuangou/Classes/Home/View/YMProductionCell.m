//
//  YMProductionCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMProductionCell.h"


@implementation YMProductionCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        self.iconView.image = [UIImage imageNamed: @"img_02"];
        
        self.nameLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH*0.6, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.nameLable.text = @"格式各样来一份";
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.nameLable.tmri_right-30, 10, kWIDTH-self.nameLable.tmri_right, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.timeLable.text = @"2019-15-08";
        
        self.messgeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.nameLable.tmri_bottom + 5, kWIDTH-self.iconView.tmri_right - 100, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.messgeLable.text = @"总于中奖了";
        
        self.stateLable = [UILabel labelWithFrame:CGRectMake(self.messgeLable.tmri_right , self.nameLable.tmri_bottom + 5,80, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.stateLable.text = @"已发布";

        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(60, self.messgeLable.tmri_bottom + 5, 80, 80)];
        self.pictureView.image = [UIImage imageNamed: @"img_01"];
        
        self.describeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.pictureView.tmri_bottom +5, kWIDTH , 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.describeLable.text = @"(第765期) IPhone 玫瑰金64GB";
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.timeLable];
        [self.contentView addSubview:self.messgeLable];
        [self.contentView addSubview:self.stateLable];
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:self.describeLable];
    }
    return self;
}
-(id)configWithMode
{
    return self;
}
@end
