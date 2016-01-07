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
#import "YMPayResultController.h"
@interface YMOAuthViewController ()<UIWebViewDelegate>
{
    NSString *url;
}
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,strong)UIButton *backButton;
@property (nonatomic,assign)NSInteger mystar;
@property (nonatomic,assign)NSInteger loading;
@property (nonatomic,strong)UIView *notiView;

@end

@implementation YMOAuthViewController
-(UIView *)notiView
{
    if (_notiView == nil) {
        _notiView = [[UIView alloc] initWithFrame:self.view.bounds];
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage  imageNamed:@"加载失败"]];
        
        UILabel *messageLabel = [UILabel labelWithFrame:CGRectZero textAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithHex:@"#444444"]];
        messageLabel.text = @"哎呀!加载失败了...";
        [_notiView addSubview:iconView];
        [_notiView addSubview:messageLabel];
        
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(_notiView);
        }];
        
        [iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(messageLabel.mas_top).mas_offset(-10);
            make.centerX.mas_equalTo(messageLabel);
        }];
    }
    return _notiView;
}

-(void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
    [UIApplication sharedApplication].statusBarHidden = NO;

}
- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationController.navigationBarHidden=YES;
//    [UIApplication sharedApplication].statusBarHidden = YES;
    self.view.backgroundColor  =[UIColor whiteColor];
    UIImage *btnImage = [UIImage imageNamed:@"返回"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(poptoMysetting) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];

    if (self.pay_way == 1) {//充值
        [self getcash];
    }else{
        url = self.car.url;
        self.navigationItem.leftBarButtonItem = barBtn;

        [self makeUI]; //爱呗支付;
    }

}
-(void)getcash
{
    SAFE;

    [[MyCarManager sharedManager] MycarInputCoin:self.coin completion:^(id result, NSInteger statusCode, NSString *msg) {

        if (statusCode == 0) {
           YMCashResult *cash = result;
            url = cash.url;
            [weakSelf makeUI];
        }else{
            [self.view addSubview:self.notiView];

        }
    }];
}
-(void)makeUI
{

//    self.view.backgroundColor = [UIColor whiteColor];
//    self.webView = [[UIWebView alloc] init];
//    self.webView.delegate = self;
//    self.webView.backgroundColor = [UIColor grayColor];
//    self.webView.bounds = self.view.bounds;
//    self.webView.center = self.view.center;
////    self.webView.scrollView.scrollEnabled = NO;
//    [self.view addSubview:self.webView];
    NSURL* dataurl = [[ NSURL alloc ] initWithString:url];
    [[UIApplication sharedApplication ] openURL: dataurl];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(0);
//        make.top.mas_equalTo(0);
//        make.width.equalTo(self.view.mas_width);
//        make.height.equalTo(self.view.mas_height);
//        
//    }];
////    self.backButton = [UIButton buttonWithFrame:CGRectMake(14, 380, 60, 20) target:self action:@selector(backToAPP) title:@"修改订单" cornerRadius:2];
////    [self.backButton setTitleColor:[UIColor colorWithHex:@"#999999"] forState:UIControlStateNormal];
////    self.backButton.backgroundColor = [UIColor colorWithHex:@"#d8d8d8"];
////    self.backButton.titleLabel.font = [UIFont systemFontOfSize:13];
////    [self.webView addSubview:self.backButton];
//    [self.webView loadRequest:request];
//    
//    _webView.scalesPageToFit = YES;
    

}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self.view makeToastActivity:kLoadingText];

    NSLog(@"%@",request.URL);
    if ([request.URL.absoluteString hasPrefix:@"willpay://comiosdevapp99duobao"]) {
        
        if (self.pay_way == 0) {//订单支付
            self.navigationController.navigationBarHidden=NO;
//            self.backButton.hidden = YES;

//            YMTreasureListController *controller = [[YMTreasureListController alloc] init];
//            controller.isHidenRight = YES;
//            [self.navigationController pushViewController:controller animated:YES];
            [self poptoMysetting];
        }else{//充值
//            MobClickHelper umengEvent:(NSString *) attributes:<#(NSDictionary *)#> number:<#(NSNumber *)#>
            [[NSNotificationCenter defaultCenter] postNotificationName:REFRESH_SELF object:nil];

            self.navigationController.navigationBarHidden=NO;
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        return NO;
    } else if ([request.URL.absoluteString hasPrefix:@"weixin://"]){
        NSLog(@"点击微信");
        [self.view hideToastActivity];

    }
    else if ([request.URL.absoluteString hasPrefix:@"https://wappaygw.alipay.com"]){
        NSLog(@"支付宝");
        [self.view hideToastActivity];

//        self.backButton.hidden = YES;

   
    }else if ([request.URL.absoluteString hasPrefix:@"https://gateway.95516"]){
        [self.view hideToastActivity];

        NSLog(@"点击银联");

    }else if([request.URL.absoluteString hasPrefix:@"https://web.iapppay.com/h5/beg"]){
        NSLog(@"回到支付页面");
        self.backButton.hidden = NO;
    }


    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (self.loading>=2) {
        [self.view hideToastActivity];
    }
    self.loading ++;
}
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.view hideToastActivity];
}
-(void)poptoMysetting{
    YMPayResultController *controller = [[YMPayResultController alloc] init];
    controller.oid = self.oid;
    [self setHidesBottomBarWhenPushed:YES];
    controller.isHidenRight = YES;

//    [self.navigationController presentViewController:nav animated:YES completion:nil];
    [self.navigationController pushViewController:controller animated:YES];

}
@end
