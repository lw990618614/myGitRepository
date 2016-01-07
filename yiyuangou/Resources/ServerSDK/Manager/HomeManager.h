//
//  HomeManager.h
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"
#import "YMHomeParam.h"
#import "YMHomeResult.h"
@interface HomeManager : BaseMananger
+(HomeManager*)sharedManager;
//主页面
-(void)homeStatusWithPage:(NSInteger )page completion:(ManagerBlock)block;
//主页面加载更多
-(void)homeMoreStatusWithPage:(NSInteger )page completion:(ManagerBlock)block;

//主页面购买详情
-(void)homeBuyStatusWithGsid:(NSInteger)gsid completion:(ManagerBlock)block;
//时间结束公布获奖者
-(void)homeRefreshCellStatusWithModle:(NSInteger)gsid completion:(ManagerBlock)block;
//开奖规则
-(void)homegetTheRulecompletion:(ManagerBlock)block;

//主页面的须知
-(void)homeInquirecompletion:(ManagerBlock)block;

//商品详情
-(void)detailStatusWithWithGid:(NSInteger)gid andGsid:(NSInteger )gsid completion:(ManagerBlock)block;
//商品详情跟多用户
-(void)detailMoreStatusWithWithGid:(NSInteger)page andGsid:(NSInteger )gsid completion:(ManagerBlock)block;
//获取我的幸运号码
-(void)detailGetMyNumberStatusWithWithGsid:(NSInteger )gsid completion:(ManagerBlock)block;

//获奖计算方式
-(void)detailGetCalculateStatusWithWithGsid:(NSInteger )gsid completion:(ManagerBlock)block;

//往期开奖
-(void)pastRewardStatusWithGid:(NSInteger)gid and:(NSInteger)lotteryStart and:(NSInteger)flag completion:(ManagerBlock)block;
//加入购物车
-(void)AddGoodsToCarStatusWithGid:(NSInteger)gid andGsid:(NSInteger )gsid andUid:(NSInteger ) uid completion:(ManagerBlock)block;



@end
