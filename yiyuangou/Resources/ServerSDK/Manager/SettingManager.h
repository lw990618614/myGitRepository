//
//  SettingManager.h
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseMananger.h"

@interface SettingManager : BaseMananger
+(SettingManager *)sharedManager;
-(void)settingStatuscompletion:(ManagerBlock)block;
@end
