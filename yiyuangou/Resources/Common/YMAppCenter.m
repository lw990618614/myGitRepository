//
//  YMAppCenter.m
//  mobi
//
//  Created by Simon on 8/28/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import "YMAppCenter.h"
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


+(NSString*)getMacAddress{
    NSString* mac=    getMacAddress("en0");
    return mac?mac:@"";
}

@end
