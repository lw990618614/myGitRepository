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

        return 0;
    }
}
-(NSString *)getAccount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString       *account = [ud valueForKey:Account];
    return account;
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

-(void)saveUserAccount
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:self.mainUser.YMAccount forKey:Account];
    [ud synchronize];
}

//保存数据
//+void)savestr:(NSString *)str forkey:(NSString *)key
//{
//     NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:str  forKey:key];
//    [ud synchronize];
//}
+(void)savestr:(NSString *)str forkey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:str  forKey:key];
    [ud synchronize];
}
+(NSString *)getforkey:(NSString *)key
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
   return  [ud objectForKey:key];
}
-(NSString *)mobile:(NSString *)key
{
   NSString *vaule = [[self class] getforkey:key];
    if (![vaule isValid]) {
        vaule =  [self.mainUser.YMUserMobile isValid]?self.mainUser.YMUserMobile:self.mainUser.YMAccount;
        if (![vaule isValidPhoneNumber]) {
            vaule = @"";
        }
    }
    return vaule;
}
@end
