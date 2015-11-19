//
//  YMPastRewardResult.h
//  yiyuangou
//
//  Created by roen on 15/10/19.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMPastRewardResult : BaseResult

@property (strong, nonatomic) NSArray* lotteryList;

@end

@interface YMLottery : NSObject
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

@property (nonatomic,copy)NSString *sname;

@property (nonatomic,copy) NSString * price;

@property (nonatomic,copy) NSString * phone;

@property (nonatomic,copy) NSString * menber;

@property (nonatomic,copy) NSString * createTime;

@property (nonatomic,copy) NSString * period;

@property (nonatomic,assign) NSInteger uid;

@end
