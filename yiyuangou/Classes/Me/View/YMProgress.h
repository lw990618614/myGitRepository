//
//  YMProgress.h
//  yiyuangou
//
//  Created by Aaron on 15/11/26.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  领奖进度条
 */
@interface YMProgress : UIView
-(instancetype)initWithFrame:(CGRect)frame selectedColor:(UIColor *) selectedColor unSelectedColor:(UIColor *)unSelectedColor;

//当前的进度
-(void) setProgress:(int) index;
@end
