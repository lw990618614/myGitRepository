//
//  HomeManager.m
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "HomeManager.h"
#import "YMHomeHttpTool.h"
#import "YMHomeParam.h"
#import "YMHomeResult.h"
#import "YMBaseHttpTool.h"
#import "MJExtension.h"
@implementation HomeManager
SYNTHESIZE_SINGLETON_FOR_CLASS(HomeManager)
+(HomeManager *)sharedManager
{
    return [HomeManager sharedHomeManager];
}
-(void)homeStatusWithModlecompletion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/main"];
    YMHomeParam *param = [[YMHomeParam alloc] init];
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMHomeResult *r = result;
        if ([r isSuceess]) {
          YMHomeResult *homeResult =  [YMHomeResult objectWithKeyValues:r.data];
            if (block) {
                block(homeResult,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
