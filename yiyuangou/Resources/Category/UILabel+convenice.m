//
//  UILabel+convenice.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/11.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "UILabel+convenice.h"

@implementation UILabel (convenice)
-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic
{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    
    NSRange range = [str rangeOfString:subStr];
    NSString *str1 = [str substringToIndex:range.location];
    NSString *str2 = subStr;
    NSString *str3 = [str substringFromIndex:range.location + range.length];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str1 attributes: commonDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2] attributes: handleDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str3 attributes: commonDic]];
    return attStr;
}
- (BOOL)isAllNum
{
    unichar c;
    NSString *string = [self.text trim];
    for (int i=0; i<string.length; i++) {
        c=[string characterAtIndex:i];
        if (!isdigit(c)) {
            return NO;
        }
    }
    return YES;
}
@end
