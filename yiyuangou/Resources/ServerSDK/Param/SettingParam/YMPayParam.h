//
//  YMPayParam.h
//  yiyuangou
//
//  Created by roen on 15/10/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParam.h"

@interface YMPayParam : BaseParam
@property (nonatomic ,assign) NSInteger  money;

@property (nonatomic,strong)NSString *goodsList;

@end

@interface PayGoodsInfo : NSObject

@property (nonatomic ,assign) NSInteger  gsid;
@property (nonatomic ,assign) NSInteger  count;
@property (nonatomic ,assign) NSInteger  is_end;
@property (nonatomic,copy)NSString *redirecturl;

@end