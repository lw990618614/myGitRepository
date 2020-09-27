//
//  ShowChatStateView.m
//  WeChatDemoDylib
//
//  Created by apple on 2020/1/17.
//  Copyright © 2020 LogicEDU. All rights reserved.
//

#import "ShowChatStateView.h"
#define IS_IPHONE_X (([[UIScreen mainScreen] bounds].size.height == 2436/3) ? YES : NO)
#define ActualHeight(input)         ((input) * SCREEN_HEIGHT / 568.0)
#define SCREEN_BOUNDS       ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH        CGRectGetWidth(SCREEN_BOUNDS)
#define SCREEN_HEIGHT       CGRectGetHeight(SCREEN_BOUNDS)
@interface ShowChatStateView ()
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, strong) UILabel *label;

@end
@implementation ShowChatStateView


+(void)showLabelWithString:(NSString *)string{
    UIWindow *topView = [UIApplication sharedApplication].keyWindow;
    UIViewController *rootVC = topView.rootViewController;


    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:string preferredStyle:UIAlertControllerStyleAlert];
     [rootVC presentViewController:alert animated:YES completion:nil];
    //控制提示框显示的时间为2秒
     [self performSelector:@selector(dismiss:) withObject:alert afterDelay:2.0];

}

+(void)dismiss:(UIAlertController *)alert{
    [alert dismissViewControllerAnimated:YES completion:nil];
}

@end
