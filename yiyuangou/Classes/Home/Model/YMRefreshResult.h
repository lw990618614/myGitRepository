//
//  YMRefreshResult.h
//  yiyuangou
//
//  Created by roen on 15/10/21.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMRefreshResult : BaseResult
@property (copy, nonatomic)NSString * phone;

@property (copy, nonatomic)NSString * sname;

@property (assign, nonatomic)NSInteger  menber;

@property (copy, nonatomic)NSString * createTime;

@property (nonatomic,assign) NSInteger uid;

@property (copy, nonatomic)NSString * period;

@end
