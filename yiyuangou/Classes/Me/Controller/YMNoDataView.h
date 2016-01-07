//
//  YMNoDataView.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMNoDataView : UIView

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *) image btnTitle:(NSString *)btnTitle action:(SEL) action tagert:(id)  tagrt;

-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title image:(UIImage *) image;

-(instancetype) initWithFrame:(CGRect)frame;
@end
