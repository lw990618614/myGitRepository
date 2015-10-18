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
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
        self.iconView.image = [UIImage imageNamed:@"myDefIcon"];
        self.personLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 10, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.personLable.text = @"187*****234 (广东 广州)";
        self.detailLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.personLable.tmri_bottom + 5, kWIDTH, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.detailLable.text = @"参与次数: 1次    2015-9-18 19：23 :312 ";
        [self.contentView addSubview: self.iconView];
        [self.contentView addSubview:self.personLable];
        [self.contentView addSubview:self.detailLable];
    }
    return self;
}
@end
