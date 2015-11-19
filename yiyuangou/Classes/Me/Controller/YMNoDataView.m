//
//  YMNoDataView.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMNoDataView.h"

@interface YMNoDataView ()
@property(nonatomic,strong)UIImage *iconImage;
@property(nonatomic,strong)NSString *title;
@end
@implementation YMNoDataView
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *)image
{
    self =  [super initWithFrame:frame];
    if (self) {
        _iconImage = image;
        _title = title;
        [self initWithSubView];
    }
    return self;
}
-(instancetype) initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        _iconImage = [UIImage imageNamed:@"noData"];
        _title = @"暂无记录";
        [self initWithSubView];
    }
    return self;
}
-(void) initWithSubView
{
    self.backgroundColor = [UIColor colorWithRed:230 green:240 blue:241 alpha:1];
    UIImageView *img = [[UIImageView alloc]init];
    img.backgroundColor = [UIColor clearColor];
    
    img.image = _iconImage;
    img.layer.cornerRadius = img.width/2.0;
    img.clipsToBounds = YES;
    [img.layer setMasksToBounds:YES];
    [self circle:img];
    [img setContentMode:UIViewContentModeScaleAspectFill];
    [self addSubview:img];
    WEAKSELF;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(135);
        make.centerX.equalTo(weakSelf);
        make.size.mas_equalTo(CGSizeMake(110, 100));
       
    }];

    UILabel *lbl = [[UILabel alloc]init];
    lbl.text = _title;
    lbl.textColor = [UIColor lightColor];
    lbl.font = [UIFont systemFontOfSize:20.0];
    [self addSubview:lbl];
    [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(img.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf);
    }];
}
-(void) circle:(UIImageView *)headImgView
{
    [headImgView.layer setCornerRadius:(headImgView.frame.size.height/2)];
    [headImgView.layer setMasksToBounds:YES];
    [headImgView setContentMode:UIViewContentModeScaleAspectFill];
    [headImgView setClipsToBounds:YES];
    headImgView.layer.shadowColor = [UIColor blackColor].CGColor;
    headImgView.layer.shadowOffset = CGSizeMake(4, 4);
    headImgView.layer.shadowOpacity = 0.5;
    headImgView.layer.shadowRadius = 2.0;
    headImgView.layer.borderColor = [[UIColor clearColor] CGColor];
    headImgView.layer.borderWidth = 2.0f;
    headImgView.userInteractionEnabled = YES;
    headImgView.backgroundColor = [UIColor clearColor];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
