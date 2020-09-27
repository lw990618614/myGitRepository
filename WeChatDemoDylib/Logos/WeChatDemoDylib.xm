#import<UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#include <CoreFoundation/CFUUID.h>
#include <substrate.h>
#import <sys/utsname.h>
#import <dlfcn.h>

#import "DYCommeObj.h"

#include <err.h>
#include <pwd.h>
#include <grp.h>
#include <sys/stat.h>
#include <sys/sysctl.h>
#include <fcntl.h>
#include <dirent.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <string.h>
#include <objc/message.h>

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
//
//int a =10;
//
//
//%hook AppDelegate
//
//- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2{
//
//    [[DYCommeObj sharedQueue] delayUpCookieToSevers];
//
//    return %orig;
//
//}
////
//%end
////
//主播相关信息，以及橱窗号
%hook TTNetworkManagerChromium

- (id)requestForJSONWithURL_:(id)arg1 params:(id)arg2 method:(id)arg3 needCommonParams:(_Bool)arg4 headerField:(id)arg5 requestSerializer:(Class)arg6 responseSerializer:(Class)arg7 autoResume:(_Bool)arg8 verifyRequest:(_Bool)arg9 isCustomizedCookie:(_Bool)arg10 callback:(id)arg11 callbackWithResponse:(void(^)(id,id))arg12 dispatch_queue:(id)arg13{
    
    NSLog(@"GGGGGGGGGG %@ \n %@",arg1,arg2);
    NSString *url = arg1;
    
    id myCallBackzbb = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"10"};
        //        [[DYGetDataManager sharedQueue] configDataWithDic:resu];
    };
    
    
    
    id myCallBackUserInfo = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"1"};
        //        [[DYGetDataManager sharedQueue] configDataWithDic:resu];
    };
    
    id myCallBackUserPost = ^(id block_arg1,NSDictionary * block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"2"};
        
        //        NSLog(@"WXOMTAO  orig =  %@,%@，%@",dic[@"total_favorited"],dic[@"following_count"],dic[@"mplatform_followers_count"] );
        //        if ([block_arg2[@"has_more"] intValue] == 1) {
        //            [DYGetDataManager sharedQueue].hasMore = YES;
        //        }else{
        //            [DYGetDataManager sharedQueue].hasMore = NO;
        //        }
        //
        //        [[DYGetDataManager sharedQueue] configDataWithDic:resu];
    };
    
    
    id myCallBackUserFavorite = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        //        if(block_arg2){
        //            resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"3"};
        //            [[DYGetDataManager sharedQueue] configDataWithDic:resu];
        //        }
        
    };
    
    
    
    id myCallBackUserForward = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        //        if(block_arg2){
        //            resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"4"};
        //            [[DYGetDataManager sharedQueue] configDataWithDic:resu];
        //        }
        
    };
    
    
    
    
    //        if([url isEqualToString :@"https://aweme.snssdk.com/aweme/v1/forward/list/"]||[url isEqualToString :@"https://aweme.snssdk.com/aweme/v1/user/profile/other/"]||[url isEqualToString :@"https://aweme.snssdk.com/aweme/v1/aweme/post/"]||[url isEqualToString :@"https://aweme.snssdk.com/aweme/v1/aweme/favorite/"]||[url isEqualToString :@"https://aweme.snssdk.com/aweme/v1/promotion/user/promotion/list/"]||[url containsString :@"https://mon.snssdk.com/monitor/collect/"]){
    if([url containsString :@"https://webcast.amemv.com/webcast/ranklist/hot/"]){
        return  %orig(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackzbb,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/user/profile/other/"]){
        return  %orig(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserInfo,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/forward/list/"]){
        return  %orig(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserForward,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/aweme/post/"]){
        return  %orig(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserPost,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/aweme/favorite/"]){
        return  %orig(arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserFavorite,arg13);
    }else{
        return %orig;
    }
    
}

%end

%hook TTInstallIDManager
-(void)setDeviceID:(id)str{
    return %orig;
}

-(void)setInstallID:(id)str{
    return %orig;
}
%end



%hook AWENetworkService
+ (id)_requestWithURLString:(id)arg1 params:(id)arg2 method:(id)arg3 needCommonParams:(_Bool)arg4 header:(id)arg5 modelClass:(Class)arg6 targetAttributes:(id)arg7 requestSerializer:(Class)arg8 responseSerializer:(Class)arg9 responseBlock:(id)arg10 enableCache:(_Bool)arg11 completionBlock:(id)arg12{
    %log;
    if([arg2 isKindOfClass:[NSDictionary class]]){
        NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
        NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
        
        if  (!dataDictionary){
            dataDictionary = [[NSMutableDictionary alloc]  init];
        }
        NSString *userID =arg2[@"user_id"];
        NSString *sec_user_id =arg2[@"sec_user_id"];
        if(userID.length && sec_user_id.length){
            NSDictionary  *safadic = [NSDictionary dictionaryWithObject:userID forKey:sec_user_id];
            [dataDictionary setValue:safadic forKey:userID];
            BOOL  sucess =   [dataDictionary writeToFile:filePatch atomically:YES];
        }
    }
    return %orig;
    
}

%end

%hook TTHttpRequestChromium
//上层函数 包括 [TTDefaultHTTPRequestSerializer buildRequestHeaders:parameters:]
- (void)setAllHTTPHeaderFields:(id)arg1{ //第一次就能产生两个值 Cronet";
    //"x-ss-stub" = 422D5FF0F125697003CD63A017229555;"x-tt-trace-id" = "00-974b0094dacc14ea7fd97df6a4d2e532-974b0094dacc14ea-01";
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    
    if  (!dataDictionary){
        dataDictionary = [[NSMutableDictionary alloc]  init];
    }
    if([arg1 isKindOfClass:[NSDictionary class]]){
        [dataDictionary addEntriesFromDictionary:arg1];
        BOOL  sucess =   [dataDictionary writeToFile:filePatch atomically:YES];
        if(sucess == YES){
            NSLog(@"header的基本数据些人成功");
        }else{
            NSLog(@"header的基本数据些人失败");
            
        }
    }
    //写入文件
    %log;
    return %orig;
}

- (void)setValue:(id)arg1 forHTTPHeaderField:(id)arg2{
    %log;
    return %orig;
    
}
- (id)allHTTPHeaderFields{
    %log;
    NSLog(@"headerallHTTPHeaderFields = %@",%orig);

    return %orig;
}

%end


%hook IESAntiSpam
- (id)sgm_encryptWithURL:(id)arg1 msg:(id)arg2{
    %log;
    
    NSLog(@"IESAntiSpam  encryResult agg1 = %@ arg2 = %@  result =%@ " ,arg1,arg2,%orig);
    
    id result =%orig;
    
    NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
    NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
    
    if  (!dataDictionary){
        dataDictionary = [[NSMutableDictionary alloc]  init];
    }
    if([result isKindOfClass:[NSDictionary class]]){
        [dataDictionary addEntriesFromDictionary:result];
        NSURL *url =arg1;
        NSString  *urlstirng  = url.absoluteString;
        
        if([arg1 isKindOfClass:[NSURL class]]){
            if([urlstirng containsString:@"https://aweme-eagle-lq.snssdk.com/aweme/v1/user/"]){
                NSLog(@"IESAntiSpam  dddddyResult agg1 = %@ arg2 = %@  result =%@ " ,arg1,arg2,result);
                
                NSString * m_c2cNativeUrl2 = [urlstirng substringFromIndex:@"https://aweme-eagle-lq.snssdk.com/aweme/v1/user/?".length];
                NSArray  *dataarray = [m_c2cNativeUrl2 componentsSeparatedByString:@"&"];
                NSMutableArray *urlDic = [NSMutableArray array];
                for (NSString *string in dataarray) {
                    NSArray  *dicarray = [string componentsSeparatedByString:@"="];
                    if (dicarray.count ==2) {
                        [urlDic setValue:dicarray[1] forKey:dicarray[0]];
                    }
                }
                [dataDictionary setValue:urlDic forKey:@"userINfo_msg"];
            }
            BOOL  sucess =   [dataDictionary writeToFile:filePatch atomically:YES];
            if(sucess ==YES){
                NSLog(@"用户基本信息 写入成功");
                
            }else{
                NSLog(@"用户基本信息 写入失败");
            }
            
        }
    }
    
    //写入文件
    
    return result;
}

%end


%hook BDLogOpenUDID
+ (NSString*) value{
    //    NSLog(@"BDLogOpenUDID  cccccopenudidi = %@" ,%orig);//115c8d003f0c84fda6e1fd1dc01ea1727b163010
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"BDLogOpenUDID  cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        //        return nil;
        return %orig;
    }
    
}
+ (id)_getDictFromPasteboard:(id)arg1{
    return  [NSMutableDictionary dictionary];
}

+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
    return ;
}
%end


%hook TTInstallOpenUDID
+ (NSString*) value{
    //    NSLog(@"TTInstallOpenUDID  cccccopenudidi = %@" ,%orig);//115c8d003f0c84fda6e1fd1dc01ea1727b163010
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"TTInstallOpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        //        return nil;
        return %orig;
    }
    
}
+ (id)_getDictFromPasteboard:(id)arg1{
    return  [NSMutableDictionary new];
}

