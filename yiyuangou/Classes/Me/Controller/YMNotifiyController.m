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
#import "MySettingViewController.h"
@interface YMNotifiyController()<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView * loginScrollView;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong) UILabel *notifyLable;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *registerButton;
@property(nonatomic,strong)  MySettingViewController *mySetting;
@end

@implementation YMNotifiyController
-(UIScrollView *)loginScrollView
{
    if ( _loginScrollView == nil) {
        _loginScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT - 64)];
        _loginScrollView.backgroundColor = kViewControllerBackgroundColor;
        _loginScrollView.delegate = self;
    }
    return _loginScrollView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"个人中心";
    [self noLogin];
}
//-(void)viewWillAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    YMInfoCenter *center = [YMInfoCenter sharedManager];
//    if ([center getUserID]) {
//        [self didLogin];
//    }
//    else
//    {
//        [_mySetting.view removeFromSuperview];
//        [_mySetting removeFromParentViewController];
//        [self noLogin];
//    }
//}
-(void) didLogin
{
    if (_mySetting == nil) {
        _mySetting = [[MySettingViewController alloc]init];
    }
        [self.view addSubview:_mySetting.view];
       
        [self addChildViewController:_mySetting];
}
-(void) noLogin
{
    [self.view setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:self.loginScrollView];
    //人头
    self.iconView = [[UIImageView alloc] init];
    self.iconView.image = [UIImage imageNamed:@"headTitle"];
    [self.loginScrollView addSubview:self.iconView];
    self.navigationItem.hidesBackButton = YES;
    WEAKSELF;
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    self.notifyLable = [[UILabel alloc] init];
    self.notifyLable.textColor = [UIColor lightColor];
    self.notifyLable.font = [UIFont systemFontOfSize:15.0];
    self.notifyLable.text = @"欢迎使用99夺宝，您还没登录，请先登录。";
    [self.loginScrollView addSubview:self.notifyLable];
    [self.notifyLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(self.iconView.mas_bottom).offset(25);
    }];
    
    self.loginButton = [UIButton new];
    [self.loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.loginButton setBackgroundColor:[UIColor  colorWithHex:@"#DD2727"]];
    [self.loginButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        YMLoginViewController *controller = [[YMLoginViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    [self.loginScrollView addSubview:self.loginButton];
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(self.notifyLable.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
    
    //注册
    self.registerButton = [UIButton new];
    [self.registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [self.registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.registerButton setBackgroundColor:[UIColor whiteColor]];
    [self.registerButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        YMRegisterViewController *controller = [[YMRegisterViewController alloc] init];
        [self setHidesBottomBarWhenPushed:YES];
        controller.titleName = @"注册用户";
        controller.method = YMRegistUser;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    self.registerButton.backgroundColor = [UIColor colorWithHex:@"FF9600"];
    [self.loginScrollView addSubview:self.registerButton];
    [self.registerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(self.loginButton.mas_bottom).offset(7.5);
        make.size.mas_equalTo(CGSizeMake(180, 40));
    }];
}
@end
