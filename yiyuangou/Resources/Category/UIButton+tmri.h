//
//  UIButton+tmri.h
//  tmri
//
//  Created by Ch on 14/11/12.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (tmri)

+ (UIButton*)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString*)title cornerRadius:(CGFloat)cornerRadius;//便利构造

@end
