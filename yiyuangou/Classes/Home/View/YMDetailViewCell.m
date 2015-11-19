//
//  YMDetailViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMDetailViewCell.h"

@implementation YMDetailViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 40, 40)];
        [self.iconView.layer setCornerRadius:self.iconView.frame.size.width/2];
        [self.iconView setClipsToBounds:YES];

        self.personLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 7, kWIDTH, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.personLable.text = @"187*****234 (广东 广州)";
        self.detailLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.personLable.tmri_bottom , kWIDTH, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.detailLable.text = @"参与次数: 1次    2015-9-18 19：23 :312 ";
        [self.contentView addSubview: self.iconView];
        [self.contentView addSubview:self.personLable];
        [self.contentView addSubview:self.detailLable];
    }
    return self;
}
-(id)configWithModel:(YMTotalList *)list
{
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.face] placeholderImage:nil];
    self.personLable.text = [NSString stringWithFormat:@"%@  (%@)",list.mobile.length?list.mobile:list.sname,list.place.length?list.place:@"未知"];
    
    self.detailLable.text = [NSString stringWithFormat:@"参与次数: %@次  %@",list.times,list.createTime];

    return self;
}
@end
