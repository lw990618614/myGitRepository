//
//  YMCalculateCell.m
//  yiyuangou
//
//  Created by roen on 15/11/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCalculateCell.h"

@implementation YMCalculateCell

- (void)awakeFromNib {
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.timeLable = [UILabel labelWithFrame:CGRectMake(10, 0,( kWIDTH -35)*1, 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        [self.contentView addSubview:self.timeLable];
        
        self.contentLalbe = [UILabel labelWithFrame:CGRectMake(self.timeLable.tmri_right, 0, (kWIDTH - 35) *0.35, 30) textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        self.contentLalbe.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:self.contentLalbe];
    }
    return self;
}
-(id)congfigWithModel:(detailInfo *)model
{
//    NSString *dateStr = [model.createTime getDateStringByFormat:@"yyyy-MM-dd HH:mm:SS" ToFormat:@"yyyy-MM-dd"];

    NSString *timestring = [NSString stringWithFormat:@"%@ -> %@",model.createTime,model.shortTime];
    NSString *substring = [NSString stringWithFormat:@"-> %@",model.shortTime];
    self.timeLable.attributedText =[timestring alllString:timestring andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:12] subString:substring andColor:[UIColor colorWithHex:@"#4AD107"] andsubFont:[UIFont systemFontOfSize:12]];
    
    CGSize detailSize = [timestring sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(kWIDTH, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.timeLable.tmri_width = detailSize.width;
    self.contentLalbe.text = model.sname;
    
    self.contentLalbe.frame = CGRectMake(self.timeLable.tmri_right, 0, kWIDTH-20 - self.timeLable.tmri_width - self.timeLable.MinX, 30);
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
