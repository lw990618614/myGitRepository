//
//  DYDeviceModel.h
//  WeChatDemoDylib
//
//  Created by apple on 2020/1/16.
//  Copyright © 2020 LogicEDU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DYDeviceModel : NSObject

@property (nonatomic, copy) NSString * BSSID;
@property (nonatomic, copy) NSString * SSID;
@property (nonatomic, copy) NSString * openudid;
@property (nonatomic, copy) NSString * TotalDiskSize;
@property (nonatomic, copy) NSString * batteryLevel;
@property (nonatomic, copy) NSString * idfa;
@property (nonatomic, copy) NSString * idfv;
@property (nonatomic, copy) NSString * iphone_version;
@property (nonatomic, copy) NSString * location;
@property (nonatomic, copy) NSString * platform;
@property (nonatomic, copy) NSString * timestamp;
@property (nonatomic, copy) NSString * usedMemory;
@property (nonatomic, copy) NSString * user_name;

@end

NS_ASSUME_NONNULL_END
