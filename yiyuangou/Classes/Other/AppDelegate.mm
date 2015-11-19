//
//  AppDelegate.m
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "AppDelegate.h"
#import "YMTabBarController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
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
    BOOL ret = [_mapManager start:BaiDuKey  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    self.window.rootViewController = [[YMTabBarController alloc] init];
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    [UMSocialData setAppKey:UMKey];
    [self umConfig];
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
    [UMSocialQQHandler setQQWithAppId:QQ_Key appKey:QQ_sercert url:@"http://www.umeng.com/social"];
    [UMSocialWechatHandler setWXAppId:WX_ID appSecret:WX_SERCER url:@"http://www.umeng.com/social"];
//    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WeiBoKey RedirectURL:WeiBoUrl];
    [UMSocialSinaHandler openSSOWithRedirectURL:WeiBoUrl];

    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession]];
    
    [MobClick setLogEnabled:YES];
    //错误日志分析
    [MobClick startWithAppkey:UMKey reportPolicy:BATCH   channelId:CHANNEL];
    //设置version标示
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];

}
-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    if ([url.absoluteString hasPrefix:@"http://99duobao"]) {
        NSLog(@"chulai");
        return YES;
    }
    return [self handleAppCallBack:url];
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    if ([url.absoluteString hasPrefix:@"http://99duobao"]) {
        NSLog(@"chulai");
        return YES;
    }

    return [self handleAppCallBack:url];

}
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.absoluteString hasPrefix:@"http://99duobao"]) {
        NSLog(@"chulai");
        return YES;
    }

    return [self handleAppCallBack:url];

}
#pragma mark ----外部应用回调------
-(BOOL) handleAppCallBack:(NSURL *)url
{

    [UMSocialSnsService handleOpenURL:url];
    return YES;
}

@end
