//
//  YMWebViewController.m
//  mobi
//
//  Created by Aaron on 15/9/25.
//  Copyright © 2015年 mobi. All rights reserved.
//

#import "YMWebViewController.h"

@interface YMWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)UIActivityIndicatorView *activity;
@property(nonatomic,strong) UILabel                *alertInfo;
@end

@implementation YMWebViewController

-(id)initWithAddress:(NSString *)title address:(NSString *)url{
    self=[super init];
    if (self) {
        self.title=title;
        self.urlStr=url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _webView = [[UIWebView alloc] init];
    _activity = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 32, 32)];
    _webView.delegate = self;
    [_activity setCenter:self.view.center];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.equalTo(self.view.mas_width);
        make.height.equalTo(self.view.mas_height);
        
    }];
    [self.view addSubview:_activity];
    [_activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    [self loadPageWithStr:self.urlStr];
    // Do any additional setup after loading the view.
}
#pragma mark --webView代理方法----
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [_activity startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activity stopAnimating];
    [_alertInfo removeFromSuperview];
    
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
    _alertInfo=  [[UILabel alloc]init];
    _alertInfo.text = @"服务器故障";
    _alertInfo.textColor =  [UIColor heightBlacKColor];
    [self.view addSubview:_alertInfo];
    WEAKSELF;
    [_alertInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
    }];
}
-(void) loadPageWithStr:(NSString *)urlStr
{
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requset];
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
