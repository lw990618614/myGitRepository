//
//  YMLoginParam.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParam.h"

@interface YMLoginParam : BaseParam
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *sname;
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *IP;
@end
