//
//  SettingManager.m
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "SettingManager.h"
#import "SettingParam.h"
#import "YMSettingResult.h"
#import "MJExtension.h"
@implementation SettingManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SettingManager)
+(SettingManager *)sharedManager
{
    return [SettingManager sharedSettingManager];
}
-(void)settingStatuscompletion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/sysuser/info"];
    SettingParam *param = [[SettingParam alloc] init];
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMSettingResult *r = result;
        if ([r isSuceess]) {
            YMSettingResult *re = [[YMSettingResult alloc] init];
            re =  [YMSettingResult objectWithKeyValues:r.data];
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
@end
