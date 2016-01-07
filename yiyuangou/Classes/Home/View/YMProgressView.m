//
//  YMProgressView.m
//  yiyuangou
//
//  Created by roen on 15/11/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMProgressView.h"

@implementation YMProgressView
-(instancetype)initWithFrame:(CGRect)frame
{
   self =  [super initWithFrame:frame];
    if (self) {
        UILabel  *Progresslable = [UILabel labelWithFrame:CGRectMake(0, 0, frame.size.width*0.6, frame.size.height*0.5) textAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithHex:@"#999999"]];
        Progresslable.text = @"开奖进度";
//        [self addSubview:Progresslable];
        
        UILabel *ProgressNumber= [UILabel labelWithFrame:CGRectMake(0, 0, frame.size.width, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#999999"]];
        self.ProgressNumber = ProgressNumber;
        [self addSubview:ProgressNumber];
        
        UIProgressView * progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0,ProgressNumber.tmri_bottom , frame.size.width, 3)];
        self.progressView = progressView;
        self.progressView.tintColor = [UIColor  colorWithHex:@"#DD2727"];
        [self addSubview:progressView];
        
        
        self.actuallyLalbe= [UILabel labelWithFrame:CGRectMake(0, self.progressView.tmri_bottom, frame.size.width, 20) textAlignment:NSTextAlignmentLeft textColor:[UIColor  colorWithHex:@"#DD2727"]];
        [self addSubview:self.actuallyLalbe];

    }
    return self;
}
@end
