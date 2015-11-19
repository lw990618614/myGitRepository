//
//  UIView+Extension.m
//  Weibo
//
//  Created by Vincent_Guo on 15-3-16.
//  Copyright (c) 2015年 Fung. All rights reserved.
//

#import "UIView+Extension.h"
#import "YMNoDataView.h"

@implementation UIView (Extension)

-(void)setSize:(CGSize)size{
    self.bounds = CGRectMake(0, 0, size.width, size.height);
}

-(CGSize)size{
    return self.bounds.size;
}

-(void)setW:(CGFloat)w{
    
    CGRect frm = self.frame;
    frm.size.width = w;
    self.frame = frm;
}

-(CGFloat)w{
    return self.size.width;
}


-(void)setH:(CGFloat)h{
    CGRect frm = self.frame;
    frm.size.height = h;
    self.frame = frm;
}

-(CGFloat)h{
    return self.size.height;
}

-(void)setX:(CGFloat)x{
    CGRect frm = self.frame;
    frm.origin.x = x;
    
    self.frame = frm;
}
-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frm = self.frame;
    frm.origin.y = y;
    
    self.frame = frm;
    
}

-(CGFloat)y{
    return self.frame.origin.y;
}
-(CGFloat)frameX
{
    return self.frame.origin.x + self.frame.size.width;
}
-(CGFloat)frameY
{
    return self.frame.origin.y + self.frame.size.height;
}
-(void)addTap
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(closeKeyBoard)];
    [self addGestureRecognizer:tap];
}
-(void)closeKeyBoard
{
    [self endEditing:YES];
}
-(void)showEmptyView
{
    YMNoDataView *nodata = [[YMNoDataView alloc] initWithFrame:self.bounds];
    nodata.backgroundColor = [UIColor clearColor];
    [self addSubview:nodata];
}
-(void)showEmptyView:(float)height
{
    YMNoDataView *nodata = [[YMNoDataView alloc] initWithFrame:CGRectMake(0, height, self.width, self.height - height)];
    [self addSubview:nodata];
}
-(void)hideEmptyView
{
    for (UIView *subView in [self subviews]) {
        if ([subView isKindOfClass:[YMNoDataView class]]) {
            [subView removeFromSuperview];
        }
    }
}
@end
