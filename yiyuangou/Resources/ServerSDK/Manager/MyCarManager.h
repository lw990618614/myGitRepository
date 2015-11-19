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

-(void)deletmyCarStatusWith:(NSInteger )gid completion:(ManagerBlock)block;

-(void)MycarFinishiPayStatusWith:(id)model withPay_way:(NSInteger )pay_way completion:(ManagerBlock)block;

-(void)MycarInputCoin:(NSInteger)coin completion:(ManagerBlock)block;

-(void)dismissTheordercompletion:(ManagerBlock)block;
@end;
