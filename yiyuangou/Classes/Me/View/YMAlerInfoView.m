//
//  YMAlerInfoView.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/5.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMAlerInfoView.h"

@implementation YMAlerInfoView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title buttonTitle:(NSString *)buttonTitle
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initView:title buttonTitle:buttonTitle ];
    }
    return self;
    
}
//v
-(void) initView:(NSString *)tittle buttonTitle:(NSString *)btnTitle
{
    UIView *containView = [[UIView alloc]init];
    containView.layer.borderWidth = 1.0;
    containView.layer.borderColor = [UIColor lightColor].CGColor;
    containView.layer.cornerRadius = 5.0;
    WEAKSELF;
    containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:containView];
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(300, 125));
    }];
    UILabel *title = [[UILabel alloc]init];
    title.text = tittle;
    title.font = [UIFont systemFontOfSize:18.0];
    title.textColor  = [UIColor colorWithHex:@"0x444444"];
    [containView addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(containView);
        make.top.equalTo(@25);
    }];
    UIButton *btn = [[UIButton alloc]init];
    btn.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor  colorWithHex:@"#DD2727"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(didAction:) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 25));
        make.centerX.equalTo(containView);
        make.top.equalTo(title.mas_bottom).offset(30);
    }];
}
-(void) didAction:(id) sender
{
    if (self.deleagte && [self.deleagte respondsToSelector:@selector(clickBtnAction:)]) {
        [self.deleagte clickBtnAction:sender];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
