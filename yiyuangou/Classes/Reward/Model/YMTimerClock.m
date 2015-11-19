//
//  YMTimerClock.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/9.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMTimerClock.h"

@interface YMTimerClock()

@end
@implementation YMTimerClock
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _w1 =  2;
        _w2 = 10;
        _bgWidth  = 20;
        _bgHeight =  25;
        _font =  20;
        [self initWithClock];
    }
    return self;
}
-(void) initWithClock
{
    
    float width = _bgWidth - 1*2;
    float height = _bgHeight - 2*2;
    UIImage *timeImage = [UIImage imageNamed:@"time"];
    CGRect rect = CGRectMake(5, 5, _bgWidth, _bgHeight);
    UIImageView *image1 = [[UIImageView alloc] initWithFrame:rect];
    image1.image = timeImage;
    _HourFisrtLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
    _HourFisrtLetter.text = @"0";
    _HourFisrtLetter.font = [UIFont systemFontOfSize:_font];
    _HourFisrtLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _HourFisrtLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image1];
    [self addSubview:_HourFisrtLetter];
    _HourFisrtLetter.center = image1.center;

    rect =  CGRectMake(image1.tmri_right + _w1, 5, _bgWidth, _bgHeight);
    UIImageView *image2 = [[UIImageView alloc] initWithFrame:rect];
    image2.image = timeImage;
    _HourSecondLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
//    _HourSecondLetter.text = @"0";
    _HourSecondLetter.font = [UIFont systemFontOfSize:_font];
    _HourSecondLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _HourSecondLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image2];
    [self addSubview:_HourSecondLetter];
    _HourSecondLetter.center = image2.center;
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(image2.tmri_right, 5, _w2, _bgHeight)];
    lbl1.text = @":";
    lbl1.font = [UIFont systemFontOfSize:_font];
    lbl1.textColor = [UIColor  colorWithHex:@"#DD2727"];
    lbl1.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbl1];
    
    rect =  CGRectMake(image2.tmri_right + _w2, 5, _bgWidth, _bgHeight);
    UIImageView *image3 = [[UIImageView alloc] initWithFrame:rect];
    image3.image = timeImage;
    _MinuFisrtLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
//    _MinuFisrtLetter.text = @"0";
    _MinuFisrtLetter.font = [UIFont systemFontOfSize:_font];
    _MinuFisrtLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _MinuFisrtLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image3];
    [self addSubview:_MinuFisrtLetter];
    _MinuFisrtLetter.center = image3.center;
    
    rect =  CGRectMake(image3.tmri_right + _w1, 5, _bgWidth, _bgHeight);
    UIImageView *image4 = [[UIImageView alloc] initWithFrame:rect];
    image4.image = timeImage;
    _MinuSecondLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
    _MinuSecondLetter.text = @"0";
    _MinuSecondLetter.font = [UIFont systemFontOfSize:_font];
    _MinuSecondLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _MinuSecondLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image4];
    [self addSubview:_MinuSecondLetter];
    _MinuSecondLetter.center = image4.center;
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(image4.tmri_right, 5, _w2, _bgHeight)];
    lbl2.text = @":";
    lbl2.font = [UIFont systemFontOfSize:_font];
    lbl2.textColor = [UIColor redColor];
    lbl2.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lbl2];
    rect =  CGRectMake(image4.tmri_right + _w2, 5, _bgWidth, _bgHeight);
    UIImageView *image5 = [[UIImageView alloc] initWithFrame:rect];
    image5.image = timeImage;
    _SecFisrtLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
//    _SecFisrtLetter.text = @"0";
    _SecFisrtLetter.font = [UIFont systemFontOfSize:_font];
    _SecFisrtLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _SecFisrtLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image5];
    [self addSubview:_SecFisrtLetter];
    _SecFisrtLetter.center  = image5.center;
    rect =  CGRectMake(image5.tmri_right + _w1, 5, _bgWidth, _bgHeight);
    UIImageView *image6 = [[UIImageView alloc] initWithFrame:rect];
    image6.image = timeImage;
    _secSecondLetter = [[UILabel alloc] initWithFrame:CGRectMake(1, 2, width, height)];
