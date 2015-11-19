//
//  YMCarResult.h
//  yiyuangou
//
//  Created by roen on 15/10/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMCarResult : BaseResult
@property (strong, nonatomic) NSMutableArray* carList;

@end

@interface YMCarInfo : NSObject
@property (assign, nonatomic) NSInteger gsid;

@property (assign, nonatomic) NSInteger gid;

@property (assign, nonatomic) NSInteger period;

@property (copy, nonatomic) NSString* progress;

@property (copy, nonatomic) NSString* expected;

@property (copy, nonatomic) NSString* name;

@property (copy, nonatomic) NSString* actually ;

@property (copy, nonatomic) NSString* leftAmount;

@property (copy, nonatomic) NSString* price;

@property (copy, nonatomic) NSString* goodsImage;

@property (assign,nonatomic)NSInteger allPrice;

@property (assign,nonatomic)NSInteger buyCount;

//是否包尾
@property (assign,nonatomic)NSInteger is_end;
//判断该商品是否选中状态
@property (assign,nonatomic)BOOL is_selete;

//该上平的选中状态
@property (assign,nonatomic)BOOL lastis_selete;




@end