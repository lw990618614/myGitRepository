//
//  DeviceModel.h
//  WeChatDemoDylib
//
//  Created by apple on 2020/1/16.
//  Copyright © 2020 LogicEDU. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface DeviceInfo : NSObject
@property (nonatomic,copy)NSString *platform;
@property (nonatomic,copy)NSString *timestamp;
@property (nonatomic,copy)NSString *openudid;
@property (nonatomic,copy)NSString *idfa;
@property (nonatomic,copy)NSString *idfv;
@property (nonatomic,copy)NSString *location;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *iphone_version;
@end

@interface TaskInfo : NSObject
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *userid;
@end

@interface DeviceModel : NSObject
@property (nonatomic,copy)NSString *refresh_code;
@property (nonatomic,copy)NSString *status_code;
@property (nonatomic,copy)NSString *version_code;
@property (nonatomic,strong)DeviceInfo *mobile_info;
@property (nonatomic,strong)TaskInfo *task_info;

@end

NS_ASSUME_NONNULL_END
