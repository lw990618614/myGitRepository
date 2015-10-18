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
- (NSUInteger)getUserID;

- (BOOL)checkClockin;

- (BOOL) updateLastClockin;
/**
 *    @author Simon, 15-10-01 03:10:15
 *
 *    保存user ID 到defaults
 *
 *    @since 0.1
 */
- (void)saveUserID;
@end
