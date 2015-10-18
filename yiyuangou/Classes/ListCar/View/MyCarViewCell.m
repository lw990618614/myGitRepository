//
//  MyCarViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MyCarViewCell.h"

@implementation MyCarViewCell 
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.roundView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 7, 7)];
        self.roundView.image=[UIImage imageNamed:@"round"];
        [self.contentView addSubview:self.roundView];
        
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.roundView.tmri_right +5, 5, 80, 80)];
        self.iconView.image = [UIImage imageNamed: @"img_02"];
        [self.contentView addSubview:self.iconView];
        
        self.productionLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +5, 5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLable.text = @"iPhone 6s,手机中的柴油机";
        [self.contentView addSubview:self.productionLable];
        
        self.detailLable =[UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +5, self.productionLable.tmri_bottom+5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.detailLable.text = @"总需求6798/剩余2321";
        [self.contentView addSubview:self.detailLable];
    
        self.numbersView = [[PKYStepper alloc] init];
        self.numbersView.frame = CGRectMake(self.iconView.tmri_right+5, self.detailLable.tmri_bottom + 5, 100, 20);
        [self.contentView addSubview:self.numbersView];
        
        self.pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(self.numbersView.tmri_right + 5, self.detailLable.tmri_bottom + 5, 20, 20)];
        self.pictureView.image=[UIImage imageNamed:@"round"];
        [self.contentView addSubview:self.pictureView];
        
        self.messageLable =[UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +5, self.pictureView.tmri_bottom+5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.detailLable.text = @"最新一期奖品正在抢购中";
        [self.contentView addSubview:self.messageLable];
    }
    return self;
}
-(id)configWithMode
{
    return self;
}
@end
