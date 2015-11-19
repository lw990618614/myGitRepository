//
//  UIColor+tmri.h
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (tmri)

+ (UIColor *)randomColor:(NSString *)number;

+ (UIColor*)lineColor;

+ (UIColor *)darkBlackColor;
+ (UIColor *)midBlackColor;
+ (UIColor *)tmriGrayColor;
+ (UIColor *)tmriBlueColor;
+ (UIColor *)tmriGreenColor;
+ (UIColor *)tmriRedColor;
+ (UIColor *)yzmGrayColor;
+ (UIColor *)dhColor;
+ (UIColor *)colorWithHex:(NSString *)hex;
+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
+(UIColor *)PwdGrayColor;
+(UIColor *)PwdQiangColor;
+(UIColor *)PwdZhongColor;
+(UIColor *)PwdRuoColor;
+(UIColor *)myMessageColor;

//group Table的灰色
+(UIColor *)tmriLightGrayColor;
//浅灰色
+(UIColor *) lightColor;
//黑色
+(UIColor *) heightBlacKColor;

@end
