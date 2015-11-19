//
//  YMRewardResult.h
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMRewardResult : BaseResult

@property (strong, nonatomic) NSMutableArray* flowList;
@property (strong, nonatomic) NSMutableArray* lotteryList;

@end

@interface RewardFlowList : NSObject
/**
 *基础商品id
 */
@property (nonatomic,assign)NSInteger gid;
/**
 *每期商品id
 */
@property (nonatomic,assign)NSInteger gsid;

/**
 *  图片地址
 */

@property (nonatomic,copy) NSString * goodsImage;

@property (nonatomic,copy)NSString *price;

@property (nonatomic,copy) NSString * sname;
@property (nonatomic,copy) NSString * name;

@property (nonatomic,copy) NSString * endTime;

@property (nonatomic,assign)NSInteger left;

@property (nonatomic,copy) NSString *phone;

@property (assign, nonatomic)NSInteger  menber;

@property (copy, nonatomic)NSString * createTime;

@property (copy, nonatomic)NSString * period;

@property (nonatomic ,assign)BOOL showPhone;


@property (nonatomic ,assign)NSInteger uid;

@end


@interface RewardLotteryList : NSObject
/**
 *基础商品id
 */
@property (nonatomic,assign)NSInteger gid;
/**
 *每期商品id
 */
@property (nonatomic,assign)NSInteger gsid;


@property (nonatomic,copy) NSString * goodsImage;


@property (nonatomic,copy) NSString * name;


@property (nonatomic,copy) NSString * price;


@property (nonatomic,copy) NSString * sname;


@property (nonatomic,copy) NSString *  menber;

@property (nonatomic,copy) NSString * createTime;

@property (nonatomic ,assign)NSInteger uid;

@property (nonatomic,copy) NSString * phone;

@property (copy, nonatomic)NSString * period;


@end
