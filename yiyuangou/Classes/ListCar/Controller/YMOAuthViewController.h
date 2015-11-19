//
//  YMOAuthViewController.h
//  yiyuangou
//
//  Created by roen on 15/11/2.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMOrder.h"
#import "YMPayResult.h"
@interface YMOAuthViewController : UIViewController
@property (assign,nonatomic)NSInteger coin;
@property (strong,nonatomic)YMPayResult * car;

@property (assign,nonatomic)NSInteger pay_way;

@end
