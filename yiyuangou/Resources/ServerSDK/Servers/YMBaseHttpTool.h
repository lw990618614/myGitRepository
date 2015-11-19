//
//  CZBaseHttpTool.h
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YMBaseHttpTool : NSObject
+(void)POST:(NSString *)url params:(id)params success:(void (^)(id result))success failure:(void (^)(NSError * error))failure;
//上传多张图片
+(void)POST:(NSString *)url params:(id)params name:(NSString *)name data:(NSArray *)dataArray success:(void (^)(id result))success failure:(void (^)(NSError * error))failure  uploadProgressBlock:(void(^)(float uploadPercent,long long totalBytesWritten,long long totalBytesExpectedToWrite))uploadProgressBlock;;
@end
