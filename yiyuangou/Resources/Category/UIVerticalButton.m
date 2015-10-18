//
//  UIVerticalButton.m
//  main
//
//  Created by Ch on 14/11/18.
//  Copyright (c) 2014年 ChinaTelecom. All rights reserved.
//

#import "UIVerticalButton.h"

@implementation UIVerticalButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat imageViewY=(self.frame.size.height-self.imageView.size.height-self.titleLabel.size.height-5)/2.0;
    
    // Center image
    CGPoint center = self.imageView.center;
    center.x = self.frame.size.width/2.0;
    center.y = imageViewY+self.imageView.size.height/2.0;
    self.imageView.center = center;
    
    //Center text
    CGRect newFrame = [self titleLabel].frame;
    newFrame.origin.x = 0;
    newFrame.origin.y = self.imageView.frame.size.height + imageViewY+5;
    newFrame.size.width = self.frame.size.width;
    
    self.titleLabel.frame = newFrame;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


+ (UIVerticalButton*)buttonWithFrame:(CGRect)frame target:(id)target action:(SEL)action title:(NSString*)title cornerRadius:(CGFloat)cornerRadius
{
    UIVerticalButton *button=[UIVerticalButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitle:title forState:UIControlStateNormal];
    if (target&&action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    button.layer.cornerRadius=cornerRadius;
    return button;
}


@end
