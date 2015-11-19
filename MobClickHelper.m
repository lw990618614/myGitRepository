//
//  MobClickHelper.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/11/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MobClickHelper.h"

@implementation MobClickHelper
+ (void)umengEvent:(NSString *)eventId attributes:(NSDictionary *)attributes number:(NSNumber *)number
{
    NSString *numberKey = @"__ct__";
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:attributes];
    [mutableDictionary setObject:[number stringValue] forKey:numberKey];
    [MobClick event:eventId attributes:mutableDictionary];
}
@end
