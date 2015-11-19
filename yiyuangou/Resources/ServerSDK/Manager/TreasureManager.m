//
//  TreasureManager.m
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "TreasureManager.h"
#import "TreasureResult.h"
#import "YMRewardParam.h"
@implementation TreasureManager
SYNTHESIZE_SINGLETON_FOR_CLASS(TreasureManager)
+(TreasureManager *)sharedManager
{
    return [TreasureManager sharedTreasureManager];
}
-(void)treasureStatusWithUid:(NSInteger )uid andGid:(NSInteger )gid andPage:(NSInteger )shareStart andflag:(NSInteger)flag completion:(ManagerBlock)block;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/share/list"];
    YMRewardParam *param = [[YMRewardParam alloc] init];
    param.gid = gid;
    param.uid = uid;
    param.shareStart = shareStart;
    param.flag = flag;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        TreasureResult *r = result;
        NSLog(@"%@",r);
        if ([r isSuceess]) {
            TreasureResult *pastResult = [[TreasureResult alloc] init];
            pastResult =  [TreasureResult objectWithKeyValues:r.data];
            if (block) {
                block(pastResult,r.code,r.msg);
            }
        }
        else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        //网络请求失败code == 8
        block(nil,C100007,@"网络异常");
    }];

}
@end
