//
//  YMProgressView.h
//  yiyuangou
//
//  Created by roen on 15/11/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMProgressView : UIView
@property (copy, nonatomic) NSString * progress;
@property (strong, nonatomic) UILabel *expectLable;
@property (strong, nonatomic) UILabel *actuallyLalbe;
@property (strong, nonatomic) UILabel * ProgressNumber;;
@property (strong,nonatomic)UIProgressView *progressView;
@end
