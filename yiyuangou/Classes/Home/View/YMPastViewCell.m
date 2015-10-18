//
//  YMPastViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMPastViewCell.h"

@implementation YMPastViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 85, 85)];
        self.iconView.image = [UIImage imageNamed: @"img_02"];
        
        self.productionLabe = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabe.text = @"IPHONE 6s 手机中的战斗机";
        
        self.priceLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10,self.productionLabe.tmri_bottom, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.priceLable.text = @"价格: ¥5111";

        self.getterLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.priceLable.tmri_bottom,  kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.getterLable.text = @"获奖者： 159****214";
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.getterLable.tmri_bottom, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLable.text = @"参与人数： 50人次";

        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10,self.totalLable.tmri_bottom, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间: 2015-9-17 17:19:05:009";

        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.productionLabe];
        [self.contentView addSubview:self.priceLable];
        [self.contentView addSubview:self.getterLable];
        [self.contentView addSubview:self.totalLable];
        [self.contentView addSubview:self.timeLable];
        
    }
    return self;
}
-(id)configWithModel
{
    return self;
}
@end
