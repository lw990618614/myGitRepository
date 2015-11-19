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
#import "YMDetailResult.h"
#import "YMDetailParam.h"

#import "YMPastRewardParam.h"
#import "YMPastRewardResult.h"

#import "YMOrderResult.h"

#import "YMRefreshResult.h"
#import "YMRefreshParam.h"

#import "YMAddCarParam.h"

#import "YMHomeMoreParam.h"

#import "YMDetailMoreParam.h"
#import "YMMoreResult.h"

#import "YMLuckParam.h"
#import "YMRuleParam.h"
#import "YMRuleResult.h"
@implementation HomeManager

SYNTHESIZE_SINGLETON_FOR_CLASS(HomeManager)
+(HomeManager *)sharedManager
{
    return [HomeManager sharedHomeManager];
}
-(void)homeStatusWithPage:(NSInteger )page completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/main"];
    YMHomeParam *param = [[YMHomeParam alloc] init];
    param.hotStart = page;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMHomeResult *r = result;
        NSLog(@"%@",r);
        if ([r isSuceess]) {
            YMHomeResult *re = [[YMHomeResult alloc] init];
            re =  [YMHomeResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");

    }];
}
//获取我的幸运号码
-(void)detailGetMyNumberStatusWithWithGsid:(NSInteger )gsid completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/luckyNumber"];
    YMLuckParam *param = [[YMLuckParam alloc] init];
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        BaseResult *r = result;
        if ([r isSuceess]) {
            if (block) {
                block(r,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
        
    }];


}
-(void)detailMoreStatusWithWithGid:(NSInteger)page andGsid:(NSInteger )gsid completion:(ManagerBlock)block;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/getTotalJoinList"];
    YMDetailMoreParam *param = [[YMDetailMoreParam alloc] init];
    param.totalStart = page;
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMMoreResult *r = result;
        NSLog(@"%@",r);
        if ([r isSuceess]) {
            YMMoreResult *re = [[YMMoreResult alloc] init];
            re =  [YMMoreResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
        
    }];

}
-(void)homeMoreStatusWithPage:(NSInteger )page completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/goodsHotSell"];
    YMHomeMoreParam *param = [[YMHomeMoreParam alloc] init];
    param.hotStart = page;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMHomeResult *r = result;
        NSLog(@"%@",r);
        if ([r isSuceess]) {
            YMHomeResult *re = [[YMHomeResult alloc] init];
            re =  [YMHomeResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");

    }];
}
-(void)homeRefreshCellStatusWithModle:(NSInteger)gsid completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/reward/getPhone"];
    YMRefreshParam *param = [[YMRefreshParam alloc] init];
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMRefreshResult *r = result;
        if ([r isSuceess]) {
            YMRefreshResult *re = [[YMRefreshResult alloc] init];
            re =  [YMRefreshResult objectWithKeyValues:r.data];

            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];
}
-(void)homeBuyStatusWithGsid:(NSInteger)gsid completion:(ManagerBlock)block
{

    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/getSimpleInfo"];
    YMHomeParam *param = [[YMHomeParam alloc] init];
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMHomeResult *r = result;
        if ([r isSuceess]) {
            YMOrderResult *re = [[YMOrderResult alloc] init];
            re =  [YMOrderResult objectWithKeyValues:r.data];

            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];

}
-(void)detailStatusWithWithGid:(NSInteger)gid andGsid:(NSInteger )gsid completion:(ManagerBlock)block;
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/detail"];
    YMDetailParam *param = [[YMDetailParam alloc] init];
    param.gid = gid;
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMDetailResult *r = result;
        if ([r isSuceess]) {
            YMDetailResult *re = [[YMDetailResult alloc] init];
            re =  [YMDetailResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];
}
-(void)pastRewardStatusWithGid:(NSInteger)gid and:(NSInteger)lotteryStart and:(NSInteger)flag completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/goods/lottery"];
    YMPastRewardParam *param = [[YMPastRewardParam alloc] init];
    param.gid = gid;
    param.lotteryStart = lotteryStart;
    param.flag = flag;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMPastRewardResult *r = result;
        if ([r isSuceess]) {
            YMPastRewardResult *pastResult = [[YMPastRewardResult alloc] init];
            pastResult =  [YMPastRewardResult objectWithKeyValues:r.data];
            if (block) {
                block(pastResult,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];

}
-(void)AddGoodsToCarStatusWithGid:(NSInteger)gid andGsid:(NSInteger )gsid andUid:(NSInteger ) uid completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/car/put"];
    YMAddCarParam *param = [[YMAddCarParam alloc] init];
    param.gid = gid;
    param.uid = uid;
    param.gsid = gsid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        BaseResult *r = result;
        if ([r isSuceess]) {
            if (block) {
                block(r,r.code,@"添加成功");
            }
        }else{
            block (r,r.code,@"该商品已经卖完,或者其他客户\n处于购买状态,请稍后购买");
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];
}
//开奖规则
-(void)homegetTheRulecompletion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/html/getResource"];
    YMRuleParam *param = [[YMRuleParam alloc] init];
    param.shortName = @"rewardRule";
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMRuleResult *r = result;
        if ([r isSuceess]) {
            
                YMRuleResult *pastResult = [[YMRuleResult alloc] init];
                pastResult =  [YMRuleResult objectWithKeyValues:r.data];
                if (block) {
                    block(pastResult,r.code,r.msg);
                }

        }else{
            block(nil,C100006,@"网络异常");
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");
    }];

}
@end
