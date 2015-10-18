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

@property (strong, nonatomic) NSArray* flowList;
@property (strong, nonatomic) NSArray* hotList;
@property (strong, nonatomic) NSArray* lotteryList;

@end

@interface FlowList : NSObject
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

@end

@interface HotList : NSObject
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

@end

@interface LotteryList : NSObject
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


@property (nonatomic,copy) NSString * price;


@property (nonatomic,copy) NSString * phone;


@property (nonatomic,assign) NSInteger  menber;

@property (nonatomic,copy) NSString * createTime;

@end