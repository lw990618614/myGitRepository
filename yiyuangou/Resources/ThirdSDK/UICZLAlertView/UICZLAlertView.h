//
//  UICZLAlertView.h
//  main
//
//  Created by Ch on 14/11/18.
//  Copyright (c) 2014年 ChinaTelecom. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICZLAlertView.h"
typedef BOOL (^UICZLAlertViewBlock)(NSInteger buttonIndex);

@class UICZLAlertView;
@protocol  CzlAlertViewDelegate <NSObject>

@optional
- (BOOL)czlAlertView:(UICZLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

@end


@interface UICZLAlertView : UIView
{
    UIWindow *_originalWindow;
    UIView *_backgroundView;
    UILabel *_alertTitleLabel;
    
    NSMutableArray *_buttons;
    NSInteger _allBtnNum;
    UIButton *_oneBtn;
    UIButton *_rightBtn;
    UIButton *_leftBtn;
}

@property(nonatomic,strong) id<CzlAlertViewDelegate> delegate;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIView *contentView;

- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView delegate:(id<CzlAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString *)title contentView:(UIView *)contentView block:(UICZLAlertViewBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithTitle:(NSString *)title contentTxt:(NSString *)contentTxt delegate:(id<CzlAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
- (void)show;

@end

@interface UIButton (newbutton)

+ (UIButton *)creatOneBtn:(NSString *)title color:(UIColor *)color frame:(CGRect)frame action:(SEL)action target:(id)target;

@end

