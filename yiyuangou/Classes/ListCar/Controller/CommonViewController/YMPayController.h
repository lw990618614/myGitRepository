//
//  YMPayController.h
//  yiyuangou
//
//  Created by roen on 15/10/10.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YMPayResult.h"
@interface YMPayController : YMBaseTableViewController
@property (strong,nonatomic)YMPayResult* car;
//选中的商品
@property (strong,nonatomic)NSArray *selectedArray;
//返回的
@property (copy, nonatomic)NSString *backstring ;
//帐号余额
@property (nonatomic,assign)NSInteger coin;
//充值还是订单 1 属于充值, 0 属于支付
@property (assign ,nonatomic)NSInteger pay_operation;

@end
