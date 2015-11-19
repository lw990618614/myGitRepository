//
//  YMProductionCell.m
//  yiyuangou
//
//  Created by roen on 15/10/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMProductionCell.h"
#define photoW 75 //图片的宽度
#define photoH  75 //图片的高度


@implementation YMProductionCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier with:(ShareProduction *)model
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图片
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 35, 35)];
        self.iconView.layer.cornerRadius = self.iconView.width/2.0;
        [self.iconView setClipsToBounds:YES];
        self.imageArray = [[NSMutableArray alloc] init];
        //商品名称
        self.nameLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, 0, (kWIDTH - 60)*0.45, 41) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.nameLable.text = @"格式各样来一份";
        self.nameLable.font = [UIFont systemFontOfSize:16.0];
        self.nameLable.textColor = [UIColor colorWithHex:@"#444444"];
        
        //时间
        self.timeLable = [UILabel labelWithFrame:CGRectMake(self.nameLable.tmri_right, 0, (kWIDTH - 60)*0.55, 44) textAlignment:NSTextAlignmentRight textColor:[UIColor colorWithHex:@"#999999"]];
        if (kWIDTH >=375) {
            self.timeLable.font = [UIFont systemFontOfSize:14.0];
        }

        self.timeLable.text = @"2019-15-08";

        //分割线
        self.seperateView = [[UIView alloc] initWithFrame:CGRectMake(self.iconView.tmri_right + 10, 41, kWIDTH, 1)];
        self.seperateView.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        [self.contentView addSubview:self.seperateView];
        
        //计算label的尺寸
        CGSize detaiSize = [[NSString stringWithFormat:@"%@",model.descrip] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(kWIDTH-75, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        
        self.messgeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right +10, self.seperateView.tmri_bottom + 15, detaiSize.width, detaiSize.height) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.messgeLable.numberOfLines = 0;
        self.messgeLable.text = @"总于中奖了";

        //审核
        self.stateLable = [UILabel labelWithFrame:CGRectMake(self.messgeLable.tmri_right , self.nameLable.tmri_bottom + 5,80, 15) textAlignment:NSTextAlignmentRight textColor:[UIColor blackColor]];
        self.stateLable.text = @"已发布";
        
        self.backView = [[TapImageView alloc] init];

        self.describeLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, self.backView.tmri_bottom +15, kWIDTH , 12) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        self.describeLable.text = @"(第765期) IPhone 玫瑰金64GB";
        

        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLable];
        [self.contentView addSubview:self.backView];
        
        [self.contentView addSubview:self.timeLable];
        [self.contentView addSubview:self.messgeLable];
        [self.contentView addSubview:self.stateLable];
        [self.contentView addSubview:self.pictureView];
        [self.contentView addSubview:self.describeLable];
    }
    return self;
}
-(id)configWithMode:(ShareProduction *)model
{
    for (id view in self.backView.subviews) {
        [view removeFromSuperview];
    }

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.face] placeholderImage:[UIImage imageNamed:@"head"]];
    
    //名字
    self.nameLable.text = model.sname;
    
    NSString *dateStr = [model.createTime getDateStringByFormat:@"yyyy-MM-dd HH:mm:SS" ToFormat:@"yyyy-MM-dd"];
    NSString *stateString;
    NSString *allString;
    //时间
    self.timeLable.text = dateStr;
    //描述
    self.messgeLable.text = model.descrip;
    
    //审核
    self.stateLable.frame = CGRectMake(self.messgeLable.tmri_right , self.nameLable.tmri_bottom + 5,80, 15);
    if (model.status == 0) {
        stateString = @"审核中";
        allString = [NSString stringWithFormat:@"%@ %@",dateStr,stateString];
        self.timeLable.attributedText = [allString alllString:allString andallcolor:[UIColor colorWithHex:@"#999999"] andallFont:[UIFont systemFontOfSize:12] subString:stateString andColor:[UIColor colorWithHex:@"#4AD107"] andsubFont:[UIFont systemFontOfSize:12]];
    }else if (model.status == 1){
        stateString = @"已发布";
        allString = [NSString stringWithFormat:@"%@ %@",dateStr,stateString];
        self.timeLable.attributedText = [allString alllString:allString andallcolor:[UIColor colorWithHex:@"#999999"] andallFont:[UIFont systemFontOfSize:12] subString:stateString andColor:[UIColor colorWithHex:@"#999999"] andsubFont:[UIFont systemFontOfSize:12]];
    }else{
        stateString = @"审核不通过";
        allString = [NSString stringWithFormat:@"%@ %@",dateStr,stateString];
        self.timeLable.attributedText = [allString alllString:allString andallcolor:[UIColor colorWithHex:@"#999999"] andallFont:[UIFont systemFontOfSize:12] subString:stateString andColor:[UIColor colorWithHex:@"#DD2727"] andsubFont:[UIFont systemFontOfSize:12]];
    }
    
    for (int i = 0; i < self.imageArray.count ; i ++) {
        UIImageView *image = self.imageArray[i];
        [self.backView addSubview:image];
    }
    if (model.imageList.count == 0) {
        if (model.descrip.length!=0) {
            self.describeLable.tmri_top = self.messgeLable.tmri_bottom +15;
        }else{
            self.describeLable.tmri_top = self.seperateView.tmri_bottom +15;
        }
    }else{
        self.describeLable.tmri_top = self.backView.tmri_bottom + 15;
    }

       //描述
    self.messgeLable.text = model.descrip;
    //奖品信息
    self.describeLable.text = [NSString stringWithFormat:@"(第%@期) %@",model.period,model.name];
    return self;
}
-(void)showView
{
    if ([self.delegate respondsToSelector:@selector(showBigView:)]) {
        [self.delegate showBigView:self];
    }
}
@end
