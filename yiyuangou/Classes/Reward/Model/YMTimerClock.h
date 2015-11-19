//
//  YMTimerClock.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YMTimerClock : UIView
@property(nonatomic,assign) float w1;//宽度1
@property(nonatomic,assign) float w2;//宽度2
@property(nonatomic,assign) float bgWidth;//背景图片宽度
@property(nonatomic,assign) float bgHeight;//背景图片高度

@property(nonatomic,strong) UILabel *HourFisrtLetter;//fen
@property(nonatomic,strong) UILabel *HourSecondLetter;

@property(nonatomic,strong) UILabel *MinuFisrtLetter;//秒
@property(nonatomic,strong) UILabel *MinuSecondLetter;

@property(nonatomic,strong) UILabel *SecFisrtLetter;//毫秒
@property(nonatomic,strong) UILabel *secSecondLetter;
@property(nonatomic,assign) float   font;//字体大小

@property (strong, nonatomic) NSString *valueString;
@property (strong, nonatomic) NSTimer *clockTimer;//计时器
@property (nonatomic, assign) unsigned long value;
@property (nonatomic, assign) unsigned long resetValue;
@property (nonatomic, assign) double startTime;
@property (nonatomic, assign) BOOL running;
@property (nonatomic, assign) BOOL isRunning;
@property (nonatomic, assign) unsigned long startValue;
//启动定时器
- (void)start;
//关闭定时器
-(void) stop;
@end
