//
//  YMInquireResult.h
//  yiyuangou
//
//  Created by roen on 15/11/20.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseResult.h"

@interface YMInquireResult : BaseResult
@property (nonatomic,strong)NSArray *htmlList;
@end

@interface YMInquqire:NSObject
@property (nonatomic,copy)NSString *descript;

@property (nonatomic,copy)NSString *shortName;

@property (nonatomic,copy)NSString *url;

@end
