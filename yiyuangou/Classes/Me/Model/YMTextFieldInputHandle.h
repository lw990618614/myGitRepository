//
//  YMTextFieldInputHandle.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#define KMAXLength 12

@interface YMTextFieldInputHandle : NSObject
+(BOOL) isInputText:(UITextField *) txtField range:(NSRange )range replaceStr:(NSString *)tr maxLegnth:(NSUInteger) maxLenght;
@end
