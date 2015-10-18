//
//  YMOrderView.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMOrderView.h"
@interface YMOrderView()<UIGestureRecognizerDelegate>
@property (nonatomic,strong)UIButton *button;
@end
@implementation YMOrderView
-(instancetype)initWithFrame:(CGRect)frame withModel:(NSData *)data
{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        iconView.image = [UIImage imageNamed:@"discountSelIcon"];
        [self addSubview:iconView];
        
        UILabel *productionLable = [UILabel labelWithFrame:CGRectMake(iconView.tmri_right + 10, 10, kWIDTH * 0.7, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        productionLable.text =@"这是一个新的产品";
        [self addSubview:productionLable];
        
        UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH - 22, 10, 15, 15)];
        deleteView.image = [UIImage imageNamed:@"delete"];
        UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delectClick)];
        [deleteView addGestureRecognizer:gesture];
        deleteView.userInteractionEnabled=YES;
        [self addSubview:deleteView];
        
        UILabel * BuyLable = [UILabel labelWithFrame:CGRectMake(iconView.tmri_right + 10, productionLable .tmri_bottom +20, 30, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
        BuyLable.text = @"购买:";
        [self addSubview:BuyLable];
        
        self.steper = [[PKYStepper alloc] initWithFrame:CGRectMake(BuyLable.tmri_right + 10, productionLable.tmri_bottom + 15, 150, 25)];
        [self.steper setLabelFont:[UIFont systemFontOfSize:13]];
        [self.steper setLabelColor:[UIColor blackColor]];
        self.steper.minimum = 1;
        [self addSubview:self.steper];
        
        UIImageView *picView = [[UIImageView alloc] initWithFrame:CGRectMake(self.steper.tmri_right +10, productionLable.tmri_bottom + 15, 25, 25)];
        picView.image = [UIImage imageNamed:@"discountSelIcon"];
        [self addSubview:picView];
        NSString *titleString;
        UIButton *button;
        CGFloat btnWidth = 45;
        CGFloat spaceWidth = 20;
        for (int i = 0; i < 4; i ++) {
            if (i == 0) {
                titleString = @"1份";
            }else if (i ==1){
                titleString = @"10份";
            }else if (i == 2){
                titleString = @"20份";
            }else if (i == 3){
                titleString = @"50份";
            }
            button = [UIButton buttonWithFrame:CGRectMake(self.steper.MinX + (btnWidth+spaceWidth) *i, self.steper.tmri_bottom + 10, btnWidth, 25) target:self action:@selector(btnClick:) title:titleString cornerRadius:5];
            button.layer.borderColor = [UIColor grayColor].CGColor;
            button.layer.borderWidth = 2;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            button .tag = 555+i;
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            button.backgroundColor = [UIColor whiteColor];
            [self addSubview:button];
        }
        for (UIButton *button in self.subviews) {
            if (button.tag == 556) {
                [self btnClick:button];
            }
        }
        UIButton *buyButton = [UIButton buttonWithFrame:CGRectMake(0, self.button.tmri_bottom +10, kWIDTH, 50) target:self action:@selector(orderClick:) title:@"提交订单" cornerRadius:2];
        buyButton.tag = 123;
        buyButton.backgroundColor =[UIColor redColor];
        [self addSubview:buyButton];
    }
    return self;
}
-(void)btnClick:(UIButton *)button
{
    self.button.selected = NO;
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    button.selected = YES;
    button.backgroundColor = [UIColor redColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    if (button.tag == 555) {
        self.steper.value = 1;

    }else if (button.tag == 556){
        self.steper.value = 10;

    }else if (button.tag == 557){
        self.steper.value = 20;

    }else if (button.tag == 558){
        self.steper.value = 50;

    }
    self.button = button;
    
}
-(void)orderClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(orderButtonClick)]) {
        [self.delegate orderButtonClick];
    }
}
-(void)delectClick
{
    [UIView animateWithDuration:1.0 animations:^{
        CGRect frme = self.frame;
        frme.origin.y = kHEIGHT;
        self.frame = frme;
    } completion:nil];
}
@end
