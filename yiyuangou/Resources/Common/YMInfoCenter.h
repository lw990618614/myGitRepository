//
//  YMInfoCenter.h
//  mobi
//
//  Created by Simon on 9/21/15.
//  Copyright © 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YMUser.h"

@interface YMInfoCenter : NSObject

@property (nonatomic, strong) YMUser* mainUser;

- (id)init;
+ (id)sharedManager;

+ (NSUInteger)userID;
-(NSString *)getAccount;
- (NSUInteger)getUserID;
- (BOOL)checkClockin;
- (BOOL) updateLastClockin;
- (void)saveUserID;
//保存账户信息
-(void) saveUserAccount;
+(void) savestr:(NSString *)str forkey:(NSString *)key;
+(NSString *) getforkey:(NSString *) key;
-(NSString *) mobile:(NSString *)key;
@end
