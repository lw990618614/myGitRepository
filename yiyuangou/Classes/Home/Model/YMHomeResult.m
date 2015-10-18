//
//  YMHomeResult.m
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeResult.h"

#import "MJExtension.h"
@implementation YMHomeResult
-(NSDictionary *)objectClassInArray{
    return @{@"flowList":[FlowList class],@"hotList":[HotList class],@"lotteryList":[LotteryList class]};
}
@end

@implementation FlowList

@end

@implementation HotList

@end

@implementation LotteryList

@end