//
//  YMUser.h
//  mobi
//
//  Created by Simon on 9/11/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMUserScore.h"


@interface YMUser : NSObject

//用户头像
@property(strong, nonatomic) NSString* YMUserAvatarURL;
@property(nonatomic,strong)  NSString* YMAccount ;//账户名称
@property(nonatomic,strong)  NSString* YMNickName;//用户昵称
//用户ID
@property(assign,nonatomic) NSUInteger YMUserID;
//用户手机号码
@property(strong, nonatomic) NSString *YMUserMobile;
//用户密码
@property(strong, nonatomic) NSString* YMUserPassword;
//用户的微信号
@property(strong, nonatomic) NSString* YMUserWeixin;
//用户头像
@property(nonatomic,strong)  NSData*    YMUserHeaderImg;//用户头像
//用户收获地址列表
@property(nonatomic,strong)  NSArray * YMAddressArray;
@property(nonatomic,strong)  NSString* YMTotalIncome;//抢币余额
@property(nonatomic,assign)  BOOL isNewUsr;//是否是新用户
@end
