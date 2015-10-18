//
//  UIButton+tmri.m
//  tmri
//
//  Created by Ch on 14/11/12.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import "UIButton+tmri.h"

@implementation UIButton (tmri)

+ (UIButton*)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString*)title cornerRadius:(CGFloat)cornerRadius
{
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.layer.cornerRadius=cornerRadius;
    return button;
}

@end
