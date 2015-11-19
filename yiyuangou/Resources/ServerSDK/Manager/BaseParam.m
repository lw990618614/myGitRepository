//
//  BaseParam.m
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "BaseParam.h"
#import "YMInfoCenter.h"
#import "YMAppCenter.h"
@implementation BaseParam
-(instancetype)init{
    if (self = [super init]) {
        NSString *netWorkType = [self getNetWorkType];
        self.uid = [YMInfoCenter userID];
//        self.uid = @1;
//        self.IMEI = [YMAppCenter getIMEI];
        self.IMEI = @"";
        self.packName = PACKNAME;
        self.appkey = APPKEY;
        self.channel = CHANNEL;
        self.net_t = netWorkType;
        self.Lu = @"1";
        self.appVer = @"1.0";
        self.mac = [YMAppCenter getMacAddress];
        self.idfa = [YMAppCenter advertisingID];
        self.os = SYSTEMVERSION;
        self.platform = @2;
    }
    return self;
}

+(instancetype)param{
    return [[self alloc] init];
}
-(NSString *) getNetWorkType
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *subviews = [[[app valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetworkItemView = nil;
    
    for (id subview in subviews) {
        if([subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            dataNetworkItemView = subview;
            break;
        }
    }
    NSNumber * num = [dataNetworkItemView valueForKey:@"dataNetworkType"];
    int n = [num intValue];
    if(n == 0)
    {
        return @"None"
        ;
    }
    else if( n == 1 || n == 2)
        return @"Mobile";
    else
        return @"Wifi";
    return @"Other";
}
+(id)sharedManager
{
    static BaseParam *baseParam = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        baseParam = [[self alloc] init];
    });
return baseParam;
}

@end
