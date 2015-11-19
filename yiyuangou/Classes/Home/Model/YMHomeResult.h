//
//  YMHomeResult.h
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseResult.h"
@interface YMHomeResult :BaseResult

@property (strong, nonatomic) NSMutableArray* flowList;//即将揭晓
@property (strong, nonatomic) NSMutableArray* hotList;//热门
@property (nonatomic,strong) NSMutableArray *bannerList;
@property (nonatomic,strong) NSMutableArray *rewardList;
@property (nonatomic,strong) NSMutableArray *lotteryList;

@property (copy, nonatomic) NSString* grName;//中奖产品
@property (nonatomic,copy)NSString *grPeriod;//中奖期号


@end

@interface HomeFlowList : NSObject
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



@property (nonatomic,copy) NSString * name;


@property (nonatomic,copy) NSString * endTime;

@property (nonatomic,assign) NSInteger  left;

@property (nonatomic,assign) BOOL showPhone;

@property (strong, nonatomic) NSString * phone;

@property (strong, nonatomic) NSString * sname;

@property (nonatomic,assign)NSInteger uid;

@end

@interface HomeHotList : NSObject
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


@property (nonatomic,copy) NSString * name;


@property (nonatomic,copy) NSString * progress;

@property (nonatomic,assign)NSInteger row;

@end


@interface HomeBannerList : NSObject

@property (nonatomic,copy)NSString *url;
@property (nonatomic,assign)NSInteger gid;
@end

@interface HomeRewardList : NSObject
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *sname;
@property (nonatomic,assign)NSInteger grPeriod;
@property (nonatomic,copy)NSString *phone;

@end

@interface SimpleList : NSObject
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *sname;
@property (nonatomic,assign)NSInteger uid;
@end
@interface YMHomelotteryList : NSObject
/**
 *基础商品id
 */
@property (nonatomic,assign)NSInteger gid;
/**
 *每期商品id
 */
@property (nonatomic,assign)NSInteger gsid;

@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *goodsImage;
@property (nonatomic,copy)NSString *luckyNumber;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *sname;

@end