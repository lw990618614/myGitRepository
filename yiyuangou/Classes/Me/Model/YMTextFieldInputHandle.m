//
//  YMTextFieldInputHandle.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTextFieldInputHandle.h"

@implementation YMTextFieldInputHandle
+(BOOL)isInputText:(UITextField *)txtField range:(NSRange )range replaceStr:(NSString *)tr maxLegnth:(NSUInteger)maxLenght
{
    NSMutableString *newtxt = [NSMutableString stringWithString:txtField.text];
    [newtxt replaceCharactersInRange:range withString:tr];
    BOOL change = YES;
    if ([newtxt length] >= maxLenght) {
        change = NO;
    }
    //如果是删除的情况 则允许删除
    if (range.length == 1) {
        change = YES;
    }
    return change;

}
@end
