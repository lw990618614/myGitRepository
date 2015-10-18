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

@end