//    _secSecondLetter.text = @"0";
    _secSecondLetter.font = [UIFont systemFontOfSize:_font];
    _secSecondLetter.textColor = [UIColor  colorWithHex:@"#DD2727"];
    _secSecondLetter.textAlignment = NSTextAlignmentCenter;
    [self addSubview:image6];

    [self addSubview:_secSecondLetter];
    _secSecondLetter.center = image6.center;
    
}
#pragma mark - Public
- (void)setStartValue:(unsigned long)startValue
{
    int msperhour = 3600000;
    int mspermin = 60000;
    
    int hrs = startValue*1.0 / msperhour;
    int mins = (startValue % msperhour) / mspermin;
    int secs = ((startValue % msperhour) % mspermin) / 1000;
    int frac = startValue % 1000 / 10;
    
    NSString *formattedString = @"";
    NSString *hour1 = [NSString stringWithFormat:@"%d",mins/10];
    NSString *hour2 = [NSString stringWithFormat:@"%d",mins%10];
    NSString *minu1 = [NSString stringWithFormat:@"%d",secs/10];
    NSString *minu2 = [NSString stringWithFormat:@"%d",secs%10];
    NSString *sec1 = [NSString stringWithFormat:@"%d",frac/10];
    NSString *sec2 = [NSString stringWithFormat:@"%d",frac%10];
    
    _HourFisrtLetter.text = hour1;
    _HourSecondLetter.text = hour2;
    _MinuFisrtLetter.text = minu1;
    _MinuSecondLetter.text =  minu2;
    _SecFisrtLetter.text = sec1;
    _secSecondLetter.text = sec2;

}
- (void)start {
    
    if (self.running) return;
    
    self.startTime = CFAbsoluteTimeGetCurrent();
    
    self.running = YES;
    self.isRunning = self.running;
    
    self.clockTimer = [NSTimer timerWithTimeInterval:0.5
                                              target:self
                                            selector:@selector(clockDidTick:)
                                            userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.clockTimer forMode:NSRunLoopCommonModes];
}

- (void)stop {
    if (self.clockTimer) {
        [self.clockTimer invalidate];
        self.clockTimer = nil;
        
        _startValue = self.value;
    }
    
    self.running = NO;
    self.isRunning = self.running;
}
- (void)clockDidTick:(NSTimer *)timer {
    
    double currentTime = CFAbsoluteTimeGetCurrent();
    
    double elapsedTime = currentTime - self.startTime;
    
    // Convert the double to milliseconds
    unsigned long milliSecs = (unsigned long)(elapsedTime * 1000);
    self.value = (_startValue - milliSecs);
    [self timeFormattedStringForValue:self.value];
}
- (NSString *)timeFormattedStringForValue:(unsigned long)value {
    int msperhour = 3600000;
    int mspermin = 60000;
    
    int hrs = value*1.0 / msperhour;
    int mins = (value % msperhour) / mspermin;
    int secs = ((value % msperhour) % mspermin) / 1000;
    int frac = value % 1000 / 10;
    
    NSString *formattedString = @"";
    NSString *hour1 = [NSString stringWithFormat:@"%d",mins/10];
    NSString *hour2 = [NSString stringWithFormat:@"%d",mins%10];
    NSString *minu1 = [NSString stringWithFormat:@"%d",secs/10];
    NSString *minu2 = [NSString stringWithFormat:@"%d",secs%10];
    NSString *sec1 = [NSString stringWithFormat:@"%d",frac/10];
    NSString *sec2 = [NSString stringWithFormat:@"%d",frac%10];
    
    _HourFisrtLetter.text = hour1;
    _HourFisrtLetter.text = hour2;
    _MinuFisrtLetter.text = minu1;
    _MinuSecondLetter.text =  minu2;
    _SecFisrtLetter.text = sec1;
    _secSecondLetter.text = sec2;
//    NSLog(@"%@ %@ %@ %@ ",hour1,_HourFisrtLetter.text,minu1,_MinuSecondLetter.text);
//
//    formattedString = [NSString stringWithFormat:@" %02d:%02d:%02d", mins, secs, frac];

    return formattedString;
}

@end
