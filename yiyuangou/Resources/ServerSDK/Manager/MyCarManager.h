//
//  MyCarManager.h
//  yiyuangou
//
//  Created by roen on 15/10/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"
@interface MyCarManager : BaseMananger
+(MyCarManager *)sharedManager;
//主页面
-(void)myCarStatuscompletion:(ManagerBlock)block;
//购买页面
-(void)myCarBuyStatusWithTotalMoney:(NSInteger )money andGoods:(NSArray *)goods completion:(ManagerBlock)block;
//删除
-(void)deletmyCarStatusWith:(NSInteger )gid completion:(ManagerBlock)block;
//购买
-(void)MycarFinishiPayStatusWith:(id)model withPay_way:(NSInteger )pay_way completion:(ManagerBlock)block;
//充值
-(void)MycarInputCoin:(NSInteger)coin completion:(ManagerBlock)block;
//取消订单
-(void)dismissTheordercompletion:(ManagerBlock)block;
//查询接口
-(void)payresultWith:(NSInteger)oid:(ManagerBlock)block;
@end;
