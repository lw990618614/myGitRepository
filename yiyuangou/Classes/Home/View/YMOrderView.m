//
//  YMOrderView.m
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMOrderView.h"
@interface YMOrderView()<UIGestureRecognizerDelegate,UITextFieldDelegate>
@property (nonatomic,strong)UIButton *button;
@end
@implementation YMOrderView
-(instancetype)initWithFrame:(CGRect)frame withModel:(NSInteger )data
{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //图片
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 80)];
        self.iconView = iconView;
        self.iconView.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
        self.iconView.layer.borderWidth = 1;
        self.iconView.contentMode =  UIViewContentModeScaleAspectFill;
        [self.iconView setClipsToBounds:YES];
        [self addSubview:iconView];
        
        
        //商品名称
        UILabel *productionLable = [UILabel labelWithFrame:CGRectMake(iconView.tmri_right + 10, 20, kWIDTH * 0.7, 40) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        productionLable.text =@"这是一个新的产品";
        productionLable.numberOfLines = 2;
        productionLable.font  = [UIFont systemFontOfSize:16];
        self.productionLable = productionLable;
        [self addSubview:productionLable];
        
        //总需求
        self.allLable = [UILabel labelWithFrame:CGRectMake(iconView.tmri_right + 10, self.productionLable.tmri_bottom, 300, 30) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#444444"]];
        self.allLable.font = [UIFont systemFontOfSize:14];
        self.allLable.text =@"总需求100";
        [self addSubview:self.allLable];
        
        
        //删除
        UIImageView *deleteView = [[UIImageView alloc] initWithFrame:CGRectMake(kWIDTH - 30, 15, 20, 20)];
        deleteView.image = [UIImage imageNamed:@"delete"];
        UIButton *deleteButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 50, 50) target:self action:@selector(delectClick) title:nil cornerRadius:1];
        deleteButton.center = deleteView.center;
        [self addSubview:deleteButton];
