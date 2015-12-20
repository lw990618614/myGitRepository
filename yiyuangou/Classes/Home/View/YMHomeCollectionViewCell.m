//
//  YMHomeCollectionViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/8.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeCollectionViewCell.h"
@implementation YMHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 87)];
        self.iconView.image = [UIImage imageNamed:@"img_04"];
//        self.iconView.layer.borderWidth = 1;
        self.iconView.contentMode =  UIViewContentModeScaleAspectFill;
        [self.iconView setClipsToBounds:YES];

        [self.contentView addSubview:self.iconView];

        self.detailLable = [UILabel labelWithFrame:CGRectMake(10, self.iconView.tmri_bottom+12.5, (frame.size.width-20)*0.7, 12) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        self.detailLable.text = @"iPhone 6S 16GB";
        [self.contentView addSubview:self.detailLable];
        

        self.carView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width - 23- 15, 23, 23, 22)];
        self.carView.image = [UIImage imageNamed:@"shop+"];
        [self.contentView addSubview:self.carView];
        self.carView.centerY = self.detailLable.centerY;
        
        self.buyView = [UIButton buttonWithFrame:CGRectMake(frame.size.width - 60 , self.detailLable.tmri_bottom +15, 50,25 ) target:self action:@selector(buyClick) title:@"抢购" cornerRadius:2];
        [self.buyView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.buyView setBackgroundColor:[UIColor  colorWithHex:@"#DD2727"]];
        self.buyView.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.buyView];

        self.pro = [[YMProgressView alloc] initWithFrame:CGRectMake(10, self.detailLable.tmri_bottom +10,frame.size.width - 10 - self.buyView.tmri_width - 15 , 23) ];
        
        self.pro.centerY = self.buyView.centerY;
        [self.contentView addSubview:self.pro];
        
        self.middleView = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width -1, 0, 1, frame.size.height)];
        self.middleView.backgroundColor= [UIColor colorWithHex:@"#EAEAEA"];
        [self.contentView addSubview:self.middleView];
        
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height -1, frame.size.width, 1)];
        bottomView.backgroundColor= [UIColor colorWithHex:@"#EAEAEA"];
        [self.contentView addSubview:bottomView];
        
        UITapGestureRecognizer *buygesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buyClick)];
        self.buyView.userInteractionEnabled = YES;
        [self.buyView addGestureRecognizer:buygesture];
        
        
        UIButton *button =  [UIButton buttonWithFrame:CGRectMake(0, 0, 50, 50) target:self action:@selector(carClick) title:nil cornerRadius:1];
        button.center = self.carView.center;
        button.centerY = self.carView.centerY - 10;
        [self.contentView addSubview:button];


    }
    return self;
}
-(id)configWithMode:(HomeHotList*)list;
{
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:list.goodsImage] placeholderImage:placeHolder];
    self.pro.progressView.progress = list.progress?[list.progress intValue]/100.0:0;
    self.pro.ProgressNumber.text = [NSString stringWithFormat:@"%@%%",list.progress];
    self.detailLable.text = list.name;
    return self;
}
-(void)buyClick
{
    NSLog(@"buyClick");
    if ([self.delegate respondsToSelector:@selector(buyViewclick:)]) {
        [self.delegate buyViewclick:self];
    }
}
-(void)carClick
{

    if ([self.delegate respondsToSelector:@selector(carViewclick:)]) {
        [self.delegate carViewclick:self];
    }
}

@end
