//
//  UserAccount.m
//  MYDYHelper
//
//  Created by apple on 2020/4/15.
//

#import "UserAccount.h"

@implementation UserModel
@end
@implementation UserDeviceModel
@end
@implementation UserTaskModel
@end

@implementation UserAccount
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"task":@"UserModel",
             };
    
}
@end