+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
    return ;
}
%end

%hook UMANOpenUDID
+ (NSString*) value{
    //    NSLog(@"UMANOpenUDID cccccopenudidi = %@" ,%orig);//115c8d003f0c84fda6e1fd1dc01ea1727b163010
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"UMANOpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        //        return nil;
        return %orig;
    }
    
}
+ (id)_getDictFromPasteboard:(id)arg1{
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
    return ;
}
%end

%hook UTDIDOpenUDID
+ (NSString*) value{
    NSLog(@"UTDIDOpenUDID cccccopenudidi = %@" ,%orig);//XhbYrawERI8DADdxT7pq5P8V
    return %orig;
}

+ (id)_getDictFromPasteboard:(id)arg1{
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
    return ;
}
%end

%hook OpenUDID
+ (NSString*) value{
    %log;
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"OpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];
    }else{
        //        return nil;
        return %orig;
    }
    
}
//+ (NSString*) valueWithError:(NSError **)error {
//      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    NSLog(@"openudi = %@  ",%orig);
//
//    return %orig;
//
//}
+ (id)_getDictFromPasteboard:(id)arg1{
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

+ (void) _setDict:(id)dict forPasteboard:(id)pboard {
    return ;
}
%end
//
%hook ASIdentifierManager
-(NSUUID *) advertisingIdentifier//设备信息idfa
{
    //    return [[NSUUID alloc] initWithUUIDString:@"047FF9B3-CB7A-4863-9A13-AB62936A83F4"];
    //    return [[NSUUID alloc] initWithUUIDString:@"104FF9B3-AB04-8305-9A44-AB62936A8434"];
    if([[DYCommeObj sharedQueue] idfa]){
        NSLog(@"CCCCCCCCC advertisingIdentifier = %@" ,[[DYCommeObj sharedQueue] idfa]);
        
        return [[DYCommeObj sharedQueue] idfa];
    }else{
        return %orig;
    }
    
}
%end

%hook UIDevice
+ (id)btd_idfaString{
    //    NSLog(@"CCCCCCCCC btd_idfaString = %@" ,%orig);
    //    return %orig;
    
    if([[DYCommeObj sharedQueue] idfa]){
        NSLog(@"CCCCCCCCC identifierForVendor = %@" ,[[DYCommeObj sharedQueue] idfa]);
        
        return [[DYCommeObj sharedQueue] idfa];
    }else{
        return %orig;
    }
}

-(NSUUID *) identifierForVendor//设备信息idfv
{
    //    return [[NSUUID alloc] initWithUUIDString:@"0286C82F-7BA3-444F-AB3D-D7B7E2CCB37"];
    //    NSLog(@"CCCCCCCCC identifierForVendor = %@" ,%orig);
    if([[DYCommeObj sharedQueue] idfv]){
        NSLog(@"CCCCCCCCC identifierForVendor = %@" ,[[DYCommeObj sharedQueue] idfv]);
        
        return [[DYCommeObj sharedQueue] idfv];
    }else{
        NSLog(@"idfv error  nil = %@" ,[[DYCommeObj sharedQueue] idfv]);
        
        return %orig;
    }
}

+ (id)sgm_data_acquisition_getIPAddress{
    NSLog(@"UIDevice sgm_data_acquisition_getIPAddress = %@" ,%orig);
    return %orig;
}

+ (_Bool)sgm_data_acquisition_insertSIMCard{
    NSLog(@"UIDevice sgm_data_acquisition_insertSIMCard = %d" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_getIPAddress:(_Bool)arg1{
    NSLog(@"UIDevice sgm_data_acquisition_getIPAddress = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_wifiIPAddress{
    NSLog(@"UIDevice sgm_data_acquisition_wifiIPAddress = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_machineName{
    NSLog(@"UIDevice sgm_data_acquisition_machineName = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_machineModelName{
    NSLog(@"UIDevice sgm_data_acquisition_machineModelName = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_machineModel{
    NSLog(@"UIDevice sgm_data_acquisition_machineModel = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_systemName{
    NSLog(@"UIDevice sgm_data_acquisition_systemName = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_systemVersion{
    NSLog(@"UIDevice sgm_data_acquisition_systemVersion = %@" ,%orig);
    return %orig;
    
}
+ (id)sgm_data_acquisition_advertising{
    NSLog(@"UIDevice sgm_data_acquisition_advertising = %@" ,%orig);
    return %orig;
    
}

+ (id)sgm_data_acquisition_vendorid{
    //    NSLog(@"UIDevice sgm_data_acquisition_vendorid = %@" ,%orig);
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return %orig;
    }
    
    //    return %orig;
    
}


%end


%hook TTInstallKeychain

+ (id)loadValueForKey:(id)arg1{
    %log;
    id result =  %orig;
    if (result){
        NSLog(@"发哈哈哈哈 = %@  result = %@",arg1,%orig);
    }
    return %orig;
}

%end

%hook TTInstallIDManager

+ (id)deviceID{
    %log;
    id result =  %orig;
    if (result){
        NSLog(@"deviceID 哈哈哈 = %@ ",result);
    }
    
    return %orig;
}

%end

%hook TTTrackerProxy

+ (id)generatedPostParamsWithTrack:(id)arg1{
    
    %log;
    NSLog(@"generatedPostParamsWithTrack = %@",%orig);
    
    return %orig;
    
}

%end

%hook TTInstallUtil

+ (id)onTheFlyParameter{//这里是所有的参数产生原地  [TTInstallDeviceHelper isJailBroken]]  在里面
    
    %log;
    return %orig;
    
}
%end


%hook NSKeyedUnarchiver
+ (NSData *)archivedDataWithRootObject:(id)object requiringSecureCoding:(BOOL)requiresSecureCoding error:(NSError **)error{
    %log;
    id  result = %orig;
    if(![result isKindOfClass:[NSData class]]){
        NSLog(@"archivedDataWithRootObject = %@  class = %@",[result  class] ,result);
    }else{
        NSLog(@"archivedDataWithRootObject = %@  class = %@",[result  class] ,@"NSKeyedUnarchiver");
    }
    return result;
    
}

+ (id)unarchiveObjectWithData:(NSData *)data{
    
    
    id result =%orig;
    if(![result isKindOfClass:[NSData class]]){
        NSLog(@"unarchiveObjectWithData = %@ %@ class = %@ ", @"NSKeyedUnarchiver",[result  class] ,result);
        if([result isKindOfClass:[NSDictionary class]]){
            NSMutableDictionary *dic =   [[NSMutableDictionary alloc] initWithDictionary:result];
            if([dic objectForKey:@"SignInfo"]&&![dic[@"SignInfo"] containsString:@"AppStore"]){
                dic[@"SignInfo"]= @"AppStore";
            }
            return dic;
        }
    }else{
        NSLog(@"archivedDataWithRootObject = %@ %@ class = %@",@"NSKeyedUnarchiver",[result  class] ,@"NSKeyedUnarchiver");
    }
    return result;
}

%end

%hook NSKeyedArchiver
+ (NSData *)archivedDataWithRootObject:(id)rootObject{//可能是 69553866637   这就是设备id  有时候是did
    %log;
    if([rootObject isKindOfClass:[NSDictionary class]]){
        NSDictionary * resultinfo =rootObject;
        if([resultinfo[@"SignInfo"] containsString :@"Sichuan Yunzhihang Network Technology"]){
            
        }
    }
    
    if(![rootObject isKindOfClass:[NSData class]]){
        if([rootObject isKindOfClass:[NSDictionary class]]){
            NSMutableDictionary *dic =   [[NSMutableDictionary alloc] initWithDictionary:rootObject];
            if ([dic objectForKey:@"SignInfo"]||[dic objectForKey:@"bundleID"]||[dic objectForKey:@"bundleIdentifier"]) {
                dic[@"SignInfo"]= @"AppStore";
                rootObject = dic;
            }
            
            if(dic[@"iid"] &&dic[@"did"]){
                NSString *filePatch = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"douyin_help_status.plist"];
                NSMutableDictionary *dataDictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:filePatch];
                [dataDictionary setObject:dic[@"iid"] forKey:@"iid"];
                [dataDictionary setObject:dic[@"did"] forKey:@"did"];
                BOOL  sucess =   [dataDictionary writeToFile:filePatch atomically:YES];
            }
            
        }
    }
    NSLog(@"NSKeyedArchiver  archivedDataWithRootObject = %@  class = %@",[rootObject  class] ,rootObject);
    
    
    return %orig;
    
}

%end

%hook TTInstallDeviceHelper
+ (id)idfvString{
    //    NSLog(@"TTInstallDeviceHelper douyingbundleIdentifier idfv CLSBetaController  appBundleIdentifier   %@",%orig);
    //    return  %orig;
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return %orig;
    }
    
}
+ (id)idfaString{
    //    NSLog(@"TTInstallDeviceHelper douyingbundleIdentifier idfa CLSBetaController  appBundleIdentifier   %@",%orig);
    //    return  %orig;
    
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    
}

+ (_Bool)isJailBroken{
    return NO;
}

%end


%hook BDADeviceHelper
+ (id)idfaString{
    NSLog(@"BDADeviceHelper douyingbundleIdentifier idfaString    %@",%orig);
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    return  %orig;
    
}
%end

%hook BDLogDeviceHelper
+ (id)idfaString{
    NSLog(@"BDLogDeviceHelper douyingbundleIdentifier idfaString    %@",%orig);
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    return  %orig;
    
}
%end

%hook IESLiveDeviceInfo
+ (id)idfaString{
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    NSLog(@"IESLiveDeviceInfo douyingbundleIdentifier idfaString%@",%orig);
    
    return  %orig;
    
}
%end

%hook TTAdSplashDeviceHelper
+ (id)idfaString{
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    NSLog(@"TTAdSplashDeviceHelper douyingbundleIdentifier idfaString    %@",%orig);
    
    return  %orig;
}
%end


%hook TTExtensions
+ (id)idfaString{
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    NSLog(@"TTExtensions douyingbundleIdentifier idfaString    %@",%orig);
    
    return  %orig;
    
}
%end







%hook TTAdSplashStore
- (void)parseParams:(id)arg1{
    NSLog(@"TTAdSplashStore douyingbundleIdentifier parseParams CLSBetaController  appBundleIdentifier   %@",arg1);
    
    return  %orig;
    
}

- (id)idfa{
    %log;
    NSLog(@"TTAdSplashStore douyingbundleIdentifier idfa CLSBetaController  appBundleIdentifier   %@",%orig);
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    return  %orig;
}

- (id)idfv{
    %log;
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return %orig;
    }
}
%end



%hook UMANUtil
+ (id)appPackageNameString{
    %log;
    //    NSLog(@"douyingID   UMANUtil  appPackageNameString   %@",%orig);
    //    return  %orig;
    
    return  @"com.ss.iphone.ugc.Aweme";
}
+ (id)idfa{
    %log;
    NSLog(@"idfa   UMANUtil  idfa   %@",%orig);
    //    return  %orig;
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return %orig;
    }
    
    //    return  @"com.ss.iphone.ugc.Aweme";
}
+ (id)idfv{
    %log;
    NSLog(@"idfv   UMANUtil  idfv   %@",%orig);
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return %orig;
    }
}
//
//
//
%end
//
%hook UMANProtocolData
+ (id)appPackageNameString{
    %log;
    //    NSLog(@"douyingID   UMANProtocolData  appPackageNameString   %@",%orig);
    
    return  @"com.ss.iphone.ugc.Aweme";
}

%end

%hook TTChannelRequestParam
- (id)package{
    %log;
    //    NSLog(@"douyingID   TTChannelRequestParam  package   %@",%orig);
    
    return  @"com.ss.iphone.ugc.Aweme";
}

%end



%hook IESGurdPackagesConfigResponse
- (id)packageConfigDictionary{
    %log;
    //返回这种
    /*
     {
     cb39c3118caac9283f496b7789ec2be4 =     (
     "<IESGurdResourceModel: 0x176c6fc00>"
     ),
     }
     */
    //    NSLog(@"douyingID   IESGurdPackagesConfigResponse  packageConfigDictionary   %@",%orig);
    
    return  %orig;
}

%end


%hook TTInstallSandBoxHelper

%end

%hook UIApplication
- (id)btd_bundleIdentifier{
    %log;
    
    return  %orig;
}

%end

%hook TTExtensions
+ (id)bundleIdentifier{
    %log;
    //    NSLog(@"douyingbundleIdentifier  TTExtensions  bundleIdentifier   %@",%orig);
    
    return  @"com.ss.iphone.ugc.Aweme";
}

%end


%hook SGMDataAcquisitionUnit
+ (id)sgm_bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  SGMDataAcquisitionUnit  sgm_bundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end

%hook HTSNHProjectInfo
//+ (id)bundleIdentifier{
//    %log;
//    NSLog(@"douyingbundleIdentifier  HTSNHProjectInfo  bundleIdentifier   %@",%orig);//没有调用
//
//    return  %orig;
//}

%end

%hook FABSettings
+ (id)appBundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  FABSettings  appBundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end

%hook FABKit
+ (id)bundleIdentifier{
    %log;
    
    return  %orig;
}

%end


%hook Crashlytics
+ (id)bundleIdentifier{
    %log;
    
    return  %orig;
}

- (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  Crashlytics  bundleIdentifier  - %@",%orig);
    
    return  %orig;
    
}

%end


%hook CLSReportsController
- (id)appBundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  CLSReportsController  appBundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end

%hook CLSCrashReportingController
- (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  CLSCrashReportingController  bundleIdentifier   %@",%orig);
    
    //    return  %orig;
    return  @"com.ss.iphone.ugc.Aweme";
    
}

%end


%hook CLSBetaController
- (id)appBundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  CLSBetaController  appBundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end


%hook BDUGGetMobileSandBoxHelper
+ (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  BDUGGetMobileSandBoxHelper  bundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end


%hook BDLogSandBoxHelper
+ (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  BDLogSandBoxHelper  bundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end

%hook BDASandBoxHelper
+ (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  BDASandBoxHelper  bundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end

%hook AWETrackerProjectInfo
+ (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  AWETrackerProjectInfo  bundleIdentifier   %@",%orig);
    
    return  %orig;
}

%end


%hook Answers
//+ (id)bundleIdentifier{
//    %log;
//    NSLog(@"douyingbundleIdentifier  Answers  bundleIdentifier   %@",%orig);//返回com.twitter.answers.ios
//
//    return  %orig;
//}

%end


%hook AdMobKit
+ (id)bundleIdentifier{
    %log;
    NSLog(@"douyingbundleIdentifier  AdMobKit  bundleIdentifier   %@",%orig);
    
    return  %orig;
}



%end







static CFTypeRef (*orig_MGCopyAnswer)(CFStringRef str);
static CFTypeRef (*orig_MGCopyAnswer_internal)(CFStringRef str, uint32_t* outTypeCode);
static int (*orig_uname)(struct utsname *);

CFTypeRef new_MGCopyAnswer(CFStringRef str);
CFTypeRef new_MGCopyAnswer_internal(CFStringRef str, uint32_t* outTypeCode);
int new_uname(struct utsname *systemInfo);

int new_uname(struct utsname * systemInfo){
    NSLog(@"new_uname");
    int nRet = orig_uname(systemInfo);
    
    char str_machine_name[100] = "iPhone8,1";
    strcpy(systemInfo->machine,str_machine_name);
    return nRet;
}

CFTypeRef new_MGCopyAnswer(CFStringRef str){
    //NSLog(@"new_MGCopyAnswer");
    NSLog(@"strAAAAAA: %@",str);
    
    NSString *keyStr = (__bridge NSString *)str;
    if ([keyStr isEqualToString:@"UniqueDeviceID"] ) {
        
        NSString *strUDID = @"57359dc2fa451304bd9f94f590d02068d563d283";
        return (__bridge CFStringRef)strUDID;
    }
    else if ([keyStr isEqualToString:@"SerialNumber"] ) {
        
        NSString *strSerialNumber = @"DNPJD17NDTTP";
        return (__bridge CFStringRef)strSerialNumber;
    }
    else if ([keyStr isEqualToString:@"WifiAddress"] ) {
        
        NSString *strWifiAddress = @"98:FE:94:1F:30:0A";
        return (__bridge CFStringRef)strWifiAddress;
    }
    else if ([keyStr isEqualToString:@"BluetoothAddress"] ) {
        
        NSString *strBlueAddress = @"98:FE:94:1F:30:0A";
        return (__bridge CFStringRef)strBlueAddress;
    }
    else if([keyStr isEqualToString:@"ProductVersion"]) {
        
        NSString *strProductVersion = [[DYCommeObj sharedQueue] version];
        return (__bridge CFStringRef)strProductVersion;
    }
    else if([keyStr isEqualToString:@"UserAssignedDeviceName"]) {
        
        NSString *strUserAssignedDeviceName = [[DYCommeObj sharedQueue] userName];
        return (__bridge CFStringRef)strUserAssignedDeviceName;
    }
    return orig_MGCopyAnswer(str);
    
}


CFTypeRef new_MGCopyAnswer_internal(CFStringRef str, uint32_t* outTypeCode) {
    //NSLog(@"new_MGCopyAnswer_internal");
    NSLog(@"strAAA: %@",[[DYCommeObj sharedQueue] version]);
    
    NSString *keyStr = (__bridge NSString *)str;
    if ([keyStr isEqualToString:@"UniqueDeviceID"] ) {
        
        NSString *strUDID = @"57359dc2fa451304bd9f94f590d02068d563d283";
        return (__bridge CFStringRef)strUDID;
    }
    else if ([keyStr isEqualToString:@"SerialNumber"] ) {
        
        NSString *strSerialNumber = @"DNPJD17NDTTP";
        return (__bridge CFStringRef)strSerialNumber;
    }
    else if ([keyStr isEqualToString:@"WifiAddress"] ) {
        
        NSString *strWifiAddress = @"98:FE:94:1F:30:0A";
        return (__bridge CFStringRef)strWifiAddress;
    }
    else if ([keyStr isEqualToString:@"BluetoothAddress"] ) {
        
        NSString *strBlueAddress = @"98:FE:94:1F:30:0A";
        return (__bridge CFStringRef)strBlueAddress;
    }
    else if([keyStr isEqualToString:@"ProductVersion"]) {
        //        NSLog(@"ProductVersion  = %@",[[DYCommeObj sharedQueue] version]);
        //
        NSString *strProductVersion = [[DYCommeObj sharedQueue] version];
        return (__bridge CFStringRef)strProductVersion;
        //        return orig_MGCopyAnswer_internal(str, outTypeCode);
        
    }
    else if([keyStr isEqualToString:@"UserAssignedDeviceName"]) {
        
        NSString *strUserAssignedDeviceName = [[[DYCommeObj sharedQueue] userName] length]?@"[DYCommeObj sharedQueue]":@"iphone";
        
        return (__bridge CFStringRef)strUserAssignedDeviceName;
    }
    
    return orig_MGCopyAnswer_internal(str, outTypeCode);
    
}

void hook_uname(){
    NSLog(@"hook_uname");
    char str_libsystem_c[100] = {0};
    strcpy(str_libsystem_c, "/usr/lib/libsystem_c.dylib");
    
    void *h = dlopen(str_libsystem_c, RTLD_GLOBAL);
    if(h != 0){
        
        MSImageRef ref = MSGetImageByName(str_libsystem_c);
        void * unameFn = MSFindSymbol(ref, "_uname");
        NSLog(@"unameFn");
        MSHookFunction(unameFn, (void *) new_uname, (void **)&orig_uname);
    }
    else {
        
        strcpy(str_libsystem_c, "/usr/lib/system/libsystem_c.dylib");
        h = dlopen(str_libsystem_c, RTLD_GLOBAL);
        if(h != 0){
            
            MSImageRef ref = MSGetImageByName(str_libsystem_c);
            void * unameFn = MSFindSymbol(ref, "_uname");
            NSLog(@"unameFn");
            MSHookFunction(unameFn, (void *) new_uname, (void **)&orig_uname);
        }
        else {
            
            NSLog(@"%s dlopen error", str_libsystem_c);
        }
    }
    
}

void hookMGCopyAnswer(){
    
    char *dylib_path = (char*)"/usr/lib/libMobileGestalt.dylib";
    void *h = dlopen(dylib_path, RTLD_GLOBAL);
    if (h != 0) {
        MSImageRef libGestalt = MSGetImageByName("/usr/lib/libMobileGestalt.dylib");
        void *MGCopyAnswerFn = MSFindSymbol(libGestalt, "_MGCopyAnswer");
        
        //        MSImageRef ref = MSGetImageByName([strDylibFile UTF8String]);
        //        void * MGCopyAnswerFn = MSFindSymbol(ref, "_MGCopyAnswer");
        
        //64位特征码
        uint8_t MGCopyAnswer_arm64_impl[8] = {0x01, 0x00, 0x80, 0xd2, 0x01, 0x00, 0x00, 0x14};
        //10.3特征码
        uint8_t MGCopyAnswer_armv7_10_3_3_impl[5] = {0x21, 0x00, 0xf0, 0x00, 0xb8};
        
        //处理64位系统
        if (memcmp(MGCopyAnswerFn, MGCopyAnswer_arm64_impl, 8) == 0) {
            
            MSHookFunction((void*)((uint8_t*)MGCopyAnswerFn + 8), (void*)new_MGCopyAnswer_internal,
                           (void**)&orig_MGCopyAnswer_internal);
        }
        //处理32位10.3到10.3.3系统
        else if(memcmp(MGCopyAnswerFn, MGCopyAnswer_armv7_10_3_3_impl, 5) == 0){
            
            MSHookFunction((void*)((uint8_t*)MGCopyAnswerFn + 6), (void*)new_MGCopyAnswer_internal,
                           (void**)&orig_MGCopyAnswer_internal);
            
        }
        else{
            
            MSHookFunction(MGCopyAnswerFn, (void *) new_MGCopyAnswer, (void **)&orig_MGCopyAnswer);
        }
    }
    
}


%ctor{
    if([[DYCommeObj sharedQueue] reFresh]){
        [[DYCommeObj sharedQueue] clearSandBox];
        [[DYCommeObj sharedQueue] clearCookies];
        [[DYCommeObj sharedQueue] clearKeyChain];
        [[DYCommeObj sharedQueue] clearUserDefaults];
    }
    hookMGCopyAnswer();
    hook_uname();
}
