//
//  YMRuleController.m
//  yiyuangou
//
//  Created by roen on 15/10/15.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import "HomeManager.h"
#import "YMRuleController.h"
#import "YMRuleResult.h"
@interface YMRuleController()<UIWebViewDelegate>
@property (nonatomic,strong)UIWebView *webView;
@property (nonatomic,copy)NSString *url;
@end

@implementation YMRuleController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"开奖规则";
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadData];
}
-(void)loadData{
    SAFE;
  [[HomeManager sharedManager] homegetTheRulecompletion:^(id result, NSInteger statusCode, NSString *msg) {
      if (statusCode == 0) {
          YMRuleResult *re = result;
          _url = re.url;
          [weakSelf makeUI];
      }
  }];
}
-(void)makeUI
{
    self.webView = [[UIWebView alloc] initWithFrame: self.view.bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    self.webView = [[UIWebView alloc] init];
    self.webView.delegate = self;
    self.webView.backgroundColor = [UIColor grayColor];
    self.webView.bounds = self.view.bounds;
    self.webView.center = self.view.center;
    //    self.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    //    self.backButton = [UIButton buttonWithFrame:CGRectMake(0, 400, 60, 30) target:self action:@selector(backToAPP) title:@"返回" cornerRadius:2];
    //    self.backButton.titleLabel.font = [UIFont systemFontOfSize:14];
    //    [self.backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [self.webView addSubview:self.backButton];
    [self.webView loadRequest:request];

}
@end
