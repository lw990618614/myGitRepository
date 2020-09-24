//
//  MySqliteLSModel.h
//  MWDemoDylib
//
//  Created by apple on 2020/8/14.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySqliteLSModel : NSObject
@property (nonatomic, copy) NSString * user_ID;//用户的id
@property (nonatomic, copy) NSString * nickName;//用户名字
@property (nonatomic, copy) NSString * playerID;//用户在插件系统的名字
@property (nonatomic, copy) NSString * playerName;//系统插件用户名字

@property (nonatomic, copy) NSString * playtime;
@property (nonatomic, copy) NSString * playnumber;
@property (nonatomic, copy) NSString * playType;
@property (nonatomic, copy) NSString * playManager;
@property (nonatomic, copy) NSString * playbeishu;
@property (nonatomic, copy) NSString * playjifen;
@property (nonatomic, copy) NSString * playsyjifen;

@end

NS_ASSUME_NONNULL_END
