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

-(void)homeStatusWithModlecompletion:(ManagerBlock)block;

@end
