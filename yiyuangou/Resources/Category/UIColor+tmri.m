//
//  UIColor+tmri.m
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import "UIColor+tmri.h"

@implementation UIColor (tmri)

+ (UIColor *)randomColor:(NSString *)number
{
//    CGFloat hue = ( arc4random() % 256 / 256.0 );               //  0.0 to 1.0
//    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
//    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
//    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

    switch ([number intValue]) {
        case 1:
            return [UIColor colorWithHex:@"2f87d2"];
            break;
        case 2:
            return [UIColor colorWithHex:@"20a193"];
            break;
        case 3:
            return [UIColor colorWithHex:@"f28923"];
            break;
        default:
            break;
    }
    return [UIColor colorWithHex:@"f28923"];

}

+ (UIColor*)lineColor
{
    return [UIColor colorWithHex:@"#cbcbcb"];
}

+ (UIColor *)darkBlackColor
{
    return [UIColor colorWithHex:@"#333333"];
}

+ (UIColor *)midBlackColor
{
    return [UIColor colorWithHex:@"#666666"];
}

+ (UIColor *)tmriGrayColor
{
    return [UIColor colorWithHex:@"#999999"];
}

//group Table的灰色
+(UIColor *)tmriLightGrayColor
{
    return [UIColor colorWithHex:@"#f4f4f4"];
}

+ (UIColor *)tmriBlueColor
{
    return [UIColor colorWithHex:@"#2c66a8"];
}
+ (UIColor *)dhColor
{
    return [UIColor colorWithHex:@"22ac38"];
}
+ (UIColor *)tmriGreenColor
{
    return [UIColor colorWithHex:@"#8eb32c"];
}

+ (UIColor *)tmriRedColor
{
    return [UIColor colorWithHex:@"#ef5350"];
}
+(UIColor *)yzmGrayColor{
    return [UIColor colorWithHex:@"d5d5d5"];
}
+(UIColor *)myMessageColor{
    return [UIColor colorWithHex:@"efefef"];
}

+ (UIColor *)colorWithHex:(NSString *)hex
{
    return [UIColor colorWithHex:hex alpha:1.0];
}



+ (UIColor *)colorWithHex:(NSString *)hex alpha:(CGFloat)alpha
{
    NSString *cleanString = [hex stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

//+ (UIColor *)colorFromHexRGB:(NSString *)inColorString{
//    
//    UIColor *result = nil;
//    unsigned int colorCode = 0;
//    unsigned char redByte, greenByte, blueByte;
//    
//    if (nil != inColorString)
//    {
//        NSScanner *scanner = [NSScanner scannerWithString:inColorString];
//        (void) [scanner scanHexInt:&colorCode]; // ignore error
//    }
//    redByte = (unsigned char) (colorCode >> 16);
//    greenByte = (unsigned char) (colorCode >> 8);
//    blueByte = (unsigned char) (colorCode); // masks off high bits
//    result = [UIColor
//              colorWithRed: (float)redByte / 0xff
//              green: (float)greenByte/ 0xff
//              blue: (float)blueByte / 0xff
//              alpha:1.0];
//    return result;
//}

+(UIColor *)PwdGrayColor{
    return [UIColor colorWithHex:@"c9c9c9"];
}
+(UIColor *)PwdQiangColor{
    return [UIColor colorWithHex:@"71C60E"];
}
+(UIColor *)PwdZhongColor{
    return [UIColor colorWithHex:@"FFB84D"];
}
+(UIColor *)PwdRuoColor{
    return [UIColor colorWithHex:@"FF8180"];
}
+(UIColor *)lightColor
{
    return [UIColor colorWithHex:@"999999"];
}
//#DD2727
+(UIColor *) redColor
{
    return [UIColor colorWithHex:@"DD2727"];
}
+(UIColor *)heightBlacKColor
{
    return [UIColor colorWithHex:@"444444"];

}

@end
