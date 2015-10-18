//
//  CZBaseHttpTool.m
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMBaseHttpTool.h"
#import "AFNetworking.h"
#import "BaseResult.h"
@implementation YMBaseHttpTool
+(void)POST:(NSString *)url params:(id)params success:(void (^)(id))success failure:(void (^)(NSError *))failure{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        if ([responseObject [@"code"] longValue] == 0) {
            NSDictionary * datDict=[NSJSONSerialization JSONObjectWithData:[responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            NSDictionary *dict=@{@"code":responseObject[@"code"],@"data":datDict,@"msg":responseObject[@"msg"]};
            BaseResult *result = [BaseResult objectWithKeyValues:dict];
            success(result);
        }else {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
    
}
@end
