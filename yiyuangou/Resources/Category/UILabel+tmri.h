//
//  UILabel+tmri.h
//  tmri
//
//  Created by Ch on 14/11/13.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (tmri)

+ (UILabel*)labelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor*)textColor;;

//让文本置顶
- (void)alignTop;
//让文本在底部
- (void)alignBottom;
@end
