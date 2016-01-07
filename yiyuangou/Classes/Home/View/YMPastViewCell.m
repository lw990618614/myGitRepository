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
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        self.iconView.layer.borderWidth = 0.5;
        
        //商品
        self.productionLabe = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 12, 15, kWIDTH - 110, 16) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#777777"]];
        self.productionLabe.font  = [UIFont systemFontOfSize:16];
        self.productionLabe.text = @"IPHONE 6s 手机中的战斗机";
        
        
        //获奖者
        UILabel *info = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 12, self.productionLabe.tmri_bottom + 2.5, 50, 14) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#777777"]];
        info.text = @"获奖者:";
        info.font  =[UIFont systemFontOfSize:14];
        
        //获奖id
        self.getterLable = [UILabel labelWithFrame:CGRectMake(info.tmri_right , self.productionLabe.tmri_bottom + 2.5,  kWIDTH, 14) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#DD2727"]];
        self.getterLable.font  =[UIFont systemFontOfSize:14];
        self.getterLable.text = @"获奖者： 159****214";

        //参与人次
        self.totalLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +12, info.tmri_bottom+2.5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.totalLable.text = @"参与人数： 50人次";

        //价格
        self.priceLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 12,self.totalLable.tmri_bottom, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.priceLable.text = @"商品价格: ¥5111";

        //时间
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +12,self.priceLable.tmri_bottom, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.timeLable.text = @"开奖时间: 2015-9-17 17:19:05:009";

        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.productionLabe];
        [self.contentView addSubview:info];
        [self.contentView addSubview:self.priceLable];
        [self.contentView addSubview:self.getterLable];
        [self.contentView addSubview:self.totalLable];
        [self.contentView addSubview:self.timeLable];
        
    }
    return self;
}
-(id)configWithModel:(YMLottery *)model
{
//    NSString *imageUlr = [NSString stringWithFormat:@"%@%@",BaseServerImagesURL,model.goodsImage];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.image100by100] placeholderImage:carPlaceHolder];
    
    self.productionLabe.text = model.name;
    
    self.priceLable.text = [NSString stringWithFormat:@"商品价格:  %@ [第%@期]",model.price,model.period];
    
    NSString *textstr = [NSString stringWithFormat:@"%ld",(long)model.uid];
    
    self.getterLable.text = model.phone.length?model.phone:model.sname.length?model.sname:textstr;

    self.totalLable.text = [NSString stringWithFormat:@"参与人次: %@次",model.menber];

    self.timeLable.text = [NSString stringWithFormat:@"开奖时间: %@",model.createTime];

    return self;
}
@end
