//
//  YMLoginResult.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"
#import "YMAddress.h"
@interface YMLoginResult : BaseResult
@property (nonatomic,assign)NSInteger uid;
@property(nonatomic,strong) NSArray *addressList;
@property(nonatomic,assign)NSUInteger flag;
@end
