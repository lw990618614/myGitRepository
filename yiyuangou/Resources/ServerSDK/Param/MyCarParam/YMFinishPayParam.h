//
//  YMFinishPayParam.h
//  yiyuangou
//
//  Created by roen on 15/11/5.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParam.h"

@interface YMFinishPayParam : BaseParam
@property (nonatomic ,assign) NSInteger  oid;
@property (nonatomic ,assign) NSInteger  pay_way;
@property (nonatomic ,assign) NSInteger  expendCoin;
@property (nonatomic ,copy) NSString  *transid;

@end
