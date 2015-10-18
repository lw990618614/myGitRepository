//
//  RewardViewControllerCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "RewardViewControllerCell.h"

@implementation RewardViewControllerCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 100, 100)];
        self.iconView.image = [UIImage imageNamed:@"img_01"];
        
        self.productionLabel = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLabel.text = @"IPhone 6S 玫瑰金 16GB";
        
        self.priceLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.productionLabel.tmri_bottom +5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.priceLable.text = @"价格：¥6666";
        
        self.timeClock = [UIButton buttonWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.priceLable.tmri_bottom + 20, 150, 50) target:nil action:nil title:@"01分58秒89" cornerRadius:6];
        [self.timeClock setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.timeClock.titleLabel.font =[UIFont systemFontOfSize:15];
        [self.timeClock setImage:[UIImage imageNamed:@"mainSelIcon"] forState:UIControlStateNormal];
        self.timeClock.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, self.timeClock.titleLabel.frame.size.width+60);
        
        self.messageView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.tmri_right+10, self.priceLable.tmri_bottom +5, kWIDTH, 60)];
        
        self.getterLable = [UILabel labelWithFrame:CGRectMake(0, 0, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.getterLable.text = @"获奖者: 159****3221";
        
        self.totalLable = [UILabel labelWithFrame:CGRectMake(0, self.getterLable.tmri_bottom +5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.totalLable.text = @"参与人数： 159*****323";
        
        self.timeLable = [UILabel labelWithFrame:CGRectMake(0, self.totalLable.tmri_bottom +5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.timeLable.text = @"开奖时间：2015-2-4 19:04:8:43";
        
        [self.messageView addSubview:self.getterLable];
        [self.messageView addSubview:self.totalLable];
        [self.messageView addSubview:self.timeLable];



        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.productionLabel];
        [self.contentView addSubview:self.priceLable];
        [self.contentView addSubview:self.timeClock];
        [self.contentView addSubview:self.messageView];
        
    }
    return self;
}
-(id)configWithMode
{
    return self;
}
@end
