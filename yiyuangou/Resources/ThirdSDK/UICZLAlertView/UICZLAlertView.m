//
//  UICZLAlertView.m
//  main
//
//  Created by Ch on 14/11/18.
//  Copyright (c) 2014年 ChinaTelecom. All rights reserved.
//

#import "UICZLAlertView.h"
#import "GTCommontHeader.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "UIProvinceKeyboard.h"

#define kAlertWidth 265.0f
#define kTitleYOffset 10.0f
#define kTitleHeight 44.0f
#define kContentOffset 30.0f
#define kBetweenLabelOffset 20.0f
#define kSingleButtonWidth 245.0f
#define kCoupleButtonWidth 107.0f
#define kButtonHeight 40.0f
#define kButtonBottomOffset 10.0f
#define kButtonOffset 1.0f

#define kCancleColor  [UIColor blackColor]
//#define kSureColor [UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1]
#define kSureColor [UIColor colorWithHex:@"f4f4f4"]


@interface UICZLAlertView()
@property (nonatomic,copy) UICZLAlertViewBlock alertBlock;
@end

@implementation UICZLAlertView

- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView block:(UICZLAlertViewBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(self = [super init]){
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds= YES;
        self.backgroundColor = [UIColor whiteColor];
       
        self.alertBlock = block;
        
        self.contentView = contentView;
        self.title = title;
        
        _alertTitleLabel = [[UILabel alloc] init];
        _alertTitleLabel.backgroundColor = [UIColor colorWithHex:@"#2c66a8"];
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _alertTitleLabel.textColor = [UIColor whiteColor];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitleLabel.text = self.title;
        [self addSubview:_alertTitleLabel];
        
        [self addSubview:_contentView];
        
        _buttons = [[NSMutableArray alloc]init];
        
        NSMutableArray *otherBtns = [[NSMutableArray alloc]init];
        if(otherButtonTitles)
        {
            [otherBtns addObject:otherButtonTitles];
            va_list list;
            va_start(list,otherButtonTitles);
            while(1)
            {
                NSString *eachButton = va_arg(list, id);
                if(!eachButton)
                {
                    break;
                }
                [otherBtns addObject:eachButton];
            }
            va_end(list);
        }
        
        _allBtnNum = 0;
        if(cancelButtonTitle){
            _allBtnNum +=1;
        }
        _allBtnNum += otherBtns.count;
        
        switch(_allBtnNum)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                _oneBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _oneBtn.tag = 0;
                [self addSubview:_oneBtn];
                break;
            }
            case 2:
            {
                _rightBtn = [UIButton creatOneBtn:cancelButtonTitle color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                               _rightBtn.tag = 0;
                _rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
               
                _leftBtn = [UIButton creatOneBtn:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _leftBtn.tag = 1;
                _leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                [self addSubview:_rightBtn];
               
                [self addSubview:_leftBtn];
        
                break;
            }
            default:
            {
                for(int i = 0; i < otherBtns.count; i++){
                    UIButton *btn = [UIButton creatOneBtn:[otherBtns objectAtIndex:i] color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                    btn.tag = i+1;
                    [self addSubview:btn];
                    [_buttons addObject:btn];
                }
                
                UIButton *cancleBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                cancleBtn.tag = 0;
                [_buttons addObject:cancleBtn];
                [self addSubview:cancleBtn];
                
                break;
            }
        }
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title contentTxt:(NSString *)contentTxt delegate:(id<CzlAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(self = [super init]){
        UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 265, 90)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 245, 80)];
        label.numberOfLines = 0;
        CGSize addressSize = [contentTxt sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(245, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
        label.text=contentTxt;
        label.font = [UIFont systemFontOfSize:14];
        label.tmri_height = addressSize.height;
        contentView.tmri_height = label.tmri_height + 20;
        [contentView addSubview:label];
        
        self.layer.cornerRadius = 6.0;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        _delegate = delegate;
        self.contentView = contentView;
        self.title = title;
        
        _alertTitleLabel = [[UILabel alloc] init];
        _alertTitleLabel.backgroundColor = [UIColor colorWithHex:@"#2c66a8"];
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _alertTitleLabel.textColor = [UIColor whiteColor];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitleLabel.text = self.title;
        [self addSubview:_alertTitleLabel];
        
        [self addSubview:_contentView];
        
        _buttons = [[NSMutableArray alloc]init];
        
        NSMutableArray *otherBtns = [[NSMutableArray alloc]init];
        if(otherButtonTitles)
        {
            [otherBtns addObject:otherButtonTitles];
            va_list list;
            va_start(list,otherButtonTitles);
            while(1)
            {
                NSString *eachButton = va_arg(list, id);
                if(!eachButton)
                {
                    break;
                }
                [otherBtns addObject:eachButton];
            }
            va_end(list);
        }
        
        _allBtnNum = 0;
        if(cancelButtonTitle){
            _allBtnNum +=1;
        }
        _allBtnNum += otherBtns.count;
        
        switch(_allBtnNum)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                _oneBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _oneBtn.tag = 0;
                [self addSubview:_oneBtn];
                break;
            }
            case 2:
            {
                _rightBtn = [UIButton creatOneBtn:cancelButtonTitle color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _rightBtn.tag = 0;
                UILabel *xlb=[[UILabel alloc]initWithFrame:CGRectMake(kAlertWidth/2-0.5,kTitleHeight+kButtonOffset+_contentView.tmri_height+5, 1, kButtonHeight+kButtonBottomOffset-10)];
                xlb.backgroundColor=[UIColor colorWithHex:@"e4e4e4"];
                _leftBtn = [UIButton creatOneBtn:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _leftBtn.tag = 1;
                [self addSubview:_rightBtn];
                [self addSubview:xlb];
                [self addSubview:_leftBtn];
                break;
            }
            default:
            {
                for(int i = 0; i < otherBtns.count; i++){
                    UIButton *btn = [UIButton creatOneBtn:[otherBtns objectAtIndex:i] color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                    btn.tag = i+1;
                    [self addSubview:btn];
                    [_buttons addObject:btn];
                }
                
                UIButton *cancleBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kCancleColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                cancleBtn.tag = 0;
                [_buttons addObject:cancleBtn];
                [self addSubview:cancleBtn];
                
                break;
            }
        }
        
    }
    return self;
}

- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView delegate:(id<CzlAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    if(self = [super init]){
        self.layer.cornerRadius = 6.0;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        _delegate = delegate;

        self.contentView = contentView;
        self.title = title;
        
        _alertTitleLabel = [[UILabel alloc] init];
        _alertTitleLabel.backgroundColor = [UIColor colorWithHex:@"#2c66a8"];
        _alertTitleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
        _alertTitleLabel.textColor = [UIColor whiteColor];
        _alertTitleLabel.textAlignment = NSTextAlignmentCenter;
        _alertTitleLabel.text = self.title;
        [self addSubview:_alertTitleLabel];
        
        [self addSubview:_contentView];
        
        _buttons = [[NSMutableArray alloc]init];
        
        NSMutableArray *otherBtns = [[NSMutableArray alloc]init];
        if(otherButtonTitles)
        {
            [otherBtns addObject:otherButtonTitles];
            va_list list;
            va_start(list,otherButtonTitles);
            while(1)
            {
                NSString *eachButton = va_arg(list, id);
                if(!eachButton)
                {
                    break;
                }
                [otherBtns addObject:eachButton];
            }
            va_end(list);
        }
        
        _allBtnNum = 0;
        if(cancelButtonTitle){
            _allBtnNum +=1;
        }
        _allBtnNum += otherBtns.count;
        
        switch(_allBtnNum)
        {
            case 0:
            {
                break;
            }
            case 1:
            {
                _oneBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _oneBtn.tag = 0;
                [self addSubview:_oneBtn];
                break;
            }
            case 2:
            {
                _rightBtn = [UIButton creatOneBtn:cancelButtonTitle color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
               [_rightBtn setTitleColor:[UIColor colorWithHex:@"333333"] forState:UIControlStateNormal];
                _rightBtn.tag = 0;
                UILabel *xlb=[[UILabel alloc]initWithFrame:CGRectMake(kAlertWidth/2-0.5,kTitleHeight+kButtonOffset+_contentView.tmri_height+5, 1, kButtonHeight+kButtonBottomOffset-10)];
                xlb.backgroundColor=[UIColor colorWithHex:@"e4e4e4"];
                _leftBtn = [UIButton creatOneBtn:otherButtonTitles color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                _leftBtn.tag = 1;
                [self addSubview:_rightBtn];
                [self addSubview:xlb];
                [self addSubview:_leftBtn];
                break;
            }
            default:
            {
                for(int i = 0; i < otherBtns.count; i++){
                    UIButton *btn = [UIButton creatOneBtn:[otherBtns objectAtIndex:i] color:kSureColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                    btn.tag = i+1;
                    [self addSubview:btn];
                    [_buttons addObject:btn];
                }
                
                UIButton *cancleBtn = [UIButton creatOneBtn:cancelButtonTitle?cancelButtonTitle:otherButtonTitles color:kCancleColor frame:CGRectZero action:@selector(buttonClick:) target:self];
                cancleBtn.tag = 0;
                [_buttons addObject:cancleBtn];
                [self addSubview:cancleBtn];
                
                break;
            }
        }
        
    }
    return self;
    
}

- (void)buttonClick:(id)sender
{
    BOOL hide = YES;
    UIButton *button = (UIButton *)sender;
    if (self.delegate&&[self.delegate respondsToSelector:@selector(czlAlertView:clickedButtonAtIndex:)]) {
       hide = [self.delegate czlAlertView:self clickedButtonAtIndex:button.tag];
    }
    
    if (self.alertBlock) {
        hide = self.alertBlock(button.tag);
    }
    
    if (hide) {
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
        [UIView animateWithDuration:.30f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self roate:orientation sacle:0.001];
        } completion:^(BOOL finished) {
            [self hideMySelf];
        }];
    }
    
}

- (void)roate:(UIInterfaceOrientation)orientation sacle:(float)num
{
    CGAffineTransform rotationTransform;
    
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        
        rotationTransform = CGAffineTransformMakeRotation(3*M_PI/2);
        
    }else if (orientation == UIInterfaceOrientationLandscapeRight) {
        
        rotationTransform = CGAffineTransformMakeRotation(M_PI/2);
        
    }else if (orientation == UIInterfaceOrientationPortrait) {
        
        rotationTransform = CGAffineTransformMakeRotation(0);
        
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        
        rotationTransform = CGAffineTransformMakeRotation(-M_PI);
        
    }
    
    CGAffineTransform scaleTransform = CGAffineTransformScale(CGAffineTransformIdentity,num,num);
    
    self.transform = CGAffineTransformConcat(scaleTransform,rotationTransform);
}

- (void)hideMySelf
{
    
    [self removeFromSuperview];
   
    [_backgroundView removeFromSuperview];
    [[_originalWindow subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
       _backgroundView.backgroundColor=[UIColor clearColor];
    _backgroundView.alpha=0;
    _backgroundView=nil;
    _originalWindow = nil;
    [_originalWindow makeKeyWindow];

    [[[[UIApplication sharedApplication] delegate] window] makeKeyWindow];
}

- (void)show
{
    CGRect rect = [UIScreen mainScreen].bounds;
    
    _originalWindow = [[UIWindow alloc] initWithFrame:rect];
    _originalWindow.windowLevel = UIWindowLevelAlert;
    _originalWindow.tag =100;
    
    _backgroundView  = [[UIView alloc] initWithFrame:rect];
    _backgroundView.alpha = 0.4;
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.center = _originalWindow.center;
    self.center = _originalWindow.center;
    
    [_originalWindow addSubview:_backgroundView];
    [_originalWindow addSubview:self];
    [_originalWindow becomeKeyWindow];
    [_originalWindow makeKeyAndVisible];
    
    [self defaultStyle];
}

- (void)defaultStyle
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication]statusBarOrientation];
    
    [UIView animateWithDuration:0.0f delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        [self setupFrame];
        self.center = _originalWindow.center;
        [self roate:orientation sacle:0.1];
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.23f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            
            [self roate:orientation sacle:1.2];
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:.09f delay:0.02 options:UIViewAnimationOptionCurveEaseIn animations:^{
                
                [self roate:orientation sacle:0.9];
                
            } completion:^(BOOL finished) {
                
                [UIView animateWithDuration:.05f delay:0.02 options:UIViewAnimationOptionCurveEaseIn animations:^{
                    
                    [self roate:orientation sacle:1.0];
                    
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }];
    }];
}

- (void)setupFrame
{
    switch(_allBtnNum)
    {
        case 0:
        {
            break;
        }
        case 1:
        {
            self.tmri_width=kAlertWidth>_contentView.tmri_width?kAlertWidth:_contentView.tmri_width;
            self.tmri_height=kTitleHeight+_contentView.tmri_height+kButtonHeight+kButtonBottomOffset+kButtonOffset;
            
//            _oneBtn.frame =  CGRectMake((self.width - kSingleButtonWidth) * 0.5,kTitleHeight+kButtonOffset+_contentView.height, kSingleButtonWidth, kButtonHeight);
               _oneBtn.frame =  CGRectMake(0,kTitleHeight+kButtonOffset+_contentView.tmri_height, self.tmri_width, kButtonHeight+kButtonBottomOffset);
            
            break;
        }
        case 2:
        {
            self.tmri_width=kAlertWidth>_contentView.tmri_width?kAlertWidth:_contentView.tmri_width;
            self.tmri_height=kTitleHeight+_contentView.tmri_height+kButtonHeight+kButtonBottomOffset+kButtonOffset;;
            
            _leftBtn.frame = CGRectMake(0,kTitleHeight+kButtonOffset+_contentView.tmri_height, kAlertWidth/2, kButtonHeight+kButtonBottomOffset);
            _rightBtn.frame = CGRectMake(kAlertWidth/2, kTitleHeight+kButtonOffset+_contentView.tmri_height, kAlertWidth/2, kButtonHeight+kButtonBottomOffset);
            
            break;
        }
        default:
        {
            float height = kTitleHeight+60+_buttons.count*kButtonHeight+kButtonBottomOffset;
            float trueHeight = 390.5>height?height:390.5;
            self.frame = CGRectMake((CGRectGetWidth([UIScreen mainScreen].bounds) - kAlertWidth) * 0.5, 0, kAlertWidth, trueHeight);
            for (int i = 0; i < [_buttons count]; i++) {
                UIButton *btn = [_buttons objectAtIndex:i];
                btn.frame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, kTitleHeight+_contentView.tmri_height+kButtonOffset+(kButtonHeight+kButtonBottomOffset) * i, kSingleButtonWidth, kButtonHeight);
            }
            break;
        }
            
    }
    
    _alertTitleLabel.frame = CGRectMake(0, 0, self.tmri_width, kTitleHeight);
    
    _contentView.MinX=0;
    _contentView.tmri_top=CGRectGetMaxY(_alertTitleLabel.frame);
    
}


@end

@implementation UIButton (newbutton)

+ (UIButton *)creatOneBtn:(NSString *)title color:(UIColor *)color frame:(CGRect)frame action:(SEL)action target:(id)target {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    
    [button setBackgroundImage:[UIImage imageWithColor:color] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [button setTitleColor:[UIColor colorWithHex:@"2c66a8"] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

@end


