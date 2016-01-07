//
//  MyCarManager.m
//  yiyuangou
//
//  Created by roen on 15/10/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "MyCarManager.h"
#import "YMCarParam.h"
#import "YMCarResult.h"

#import "YMPayParam.h"
#import "YMPayResult.h"

#import "YMDeleteCarParam.h"

#import "YMFinishPayParam.h"
#import "YMFinishResult.h"

#import "YMCashParam.h"
#import "YMCashResult.h"
#import "YMResiltParam.h"
#import "YMCheckRusult.h"
@implementation MyCarManager
SYNTHESIZE_SINGLETON_FOR_CLASS(MyCarManager)
+(MyCarManager *)sharedManager
{
    return [MyCarManager sharedMyCarManager];
}

-(void)myCarStatuscompletion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/car/list"];
    YMCarParam *param = [[YMCarParam alloc] init];
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMCarResult *r = result;
        if ([r isSuceess]) {
            YMCarResult *re = [[YMCarResult alloc] init];
            re =  [YMCarResult objectWithKeyValues:r.data];
            for (YMCarInfo *goodinfo in re.carList) {
                if ( goodinfo.leftAmount == 0) {
//                    [re.carList removeObject:goodinfo];
                }
            }
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
-(void)myCarBuyStatusWithTotalMoney:(NSInteger )money andGoods:(NSArray *)goods completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/pay/add"];
    YMPayParam *param = [[YMPayParam alloc] init];
    param.money = money ;
    NSMutableArray *infoArray= [[NSMutableArray alloc] init];
    for (YMCarInfo *goodInfo in goods) {
        PayGoodsInfo *info = [[PayGoodsInfo alloc] init];
        info.count = goodInfo.buyCount;
//        info.redirecturl = @"http://99duobao";
        info.gsid = goodInfo.gsid;
        info.is_end = goodInfo.is_end;
        [infoArray addObject:info];
    }
    NSArray *dictionArray = [[NSArray alloc] init];
    dictionArray = [PayGoodsInfo keyValuesArrayWithObjectArray:infoArray];
    NSDictionary *dic = [dictionArray keyValuesWithKeys:dictionArray];
    NSString *goodstring = dic.JSONString;
    param.goodsList = goodstring;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMPayResult *r = result;
        if ([r isSuceess]) {
            YMPayResult *re = [[YMPayResult alloc] init];
            re =  [YMPayResult objectWithKeyValues:r.data];
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

-(void)deletmyCarStatusWith:(NSInteger )gid completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/car/remove"];
    YMDeleteCarParam *param = [[YMDeleteCarParam alloc] init];
    param.gid = gid;
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
        block(nil,C100007,@"网络不给力T_T");

    }];
}
-(void)MycarFinishiPayStatusWith:(id)model withPay_way:(NSInteger )pay_way completion:(ManagerBlock)block
{
    YMPayResult *result = model;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/pay/complete"];
    YMFinishPayParam *param = [[YMFinishPayParam alloc] init];
    param.oid = result.oid;
    param.pay_way = pay_way;
    param.expendCoin = result.toatlPrice;
    param.transid = result.transid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMFinishResult *r = result;
        if ([r isSuceess]) {
            YMFinishResult *re = [[YMFinishResult alloc] init];
            re =  [YMFinishResult objectWithKeyValues:r.data];

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
-(void)MycarInputCoin:(NSInteger)coin completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/pay/recharge"];
    YMCashParam *param = [[YMCashParam alloc] init];
    param.coin = coin;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        BaseResult *r = result;
        if ([r isSuceess]) {
            YMCashResult *re = [[YMCashResult alloc] init];
            re =  [YMCashResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            if (block) {
                block(nil,r.code,r.msg);
            }
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络不给力T_T");
    }];


}
-(void)dismissTheordercompletion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/pay/cancel"];
    BaseParam *param = [[BaseParam alloc] init];
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        BaseResult *r = result;
        if ([r isSuceess]) {
            if (block) {
                block(r,r.code,@"成功");
            }
        }else{
            if (block) {
                block(nil,r.code,@"取消失败");
            }
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络不给力T_T");
    }];

}
-(void)payresultWith:(NSInteger)oid:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/order/detail"];
    YMResiltParam *param = [[YMResiltParam alloc] init];
    param.oid = oid;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMCheckRusult *r = result;
        if ([r isSuceess]) {
            YMCheckRusult *re = [[YMCheckRusult alloc] init];
            re =  [YMCheckRusult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else{
            if (block) {
                block(nil,r.code,r.msg);
            }
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络不给力T_T");
    }];

}
@end
