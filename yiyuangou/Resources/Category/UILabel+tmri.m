//
//  UILabel+tmri.m
//  tmri
//
//  Created by Ch on 14/11/13.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import "UILabel+tmri.h"

@implementation UILabel (tmri)

+ (UILabel*)labelWithFrame:(CGRect)frame textAlignment:(NSTextAlignment)textAlignment textColor:(UIColor*)textColor;
{
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=textAlignment;
    label.textColor=textColor;
    label.font = [UIFont systemFontOfSize:12];
    return label;
}
- (void)alignTop {
    self.lineBreakMode = NSLineBreakByCharWrapping;
    for(int i=0; i<10; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom {
    self.lineBreakMode = NSLineBreakByClipping;
    CGSize fontSize = [self.text sizeWithFont:self.font];
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}
@end
