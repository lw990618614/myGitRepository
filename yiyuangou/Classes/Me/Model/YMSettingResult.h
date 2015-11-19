//
//  YMSettingResult.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"
#import "YMAddress.h"
@interface YMSettingResult : BaseResult

@property (nonatomic,copy) NSString * picture_ulr;
@property (nonatomic,copy) NSString * account;
@property (nonatomic,copy) NSString * name;
@property (nonatomic,copy) NSString * LeftMoney;
@property(nonatomic,strong)NSArray  *addressList;
@property(nonatomic,copy) NSNumber  *source;
@property(nonatomic,copy) NSString  *mobile;
@end
