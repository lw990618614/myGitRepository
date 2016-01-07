//
//  YMBaseViewController.m
//  yiyuangou
//
//  Created by roen on 15/10/11.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBaseViewController.h"

@implementation YMBaseViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}
-(void)viewDidLoad
{
    if (self.navigationController.viewControllers.count>1) {
        
        self.navigationItem.leftBarButtonItem = [self backItem];
    }
    
}
-(UIBarButtonItem *) backItem
{
    UIImage *btnImage = [UIImage imageNamed:@"返回"];
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0,0, btnImage.size.width, btnImage.size.height);
    [backBtn setBackgroundImage:btnImage forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(popSelf:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    return barBtn;
}
- (void)popSelf:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
