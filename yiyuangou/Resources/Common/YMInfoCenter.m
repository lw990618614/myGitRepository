//
//  YMInfoCenter.m
//  mobi
//
//  Created by Simon on 9/21/15.
//  Copyright © 2015 mobi. All rights reserved.
//

#import "YMInfoCenter.h"


#define lastClockin @"lastclockin"

@implementation YMInfoCenter


+ (id)sharedManager {
    static YMInfoCenter *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        //        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
        self.mainUser=[[YMUser alloc]init];
    }
    return self;
}

- (NSUInteger)getUserID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSNumber       *usrID = [ud valueForKey:USRID];
    if (usrID) {
        return [usrID integerValue];
    }
    if (self.mainUser.YMUserID) {
        return self.mainUser.YMUserID;
    }else{
//        return 15;
//        return 9;
        return 0;
    }
}

+ (NSUInteger) userID{
    return [[self sharedManager] getUserID];
}


- (BOOL)checkClockin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    NSDate *lastclockin=(NSDate*)[defaults objectForKey:lastClockin];
    NSDate *now=[NSDate new];
    if (
        (int)(([now timeIntervalSince1970] + timezoneFix)/(24*3600)) -
        (int)(([lastclockin timeIntervalSince1970] + timezoneFix)/(24*3600))
        == 0)
    {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL) updateLastClockin{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDate *cdate=[NSDate new];
    [defaults setObject:cdate forKey:lastClockin];
    [defaults synchronize];
    return YES;
    
}

- (void)saveUserID{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:[NSNumber numberWithInteger:self.mainUser.YMUserID] forKey:USRID];
    [ud synchronize];
}

@end
