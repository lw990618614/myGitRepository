//
//  YMLoginModel.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMLoginModel : NSObject
@property (nonatomic,copy)NSString *mobile;
@property (nonatomic,copy)NSString *password;
@property (nonatomic,copy)NSString *flag;
@property(nonatomic,copy)NSString *sname;
@property(nonatomic,copy)NSString *loginName;
@property(nonatomic,copy)NSString *address;
@property(nonatomic,strong)NSString *IP;
@end
