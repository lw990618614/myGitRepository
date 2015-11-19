//
//  YMOrder.h
//  yiyuangou
//
//  Created by roen on 15/11/3.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMOrder : NSObject

@property (nonatomic, copy)NSString * transid;

@property (nonatomic, copy)NSString * redirecturl;

@property (nonatomic, copy)NSString * cpurl;

-(NSString *)qurey;
@end

@interface YMTransid : NSObject

@property (nonatomic, copy)NSString * transid;

@property (nonatomic, copy)NSString * redirecturl;

@property (nonatomic, copy)NSString * cpurl;

-(NSString *)qurey;

@end