//
//  YMBankViewCell.m
//  yiyuangou
//
//  Created by roen on 15/10/3.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBankViewCell.h"
#import "UIView+tmri.h"
#import "PKYStepper.h"
@interface YMBankViewCell()
{
    UIButton *phoneBurron;
    PKYStepper *timeView;
}
@end
@implementation YMBankViewCell
-(instancetype)initWithFrame:(CGRect)frame withView:(UIView *)view andTitle:(NSString *)tilte andType:(YMBankViewCellType)type;
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 80,  80)];
        UILabel *tilteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.tmri_bottom+5, frame.size.width, 20)];
        [self addSubview:imageView];
        [self addSubview:tilteLabel];
        
        switch (type) {
            case YMBankViewCellPhoneNumber:
                phoneBurron = [[UIButton alloc]initWithFrame:CGRectMake(0, imageView.tmri_bottom, frame.size.width, 40)];
                [self addSubview:phoneBurron];
                break;
            case YMBankViewCellTimeNumber:
                timeView = [[PKYStepper alloc] initWithFrame:CGRectMake(20, imageView.tmri_bottom, imageView.size.width, 20)];
                [self addSubview:timeView];
                break;
            default:
                break;
        }
    }
    return self;
}

@end
