//
//  UserAccount.h
//  MYDYHelper
//
//  Created by apple on 2020/4/15.
//

#import <Foundation/Foundation.h>

@interface UserDeviceModel : NSObject
@property (nonatomic,copy)NSString *platform;
@property (nonatomic,copy)NSString *timestamp;
@property (nonatomic,copy)NSString *openudid;
@property (nonatomic,copy)NSString *idfa;
@property (nonatomic,copy)NSString *idfv;
@property (nonatomic,copy)NSString *location;
@property (nonatomic,copy)NSString *user_name;
@property (nonatomic,copy)NSString *iphone_version;
@end

@interface UserTaskModel : NSObject
@property (nonatomic,copy)NSString *type;
@property (nonatomic,copy)NSString *userid;
@end

@interface UserModel : NSObject
@property (nonatomic,strong)UserDeviceModel *mobile_info;
@property (nonatomic,strong)UserTaskModel *task_info;
@end




@interface UserAccount : NSObject
@property (nonatomic,strong)NSArray *task;
@property (nonatomic,copy)NSString *refresh_code;
@property (nonatomic,copy)NSString *status_code;
@property (nonatomic,copy)NSString *version_code;

@end


