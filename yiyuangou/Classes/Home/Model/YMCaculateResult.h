//
//  YMCaculateResult.h
//  yiyuangou
//
//  Created by roen on 15/11/23.
//  Copyright © 2015年 atobo. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "BaseResult.h"

@interface YMCaculateResult : BaseResult
@property (copy, nonatomic)NSString * baseNum;

@property (copy, nonatomic)NSString * cpQihao;

@property (copy, nonatomic)NSString *  cpResult;

@property (copy, nonatomic)NSString *  timeSum;

@property (copy, nonatomic)NSString * expected;

@property (copy, nonatomic)NSString * luckyNumber;

@property (strong, nonatomic) NSArray* processList;

@end

@interface detailInfo : NSObject

@property (copy, nonatomic)NSString * createTime;
@property (copy, nonatomic)NSString * shortTime;
@property (copy, nonatomic)NSString * sname;

@end
