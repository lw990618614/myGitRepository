//
//  RewardManager.m
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "RewardManager.h"
#import "YMRewardParam.h"
#import "YMRewardResult.h"
@implementation RewardManager
SYNTHESIZE_SINGLETON_FOR_CLASS(RewardManager)
+(RewardManager *)sharedManager
{
    return [RewardManager sharedRewardManager];
}
-(void)rewardStatusWith:(NSInteger)lotteryStart completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/upcomingLottery"];
    YMRewardParam *param = [[YMRewardParam alloc] init];
    param.lotteryStart =lotteryStart;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMRewardResult *r = result;
        if ([r isSuceess]) {
            YMRewardResult *re = [[YMRewardResult alloc] init];
            re = [YMRewardResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络不给力T_T");

    }];
}
@end
