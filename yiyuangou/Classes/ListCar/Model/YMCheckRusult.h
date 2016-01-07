//
//  YMCheckRusult.h
//  yiyuangou
//
//  Created by roen on 15/11/25.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMCheckRusult : BaseResult
@property (nonatomic,assign)NSInteger isPay;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,assign)NSInteger payWay;

@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,strong)NSArray *detailList;
@end

@interface GoodInfos : NSObject
@property (nonatomic,assign)NSInteger gid;
@property (nonatomic,assign)NSInteger gsid;
@property (nonatomic,assign)NSInteger actually ;

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *goodsImage;
@property (nonatomic,copy)NSString *period;
@end