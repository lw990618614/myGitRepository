//
//  YMOrderResult.h
//  yiyuangou
//
//  Created by roen on 15/10/20.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMOrderResult : BaseResult
/**
 *基础商品id
 */
@property (nonatomic,assign)NSInteger gid;
/**
 *每期商品id
 */
@property (nonatomic,assign)NSInteger gsid;

@property (nonatomic,assign)NSInteger isAll;

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger left;

@property (nonatomic,assign)NSInteger expected;
@property (nonatomic,copy)NSString *imageUrl;

@property (nonatomic,assign)NSInteger  productionAcount;

@property (nonatomic,assign)NSInteger  unitPrice;

@property (nonatomic,assign)NSInteger buyCount;
@end
