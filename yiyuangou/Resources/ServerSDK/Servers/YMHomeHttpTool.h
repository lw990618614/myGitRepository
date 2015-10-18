//
//  YMHomeHttpTool.h
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBaseHttpTool.h"
#import "YMBaseHttpTool.h"
@interface YMHomeHttpTool : NSObject
+(void)postWithUrl:(NSString *)url params:(id)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