//        productionLable.tmri_width = deleteView.MinX -productionLable.tmri_right ;
        [self addSubview:deleteView];
        
        productionLable.frame = CGRectMake(self.iconView.tmri_right +10, 20, kWIDTH - self.iconView.tmri_right -10-deleteView.width-10, 40);

        //分割线
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.iconView.tmri_bottom +15, kWIDTH-20, 1)];
        lineView1.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        [self addSubview:lineView1];

        /********** 购买分数**********/
        UILabel * buyLable = [UILabel labelWithFrame:CGRectMake(10, lineView1.tmri_bottom + 15, 200, 15) textAlignment:NSTextAlignmentLeft textColor:nil];
        buyLable.text = @"购买:";
        self.buyLable = buyLable;
        self.buyLable.font  = [UIFont systemFontOfSize: 14];
        [self addSubview:buyLable];
        
        //加减选择
        self.steper = [[PKYStepper alloc] initWithFrame:CGRectMake(10, buyLable.tmri_bottom + 15, 150, 25)];
        [self.steper setLabelFont:[UIFont systemFontOfSize:14]];
        self.steper.countLabel.delegate = self;
        self.steper.minimum = 1;

        [self addSubview:self.steper];
        [self.steper setup];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, self.steper.tmri_bottom +15, kWIDTH-20, 1)];
        lineView2.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        [self addSubview:lineView2];
        
        NSString *titleString;
        UIButton *button;
        CGFloat btnWidth = 50;
        CGFloat spaceWidth = 10;
        
        NSInteger buttonCount;
        if (data >=50) {
            buttonCount = 4;
        }else if (20<=data&&50>data)
        {
            buttonCount = 3;
        }else if (10<=data&&data<20)
        {
            buttonCount = 2;
        }else{
            buttonCount = 1;
        }
        NSLog(@"%ld",buttonCount);
        //按钮的个数
        self.number = buttonCount;
        for (int i = 0; i < buttonCount +1; i ++) {
            if (i == buttonCount) {
                titleString = @"包尾";
            }else{
                if (i == 0) {
                    titleString = @"1份";
                }else if (i ==1){
                    titleString = @"10份";
                }else if (i == 2){
                    titleString = @"20份";
                }else if (i == 3){
                    titleString = @"50份";
                }
            }
            button = [UIButton buttonWithFrame:CGRectMake(10 + (btnWidth+spaceWidth) *i, lineView2.tmri_bottom + 15, btnWidth, 30) target:self action:@selector(btnClick:) title:titleString cornerRadius:1];
            button.layer.borderColor = [UIColor colorWithHex:@"#EAEAEA"].CGColor;
            button.layer.borderWidth = 1;
            
            [button setTitleColor:[UIColor colorWithHex:@"#444444"] forState:UIControlStateNormal];
            
            button .tag = 555+i;
            [self addSubview:button];
        }
        for (UIButton *button in self.subviews) {
            if (data >= 10) {
                if (button.tag == 556) {
                    [self btnClick:button];
                }
            }else{
                if (button.tag == 555) {
                    [self btnClick:button];
                }
            }
        }

        UIButton *buyButton = [UIButton buttonWithFrame:CGRectMake(0, self.button.tmri_bottom +30, kWIDTH, 50) target:self action:@selector(orderClick) title:@"提交订单" cornerRadius:2];
        buyButton.titleLabel.font  = [UIFont systemFontOfSize:14];
        buyButton.backgroundColor =[UIColor  colorWithHex:@"#DD2727"];

        [self addSubview:buyButton];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 1)];
        lineView.backgroundColor = [UIColor colorWithHex:@"#EAEAEA"];
        [self addSubview:lineView];
    }
    return self;
}
-(void)btnClick:(UIButton *)button
{
    SAFE;
    self.steper.button = button;
    self.steper.valueChangedCallback = ^(PKYStepper *stepper, float count) {
        weakSelf.steper.countLabel.text = [NSString stringWithFormat:@"%@", @(count)];
        NSString *allsting = [NSString stringWithFormat:@"购买数量%@份",weakSelf.steper.countLabel.text];
        NSString *subString = weakSelf.steper.countLabel.text;
        weakSelf.buyLable.attributedText = [allsting alllString:allsting andallcolor:[UIColor colorWithHex:@"#444444"] andallFont:[UIFont systemFontOfSize:14] subString:subString andColor:[UIColor colorWithHex:@"#DD2727"] andsubFont:[UIFont systemFontOfSize:14]];
//        weakSelf.buyLable.text = weakSelf.steper.countLabel.text;
        if (weakSelf.steper.button.tag == weakSelf.number +555) {
            weakSelf.orderResult.isAll = NO;
        }
        weakSelf.orderResult.buyCount = [weakSelf.steper.countLabel.text intValue];
    };
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button setTitleColor:[UIColor colorWithHex:@"#444444"] forState:UIControlStateNormal];
    
    button.backgroundColor = [UIColor  colorWithHex:@"#DD2727"];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.orderResult.isAll = NO;
    if (button.tag == self.number+555) {
        self.orderResult.isAll = YES;
        self.steper.value = self.orderResult.left;
    }else{
        if (button.tag == 555) {
            self.steper.value = 1;
        }else if (button.tag == 556){
            self.steper.value = 10;
        }else if (button.tag == 557){
            self.steper.value = 20;
        }else if (button.tag == 558){
            self.steper.value = 50;
        }

    }
    
    self.steper.countLabel.text =[NSString stringWithFormat:@"%ld",(long)self.steper.value];
    self.orderResult.productionAcount = self.steper.value;
    self.button = button;
    
}
-(void)orderClick
{
    if ([self.delegate respondsToSelector:@selector(orderButtonClickWith:)]) {
        [self.delegate orderButtonClickWith:self.orderResult];
    }
    
}
-(void)delectClick
{
    [UIView animateWithDuration:0.25f animations:^{
        CGRect frme = self.frame;
        frme.origin.y = kHEIGHT;
        self.frame = frme;
    } completion:nil];
    if ([self.delegate respondsToSelector:@selector(cancelButtonClick)]) {
        [self.delegate cancelButtonClick];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.button.backgroundColor = [UIColor whiteColor];
    [self.button setTitleColor:[UIColor colorWithHex:@"#444444"] forState:UIControlStateNormal];

    if (self.orderResult.left<[self.steper.countLabel.text intValue]) {
        
        self.steper.countLabel.text = [NSString stringWithFormat:@"%ld",self.orderResult.left];
        self.steper.value =self.orderResult.left;
    }
    self.orderResult.buyCount = [textField.text integerValue];
    if ([self.steper.countLabel.text intValue] < 1) {
        NSInteger textAmount = self.orderResult.left>0?1:0;
        self.steper.value  =textAmount;
        self.steper.countLabel.text = [NSString stringWithFormat:@"%ld",(long)textAmount];
        self.orderResult.buyCount = [textField.text integerValue];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    if ([textField.text integerValue]<= self.orderResult.left) {
        return YES;
    }
    return NO;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.steper.value = [textField.text integerValue];

    return YES;
}
@end
