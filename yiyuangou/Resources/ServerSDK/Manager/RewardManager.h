//
//  RewardManager.h
//  yiyuangou
//
//  Created by roen on 15/10/18.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"

@interface RewardManager : BaseMananger
+(RewardManager*)sharedManager;

-(void)rewardStatusWith:(NSInteger)lotteryStart completion:(ManagerBlock)block;

@end
