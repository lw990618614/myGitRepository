//
//  YMOAuthViewController.m
//  yiyuangou
//
//  Created by roen on 15/11/2.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import "YMOAuthViewController.h"
#import "MyCarManager.h"
#import "YMCashResult.h"
#import "AppDelegate.h"
#import "YMTabBarController.h"
#import "YMTreasureListController.h"
#import "MySettingViewController.h"
@interface YMOAuthViewController ()<UIWebViewDelegate>
{
    NSString *url;
}
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,assign)NSInteger mystar;
@end

@implementation YMOAuthViewController
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
    [UIApplication sharedApplication].statusBarHidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.view.backgroundColor  =[UIColor whiteColor];
    if (self.pay_way == 1) {//充值
        [self getcash];
    }else{
        url = self.car.url;
        [self makeUI]; //爱呗支付;
    }
}
-(void)getcash
{
    SAFE;
    [self.view makeToastActivity:kLoadingText];

    [[MyCarManager sharedManager] MycarInputCoin:self.coin completion:^(id result, NSInteger statusCode, NSString *msg) {
        [weakSelf.view hideToastActivity];

        if (statusCode == 0) {
           YMCashResult *cash = result;
            url = cash.url;
            [weakSelf makeUI];
        }
    }];
}
-(void)makeUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor grayColor];
    self.webView.bounds = self.view.bounds;
    self.webView.center = self.view.center;
//    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    self.backButton = [UIButton buttonWithFrame:CGRectMake(0, 10, 60, 30) target:self action:@selector(backToAPP) title:@"返回" cornerRadius:2];
//    self.backButton.hidden = 
    self.backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.webView addSubview:self.backButton];
    [self.webView loadRequest:request];

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@",request.URL);
    if ([request.URL.absoluteString hasPrefix:@"willpay://comiosdevapp99duobao"]) {
        
        if (self.pay_way == 0) {//订单支付
            self.navigationController.navigationBarHidden=NO;
            self.backButton.hidden = YES;

            YMTreasureListController *controller = [[YMTreasureListController alloc] init];
            controller.isHidenRight = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }else{//充值
            [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil];

            self.navigationController.navigationBarHidden=NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        return YES;
    } else if ([request.URL.absoluteString hasPrefix:@"weixin://"]){
        self.backButton.hidden = YES;
        NSLog(@"点击微信");

    }
    else if ([request.URL.absoluteString hasPrefix:@"https://wappaygw.alipay.com"]){
        NSLog(@"支付宝");
        self.backButton.hidden = YES;

   
    }else if ([request.URL.absoluteString hasPrefix:@"https://gateway.95516"]){
        NSLog(@"点击银联");

    }else if([request.URL.absoluteString hasPrefix:@"https://web.iapppay.com/h5"]){
        NSLog(@"回到支付页面");
        self.backButton.hidden = NO;
    }


    return YES;
}
-(void)backToAPP
{
    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确认放弃支付" delegate:self cancelButtonTitle:nil otherButtonTitles:@"取消", @"确认",nil];
    [alterView show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
