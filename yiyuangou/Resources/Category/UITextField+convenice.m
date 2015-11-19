//
//  UITextField+convenice.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "UITextField+convenice.h"

@implementation UITextField (convenice)

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
