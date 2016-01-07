//
//  AppDelegate.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "AppDelegate.h"
#import "YMTabBarController.h"
//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKConnector/ShareSDKConnector.h>
//#import "WXApi.h"
//#import "WXApiManager.h"
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//#import "WeiboSDK.h"//微信SDK头文件
#import "WXApi.h"
#import "WXApiManager.h"
#import "UMSocialData.h"
#import "UMSocialConfig.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSnsPlatformManager.h"
#import "UMSocialSnsService.h"
//#import "UMessage.h"
//#import "UMSocialSinaSSOHandler.h"
#import "UMSocialSinaHandler.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    _mapManager = [[BMKMapManager alloc]init];
    
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
//    BOOL ret = [_mapManager start:BaiDuKey  generalDelegate:nil];
//    if (!ret) {
//        NSLog(@"manager start failed!");
//    }
    self.window.rootViewController = [[YMTabBarController alloc] init];
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    //友盟分享
    [UMSocialData setAppKey:UMKey];
    //友盟推送
//    [UMessage startWithAppkey:UMKey launchOptions:launchOptions];
    [self umConfig];
    //友盟推送配置
//    [self umengPushCongfig];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
}
-(void) umConfig
{
    //友盟分享
    [UMSocialQQHandler setQQWithAppId:QQ_Key appKey:QQ_sercert url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:WX_ID appSecret:WX_SERCER url:@"http://www.umeng.com/social"];
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WeiBoKey RedirectURL:WeiBoUrl];
    [UMSocialSinaHandler openSSOWithRedirectURL:WeiBoUrl];

    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession]];
    
    //友盟统计
    [MobClick setLogEnabled:NO];
    //错误日志分析
    [MobClick startWithAppkey:UMKey reportPolicy:BATCH   channelId:CHANNEL];
    //设置version标示
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

}
//友盟推送配置
//-(void) umengPushCongfig
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
//    if([SYSTEMVERSION floatValue] >= 8.0)
//    {
//        //register remoteNotification types （iOS 8.0及其以上版本）
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"Accept";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//        
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"Reject";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        
//        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//        categorys.identifier = @"category1";//这组动作的唯一标示
//        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        
//        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
//                                                                                     categories:[NSSet setWithObject:categorys]];
//        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
//        
//    } else{
//        //register remoteNotification types (iOS 8.0以下)
//        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//         |UIRemoteNotificationTypeSound
//         |UIRemoteNotificationTypeAlert];
//    }
//#else
//    
//    //register remoteNotification types (iOS 8.0以下)
//    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
//     |UIRemoteNotificationTypeSound
//     |UIRemoteNotificationTypeAlert];
//    
//#endif
//    //for log
//    [UMessage setLogEnabled:YES];
//    
//}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [self handleAppCallBack:url];
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [self handleAppCallBack:url];

}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [self handleAppCallBack:url];

}
#pragma mark ----外部应用回调------
-(BOOL) handleAppCallBack:(NSURL *)url
{

    [UMSocialSnsService handleOpenURL:url];
    return YES;
}
#pragma mark  ----- 友盟推送------
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSLog(@"deviceToken ====%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
//                  stringByReplacingOccurrencesOfString: @">" withString: @""]
//                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
//    [UMessage registerDeviceToken:deviceToken];
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [UMessage didReceiveRemoteNotification:userInfo];
//}
@end
