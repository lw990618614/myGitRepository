//
//  YMAppCenter.m
//  mobi
//
//  Created by Simon on 8/28/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import "YMAppCenter.h"
#import <AdSupport/ASIdentifierManager.h> 
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#include <objc/runtime.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <errno.h>


@implementation YMAppCenter

+ (id)sharedManager {
    static YMAppCenter *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
//        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

+ (NSArray*)allInstalledApps{
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray* apps = [workspace performSelector:@selector(allInstalledApplications) withObject:0];
//    NSLog(@"apps: %@", apps);
    return apps;

}

+ (NSArray*)allInstalledUserApps{
    NSArray *apps=[YMAppCenter allInstalledApps];
    NSMutableArray *rtnArray=[[NSMutableArray alloc]init];
    for (id app in apps) {
        NSString *teamid=[app valueForKey:@"_teamID"];
        NSString *bid=[app valueForKey:@"applicationIdentifier"];
        if (![teamid isEqualToString:@"0000000000"] && ![bid hasPrefix:@"com.apple"]){
            [rtnArray addObject:app];
        }
    }
    return rtnArray;
}

+ (NSArray*)allInstalledAppsBundleID{
    NSArray *allApps=[self allInstalledApps];
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (id app in allApps) {
        
        NSString* appid = [app valueForKey:@"applicationIdentifier"];
        NSString* apppath =[app valueForKey:@"resourcesDirectoryURL"];
        NSLog(@"apppath:%@",apppath);
        if (![appid hasPrefix:@"com.apple"]) {
            
            [array addObject:appid];
        }
    }
    
    return array;
}


+ (NSArray*)allInstalledUserAppsBundleID{
    NSArray *apps=[YMAppCenter allInstalledUserApps];
    NSMutableArray *rtnArray=[[NSMutableArray alloc]init];
    for (id app in apps) {
        NSString *appid=[app valueForKey:@"applicationIdentifier"];
        [rtnArray addObject:appid];
    }
    return rtnArray;
    
}


- (BOOL) appIsInstalled:(NSString *)bundleID{
    id tmpID= [self appInstalled:bundleID];
    if (tmpID) {
        return YES;
    }else{
        return NO;
    }
}

- (id)appInstalled:(NSString *)bundleID{
    
    NSArray *appArray=[YMAppCenter allInstalledUserApps];
    
    id installedid = nil;
    for (id app  in appArray) {
        NSString *currentAppID=[app valueForKey:@"applicationIdentifier"];
        if ([currentAppID isEqualToString:bundleID]) {
            installedid = app;
        }
    }
    return installedid;
}

+ (NSString*)advertisingID{
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_6_0) {
        return @"";
    }
    
//        NSString *idfaString = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
    
    ASIdentifierManager* manager = [ASIdentifierManager sharedManager];
    NSString* idfa = [[manager advertisingIdentifier] UUIDString];
    if (!idfa) {
        sleep(100);
        manager = [ASIdentifierManager sharedManager];
        idfa = [[manager advertisingIdentifier] UUIDString];
    }
    
    
    return idfa?idfa:@"";
}

+(double)systemRunningTime{
    return [[NSProcessInfo processInfo] systemUptime] / 3600.0;
}

+ (NSArray *)runningProcesses{
    int mib[4] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    size_t miblen = 4;
    
    size_t size;
    int st = sysctl(mib, miblen, NULL, &size, NULL, 0);
    
    struct kinfo_proc * process = NULL;
    struct kinfo_proc * newprocess = NULL;
    
    do {
        
        size += size / 10;
        newprocess = realloc(process, size);
        
        if (!newprocess){
            
            if (process){
                free(process);
            }
            
            return nil;
        }
        
        process = newprocess;
        st = sysctl(mib, miblen, process, &size, NULL, 0);
        
    } while (st == -1 && errno == ENOMEM);
    
    if (st == 0){
        
        if (size % sizeof(struct kinfo_proc) == 0){
            int nprocess = size / sizeof(struct kinfo_proc);
            
            if (nprocess){
                
                NSMutableArray * array = [[NSMutableArray alloc] init];
                
                for (int i = nprocess - 1; i >= 0; i--){
                    
                    NSString * processID = [[NSString alloc] initWithFormat:@"%d", process[i].kp_proc.p_pid];
                    NSString * processName = [[NSString alloc] initWithFormat:@"%s", process[i].kp_proc.p_comm];
                    
                    
                    NSDictionary * dict = [[NSDictionary alloc] initWithObjects:[NSArray arrayWithObjects:processID, processName, nil]
                                                                        forKeys:[NSArray arrayWithObjects:@"ProcessID", @"ProcessName", nil]];
                    [array addObject:dict];
                }
                
                free(process);
                return array;// autorelease];
            }
        }
    }
    
    return nil;
}

