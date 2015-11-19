//
//  YMRewardParam.h
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParam.h"

@interface YMRewardParam : BaseParam
//商品
@property (assign, nonatomic)NSInteger gid;

@property (assign, nonatomic)NSInteger lotteryStart;

@property (assign, nonatomic)NSInteger shareStart;
//判断是否是加载数据还是刷新
@property (assign, nonatomic)NSInteger flag;


@end
