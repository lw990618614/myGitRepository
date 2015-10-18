//
//  YMCustomSegmentView.m
//  yiyuangou
//
//  Created by roen on 15/10/14.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMCustomSegmentView.h"
#import "UIColor+tmri.h"
#import "UIView+tmri.h"

@interface YMCustomSegmentView(){
    
@private
    NSMutableArray * _btns;
}

@property (nonatomic, strong) UIView *identifierView;

@end

@implementation YMCustomSegmentView

- (UIView *)identifierView
{
    if (!_identifierView) {
        
        _identifierView=[[UIView alloc]initWithFrame:CGRectZero];
        _identifierView.backgroundColor = [UIColor tmriBlueColor];
        [self addSubview:_identifierView];
    }
    return _identifierView;
}

- (void)setTitles:(NSArray *)titles
{
    _titles = titles;
    
    [self configureButtons];
}

- (void)configureButtons
{
    self.backgroundColor = [UIColor whiteColor];
    
    for (UIView * subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    if (_btns) {
        [_btns removeAllObjects];
    }else{
        _btns = [NSMutableArray array];
    }
    
    CGFloat btnWidth = self.frame.size.width/([self.titles count]*1.0f);
    CGFloat btnHeight = self.frame.size.height;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, btnHeight-1, self.frame.size.width, 0.5)];
    lineView.backgroundColor=[UIColor lineColor];
    [self addSubview:lineView];
    
    self.identifierView.frame = CGRectMake(0, btnHeight-2, btnWidth, 2);
    
    int i = 0;
    for (NSString *title in self.titles) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:CGRectMake(i*btnWidth, 0, btnWidth-1, btnHeight)];
        [btn setTitle:title forState:UIControlStateNormal];
        if(i==0){
            btn.selected = YES;
        }
        [btn setTitleColor:[UIColor tmriGrayColor] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor tmriBlueColor] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor midBlackColor] forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        btn.tag = 12340 + i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        [_btns addObject:btn];
        
        if (i < [self.titles count]-1) {
            UIView * separationLineView = [[UIView alloc]initWithFrame:CGRectMake(btn.tmri_right+1, 10, 1, btn.tmri_height-20)];
            separationLineView.backgroundColor = [UIColor lineColor];
            [self addSubview:separationLineView];
        }
        
        i++;
    }
}

- (void)btnClick:(UIButton *)btn
{
    for (UIButton * button in _btns) {
        [button setSelected:NO];
    }
    
    [btn setSelected:YES];
    
    NSInteger index = btn.tag - 12340;
    self.identifierView.MinX = index * btn.frame.size.width;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentView:selectedAtIndex:)]) {
        [self.delegate segmentView:self selectedAtIndex:index];
    }
}
@end
