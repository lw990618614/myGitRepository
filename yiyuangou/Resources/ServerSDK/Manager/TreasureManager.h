//
//  TreasureManager.h
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"
@interface TreasureManager : BaseMananger
+(TreasureManager*)sharedManager;
//某商品的开奖记录
-(void)treasureStatusWithUid:(NSInteger )uid andGid:(NSInteger )gid andPage:(NSInteger )shareStart andflag:(NSInteger)flag completion:(ManagerBlock)block;
@end
