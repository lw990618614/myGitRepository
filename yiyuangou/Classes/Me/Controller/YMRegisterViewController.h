//
//  YMRegisterViewController.h
//  yiyuangou
//
//  Created by roen on 15/10/12.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBaseTableViewController.h"
typedef NS_ENUM(NSUInteger,inputMethod)
{
    YMBindPhone,  //绑定手机
    YMRestPhone,  //重置密码
    YMRegistUser  //注册用户
};
@interface YMRegisterViewController : UIViewController
@property (copy, nonatomic) NSString* titleName;
@property(nonatomic,assign) inputMethod method;
@property(nonatomic,assign)  BOOL isFromLogin;
@property(nonatomic,strong)  NSDictionary *rewardDic;
@end
