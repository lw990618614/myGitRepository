//
//  YMHomeCell.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeCell.h"
#define cellWidth frame.size.width
#define cellHeight frame.size.height

@implementation YMHomeCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake( (cellWidth -60)* 0.5, 10,60, 60)];
        self.iconView.image  = [UIImage imageNamed:@"share_02"];
        [self.contentView addSubview:self.iconView];
        self.productionLable = [UILabel labelWithFrame:CGRectMake(0, self.iconView.tmri_bottom +10, cellWidth, 15) textAlignment:NSTextAlignmentCenter textColor:[UIColor blackColor]];
        self.productionLable.text = @"iPhone 6 S";
        [self.contentView addSubview:self.productionLable];
        
        self.prizeButton = [UIButton buttonWithFrame:CGRectMake(0, self.productionLable.tmri_bottom + 10, cellWidth, 15) target:nil action:nil title:@"150***3434" cornerRadius:1];
        [self.prizeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.prizeButton setImage:[UIImage imageNamed:@"searchSelIcon"] forState:UIControlStateNormal];
        [self.contentView addSubview:self.prizeButton];
        
        self.Counter = [[TTCounterLabel alloc] initWithFrame:CGRectMake(0, self.productionLable.tmri_bottom + 10, 70, 15)];
        self.Counter.textAlignment = NSTextAlignmentLeft;
        self.Counter.backgroundColor = [UIColor redColor];
        self.Counter.startValue = 10000;
        [self.Counter start];
        self.Counter.centerX = self.prizeButton.centerX;
        self.Counter.textColor = [UIColor whiteColor];
        [self.contentView addSubview:self.Counter];
    }
    return self;
}
-(id)configWithMode{
    return self;
}
@end
