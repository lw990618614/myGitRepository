//
//  YMDetailTimeCell.m
//  yiyuangou
//
//  Created by roen on 15/10/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMDetailTimeCell.h"
@interface  YMDetailTimeCell()<TTCounterLabelDelegate>
@end
@implementation YMDetailTimeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor= [UIColor colorWithRed:97 green:121 blue:122 alpha:1];
        self.productionLable = [UILabel labelWithFrame:CGRectMake(10, 0, kWIDTH - 20, 44) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.productionLable.text = @"(第132期) IPhone 6S 玫瑰金 16GB";
        self.productionLable.font  =  [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.productionLable];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, kWIDTH, 1)];
        lineView.backgroundColor  = [UIColor  colorWithHex:@"#EAEAEA"];
        [self.contentView addSubview:lineView];

        self.timeString = [UILabel labelWithFrame:CGRectMake(0, lineView.tmri_bottom+10 , kWIDTH *0.5, 50) textAlignment:NSTextAlignmentRight textColor:[UIColor  colorWithHex:@"#DD2727"]];
        self.timeString.text = @"揭晓倒计时";
        self.timeString.font = [UIFont  systemFontOfSize:15];
        [self.contentView addSubview:self.timeString];
        
        self.notiButton = [UIButton buttonWithFrame:CGRectMake(10, lineView.tmri_bottom , kWIDTH -20, 50) target:nil action:nil title:@"揭晓中..." cornerRadius:1];
        self.notiButton.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
        [self.contentView addSubview:self.notiButton];
        
        [self.ruleButton setTitleColor: [UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        self.ruleButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.ruleButton];
        
        self.timelable = [[TTCounterLabel alloc] initWithFrame:CGRectMake(self.timeString.tmri_right, lineView.tmri_bottom+10 ,kWIDTH *0.5, 50)];
        self.timelable.textAlignment = NSTextAlignmentLeft;
        self.timelable.countdownDelegate = self;
        self.timelable.textColor = [UIColor  colorWithHex:@"#DD2727"];
        [self.contentView addSubview:self.timelable];
        
        self.luckButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [self.luckButton setTitleColor: [UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
        self.luckButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.luckButton];
        
        self.timelable.hidden = NO;
        self.timeString.hidden = NO;
        self.ruleButton.hidden = NO;
        self.luckButton.hidden = NO;
        self.notiButton.hidden = YES;
    }
    return self;
}
-(id)congfigWithModel:(YMDetailResult *)model
{

    self.productionLable.text = [NSString stringWithFormat:@"(第%ld期)  %@ ",(long)model.period,model.name];
//    self.notiButton.hidden = YES;
//    self.timelable.hidden = NO;
//    self.timeString.hidden = NO;
//    self.ruleButton.hidden = NO;

    self.timelable.startValue = [model.progress floatValue] +6000;
    [self.timelable start];
    return self;
}
- (void)countdownDidEnd
{
    self.notiButton.hidden = NO;
    self.timelable.hidden = YES;
    self.timeString.hidden = YES;
    self.ruleButton.hidden = YES;
    self.luckButton.hidden = YES;
    [self performSelector:@selector(timeOver) withObject:nil afterDelay:1.0f];
   
}
-(void)timeOver
{
    
    if ([self.delegate respondsToSelector:@selector(timedownDidEnd:)]) {
        [self.delegate timedownDidEnd:self];
    }

}
@end
