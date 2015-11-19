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
    NSLog(@"%@",params);
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSLog(@"%@",responseObject);
        NSDictionary * datDict;
        datDict=[NSJSONSerialization JSONObjectWithData:[responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSLog(@"%@",datDict);

        NSDictionary *dict=@{@"code":responseObject[@"code"],@"data":datDict,@"msg":responseObject[@"msg"]};
        BaseResult *result = [BaseResult objectWithKeyValues:dict];

        if ([responseObject [@"code"] longValue] == 0) {//亲求成功
            success(result);
        }else if([responseObject [@"code"] longValue] == 5){//缺少参数
            success(result);
        }else{//服务器错误/商品已购买 code = 6
            success(result);
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        failure(error);
        NSLog(@"请求失败");
    }];
    
}
+(void)POST:(NSString *)url params:(id)params name:(NSString *)name data:(NSArray *)dataArray success:(void (^)(id))success failure:(void (^)(NSError *))failure  uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json",@"text/javascript", nil];
    NSNumber *gsid = params[@"gsid"];
    AFHTTPRequestOperation *operation =
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         // 上传 多张图片
         for(NSInteger i = 0; i < dataArray.count; i++)
         {
             NSData * imageData = [dataArray objectAtIndex: i];
              // 上传的参数名
             NSString * Name = [NSString stringWithFormat:@"%@%ld",gsid,(long)i];
             Name  = name;
             // 上传filename
             NSString * fileName = [NSString stringWithFormat:@"%@.jpg", Name];
             fileName =  [NSString stringWithFormat:@"%@.jpg", Name];
             if ([[imageData class] isSubclassOfClass:[NSData class]]) {
                 [formData appendPartWithFileData:imageData name:Name fileName:fileName mimeType:@"image/jpeg"];

             }
         }
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
        NSDictionary *datDict=[NSJSONSerialization JSONObjectWithData:[responseObject[@"data"] dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];

         NSDictionary *dict=@{@"code":responseObject[@"code"],@"data":datDict,@"msg":responseObject[@"msg"]};
         BaseResult *result = [BaseResult objectWithKeyValues:dict];
         success(result);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         failure(nil);
     }];
    
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        CGFloat percent = totalBytesWritten * 1.0 / totalBytesExpectedToWrite;
        uploadProgressBlock(percent,totalBytesWritten,totalBytesExpectedToWrite);
    }];
}
@end
