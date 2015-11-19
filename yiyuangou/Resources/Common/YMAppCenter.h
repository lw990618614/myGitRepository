//
//  YMAppCenter.h
//  mobi
//
//  Created by Simon on 8/28/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YMProcessManager.h"
#import "udidhelper.h"

@interface YMAppCenter : NSObject

+ (id)sharedManager;

/**
 *  获取所有已经安装的应用
 *
 *  @return LSApplicationProxy对象的数组.
 */
+ (NSArray*)allInstalledApps;

/**
 *  获取所有的用户应用
 *
 *  @return LSApplicationProxy 对象的数组
 */
+ (NSArray*)allInstalledUserApps;

/**
 *  所有已经安装应用的 Bundle ID
 *
 *  @return 所有已经安装应用的bundle ID 数组
 */
+ (NSArray*)allInstalledAppsBundleID;

/**
 *  所有已经安装用户应用的 Bundle ID
 *
 *  @return 所有已经安装用户应用的bundle ID 数组
 */
+ (NSArray*)allInstalledUserAppsBundleID;

- (void)appIsRunning:(NSString*)bundleID;

/**
 *  检查对应bundle ID的应用是否安装
 *
 *  @param bundleID 要检查应用的bundle id
 *
 *  @return BOOL YES, 应用已经安装 ; NO->未安装
 */
- (BOOL) appIsInstalled:(NSString*)bundleID;

/**
 *  获取 bundle id 对应的应用信息
 *  如果应用未安装, 返回nil. 否则, 返回一个LSApplicationProxy 对象
 *
 *
 *  @param bundleID 要获取信息的bundle id
 *
 *  @return LSApplicationProxy的对象
 */
- (id) appInstalled:(NSString*)bundleID;

/**
 *  获取广告主ID.
 *
 *  @return 广告主 ID
 */
+ (NSString*)advertisingID;

+ (double)systemRunningTime;
+ (NSArray *)runningProcesses;


+ (NSString*)getRouterInfo: (NSString*) key;
+ (NSString*)getLocalIP;
+(NSString*) getCarrierName;
+(NSString*) deviceModelString;
+(NSNumber*) batteryCapacityLeft;
+(void) getDiskSpace: (long long*) total Left:(long long*) left;
+(char) isEnablePush;

+ (NSString*) getIMEI;

+ (NSString*) getMacAddress;

+ (NSDictionary*)clientInfo;

+ (NSData*)clientInfoData;

@end
