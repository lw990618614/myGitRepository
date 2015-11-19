//
//  LoginManager.m
//  yiyuangou
//
//  Created by roen on 15/10/23.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "LoginManager.h"
#import "YMLoginResult.h"
#import "YMLoginParam.h"
#import "YMRegisterParam.h"

#import "YMVerfyResult.h"
@implementation LoginManager
SYNTHESIZE_SINGLETON_FOR_CLASS(LoginManager)
+(LoginManager *)sharedManager
{
    return [LoginManager sharedLoginManager];
}
-(void)LoginStatusWithModle:(YMLoginModel *)model completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/sysuser/login"];
    YMLoginParam *param = [[YMLoginParam alloc] init];
    param.mobile = model.mobile;
    param.password = model.password;
    param.flag = model.flag;
    param.sname = model.sname;
    param.loginName = model.loginName;
    param.address = model.address;
    param.IP = model.IP;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMLoginResult *r = result;
        if ([r isSuceess]) {
            YMLoginResult *re = [[YMLoginResult alloc] init];
            re =  [YMLoginResult objectWithKeyValues:r.data];
            if (block) {
                block(re,r.code,r.msg);
            }
        }else if([r isOther]){
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        
    }];
}
-(void)registerStatusWithMobile:(NSString *)mobile flag:(NSString *)flag completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/user/verificationcode"];
    YMRegisterParam *param = [[YMRegisterParam alloc] init];
    param.mobile = mobile;
    param.flag  = flag;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        YMVerfyResult *r = result;
        if ([r isSuceess]) {
            YMVerfyResult *re = [[YMVerfyResult alloc] init];
            re =  [YMVerfyResult objectWithKeyValues:r.data];

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
-(void)checkMobileStatusWithMobile:(NSString *)mobile verfy:(NSString *)test completion:(ManagerBlock)block
{
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",BaseServerURL,@"/user/verificationcode"];
    YMRegisterParam *param = [[YMRegisterParam alloc] init];
    param.mobile = mobile;
    [YMBaseHttpTool POST:urlStr params:[param keyValues] success:^(id result) {
        BaseResult *r = result;
        if ([r isSuceess]) {
            
            if (block) {
                block(r,r.code,r.msg);
            }
        }else{
            block(nil,r.code,r.msg);
        }
    } failure:^(NSError *error) {
        block(nil,C100007,@"网络异常");

    }];

}

@end
