//
//  YMNotifiyController.m
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMNotifiyController.h"
#import "YMLoginViewController.h"
#import "YMRegisterViewController.h"
#import "UIButton+Block.h"
@interface YMNotifiyController()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * loginScrollView;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong) UILabel *notifyLable;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registerButton;

@end

@implementation YMNotifiyController
-(UIScrollView *)loginScrollView
{
    if ( _loginScrollView == nil) {
        _loginScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64)];
        _loginScrollView.delegate = self;
    }
    return _loginScrollView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.loginScrollView];
    self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    self.iconView.image = [UIImage imageNamed:@"mySelIcon"];
    [self.view addSubview:self.iconView];
    
    self.notifyLable = [UILabel labelWithFrame:CGRectMake(self.iconView.tmri_right + 10, (self.iconView.tmri_height - 15)*0.5 + 10, kHEIGHT, 15) textAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor]];
    self.notifyLable.text = @"欢迎使用一元购，您还没登录，请先登录。";
    [self.view addSubview:self.notifyLable];
    
    self.loginButton = [UIButton new];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[UIColor redColor]];
    [self.loginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        YMLoginViewController *controller = [[YMLoginViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }];
    
    self.registerButton = [UIButton new];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registerButton setBackgroundColor:[UIColor whiteColor]];
    self.registerButton.layer.borderColor = [UIColor redColor].CGColor;
    self.registerButton.layer.borderWidth = 1;
    [self.registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        YMRegisterViewController *controller = [[YMRegisterViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        [self setHidesBottomBarWhenPushed:NO];
    }];
    [self.view addSubview:self.registerButton];
    [self.view addSubview:self.loginButton];
    self.loginButton.frame = CGRectMake(kWIDTH *0.5 - 100- 40, self.iconView.tmri_bottom + 40, 100, 40);
    self.registerButton.frame = CGRectMake(kWIDTH *0.5 + 40, self.iconView.tmri_bottom + 40, 100, 40);

//    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.iconView).with.offset(10);
//        make.height.equalTo(@25);
//        make.width.equalTo(@100);
//        make.top.equalTo(self.iconView.right).with.offset(0);
//    }];
//    
//    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.iconView).with.offset(10);
//        make.height.equalTo(@25);
//        make.width.equalTo(@100);
//        make.top.equalTo(self.iconView).with.offset(40);
//    }];

}

@end
