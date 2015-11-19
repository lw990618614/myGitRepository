//
//  LoginManager.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"
#import "YMLoginModel.h"
@interface LoginManager : BaseMananger
+(LoginManager *)sharedManager;

-(void)LoginStatusWithModle:(YMLoginModel *)model completion:(ManagerBlock)block;

-(void)registerStatusWithMobile:(NSString *)mobile flag:(NSString *)flag completion:(ManagerBlock)block;

-(void)checkMobileStatusWithMobile:(NSString *)mobile verfy:(NSString *)test completion:(ManagerBlock)block;

@end
