//
//  YMSettingCell.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMSettingCell.h"

@implementation YMSettingCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 40, 40)];
        self.iconView.image =[UIImage imageNamed:@"mySelIcon"];
        [self.contentView addSubview:self.iconView];
        
        self.accountLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right, 30, 150, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.accountLable.text = @"帐号：123*****3244";
        [self.contentView addSubview:self.accountLable];
        
        self.userNameLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right, self.accountLable.tmri_bottom, 150, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.userNameLable.text = @"昵称：thoo";
        [self.contentView addSubview:self.userNameLable];
        
        self.leftLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right, self.userNameLable.tmri_bottom, 150, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.leftLable.text = @"抢币余额：123抢币";
        [self.contentView addSubview:self.leftLable];
        
        self.fillButton = [UIButton buttonWithFrame:CGRectMake(200, 0, 100, 30) target:nil action:nil title:@"充值" cornerRadius:3];
        [self.fillButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.fillButton setBackgroundColor:[UIColor redColor]];
        [self.contentView addSubview:self.fillButton];
        self.fillButton.centerY = self.userNameLable.centerY;
    }
    return self;
}
@end
