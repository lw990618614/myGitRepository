//
//  BaseParamDic.m
//  yiyuangou
//
//  Created by 张莉梅 on 15/10/28.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParamDic.h"
#import "BaseParam.h"
@implementation BaseParamDic

+(NSMutableDictionary *)baseParam
{
    BaseParam *baseParma = [BaseParam sharedManager];
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc] init];
    NSUInteger uid = [YMInfoCenter userID];
    [paramDic setValue:[NSNumber numberWithUnsignedInteger:uid] forKey:@"uid"];
    [paramDic setValue:baseParma.IMEI forKey:@"IMEI"];
    [paramDic setValue:baseParma.packName forKey:@"packName"];
    [paramDic setValue:baseParma.appkey forKey:@"appkey"];
    [paramDic setValue:baseParma.channel forKey:@"channel"];
    [paramDic setValue:baseParma.net_t forKey:@"net_t"];
    [paramDic setValue:baseParma.appVer forKey:@"appVer"];
    [paramDic setValue:baseParma.mac forKey:@"mac"];
    [paramDic setValue:baseParma.idfa forKey:@"idfa"];
    [paramDic setValue:baseParma.Lu forKey:@"Lu"];
    [paramDic setValue:baseParma.os forKey:@"os"];
    [paramDic setValue:baseParma.platform forKey:@"platform"];
    
    return paramDic;

}
@end