+ (NSString*)getRouterInfo: (NSString*) key{
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil) {
        CFDictionaryRef myDict = CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict != nil) {
            NSDictionary *dict = (NSDictionary*)CFBridgingRelease(myDict);
            NSString *value = [[dict valueForKey:key] description];
            return value;
        }
    }
    
    return nil;
}

+ (NSString*)getLocalIP{
    //
    struct ifaddrs *myaddrs, *ifa;
    void *in_addr;
    char buf[64];
    
    if(getifaddrs(&myaddrs) != 0){
        //perror("getifaddrs");
        //exit(1);
        return @"0.0.0.0";
    }
    
    for (ifa = myaddrs; ifa != NULL; ifa = ifa->ifa_next)
    {
        if (ifa->ifa_addr == NULL)
            continue;
        if (!(ifa->ifa_flags & IFF_UP))
            continue;
        
        if (ifa->ifa_addr->sa_family == AF_INET)  {
            struct sockaddr_in *s4 = (struct sockaddr_in *)ifa->ifa_addr;
            in_addr = &s4->sin_addr;
            
            if (strcmp(ifa->ifa_name, "en0") == 0 && inet_ntop(ifa->ifa_addr->sa_family, in_addr, buf, sizeof(buf))) {
                freeifaddrs(myaddrs);
                return [NSString stringWithUTF8String:buf];
            }
        }
        
        
    }
    
    freeifaddrs(myaddrs);
    return @"0.0.0.0";
}

+(NSString*) getCarrierName{
    NSBundle* bundle = [NSBundle bundleWithPath:@"/System/Library/Frameworks/CoreTelephony.framework"];
    Class class = NSClassFromString(@"CTTelephonyNetworkInfo");
    CTTelephonyNetworkInfo* info = [[class alloc] init];
    if (bundle && class && info) {
        CTCarrier* carrier = [info subscriberCellularProvider];
        return [carrier carrierName];
    }
    return nil;
}

+(NSString*) deviceModelString{
    size_t size;
    sysctlbyname("hw.machine", 0, &size, 0, 0);
    void* info = malloc(size);
    sysctlbyname("hw.machine", info, &size, 0, 0);
    NSString* model = [NSString stringWithUTF8String:info];
    free(info);
    return model;
}

+(NSNumber*) batteryCapacityLeft{
    NSNumber *batteryPercentage = nil;
    NSArray *statusBarSubviews = [[[[[UIApplication sharedApplication] valueForKey:@"_statusBar"] subviews] lastObject] subviews];
    for (id subview in statusBarSubviews) {
        if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarBatteryItemView")]) {
            batteryPercentage = [subview valueForKey:@"_capacity"];
            break;
        }
    }
    return batteryPercentage;
}

+(void) getDiskSpace: (long long*) total Left:(long long*) left{
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:[paths lastObject] error: &error];
    
    if (dictionary) {
        if (left) {
            *left = [[dictionary objectForKey: NSFileSystemFreeSize] longLongValue];
        }
        if (total) {
            *total = [[dictionary objectForKey: NSFileSystemSize] longLongValue];
        }
    } else {
        NSLog(@"Error Obtaining File System Info: Domain = %@, Code = %d", [error domain], [error code]);
    }
}

+(char) isEnablePush{
    UIApplication* app = [UIApplication sharedApplication];
    if ([app respondsToSelector:@selector(currentUserNotificationSettings)]) {
        id settings = [app performSelector:@selector(currentUserNotificationSettings) withObject:nil];
        UIRemoteNotificationType types = (UIRemoteNotificationType)[settings performSelector:@selector(types) withObject:0];
        return (types >> 2) & 1;
    } else {
        UIRemoteNotificationType types = [app enabledRemoteNotificationTypes];
        return (types >> 2) & 1;
    }
}

+(NSString*)getIMEI{
    NSString* imei=getIMEI();
    return imei?imei:@"imei";
}

+(NSString*)getMacAddress{
    NSString* mac=    getMacAddress("en0");
    return mac?mac:@"";
}

@end
