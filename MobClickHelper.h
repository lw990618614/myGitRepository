//
//  MobClickHelper.h
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>
//友盟统计
@interface MobClickHelper : NSObject
+ (void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number;
@end
