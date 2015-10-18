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
/**
 *    @author Simon, 15-09-21 11:09:26
 *
 *    用户的 ID, 新用户无 ID 时, 通过接口,系统自动分配
 *
 *    @since  0.1
 */
@property(nonatomic) unsigned long YMUserID;
/**
 *    @author Simon, 15-09-21 11:09:50
 *
 *    用户的昵称
 *
 *    @since 0.1
 */
@property(strong, nonatomic) NSString *YMUserNickname;
/**
 *    @author Simon, 15-09-21 11:09:01
 *
 *    用户的生日
 *
 *    @since 0.1
 */
@property(strong, nonatomic) NSDate* YMUserBirthday;
/**
 *    @author Simon, 15-09-21 11:09:08
 *
 *    用户的头像在服务器的地址
 *
 *    @since 0.1
 */
@property(strong, nonatomic) NSString* YMUserAvatarURL;
/**
 *    @author Simon, 15-09-21 11:09:38
 *
 *    用户的性别
 *
 *    @since 0.1
 */
@property(strong, nonatomic) NSString* YMUserGender;
/**
 *    @author Simon, 15-09-21 11:09:47
 *
 *    用户的职业
 *
 *    @since 0.1
 */
@property(strong, nonatomic) NSString* YMUserOccupation;
/**
 *    @author Simon, 15-09-21 11:09:02
 *
 *    用户的积分
 *
 *    @since 0.1
 */
@property(strong, nonatomic) YMUserScore* userScore;

@property(strong, nonatomic) NSString *YMUserAlipay;

@property(strong, nonatomic) NSString *YMUserDId;

@property(strong, nonatomic) NSString *YMUserEmail;

@property(strong, nonatomic) NSString *YMUserLevel;

@property(nonatomic) BOOL YMUserEnabled;

@property(strong, nonatomic) NSString *YMUserMobile;

@property(strong, nonatomic) NSString* YMUserPassword;

@property(strong, nonatomic) NSString* YMUserUcode;

@property(strong, nonatomic) NSString* YMUserWeixin;

@property(nonatomic,strong) NSData*    YMUserHeaderImg;//用户头像
@end
