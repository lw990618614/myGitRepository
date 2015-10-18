//
//  YMHomeHttpTool.m
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMHomeHttpTool.h"
#import "YMBaseHttpTool.h"
@implementation YMHomeHttpTool
+(void)postWithUrl:(NSString *)url params:(id)params resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    [YMBaseHttpTool POST:url params:params success:^(id result) {
        if([result[@"code"] longValue] == 0){
            success(result);
        }else{
        
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
}
@end
