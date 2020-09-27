#line 1 "/Users/apple/Desktop/dy接口测试/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"
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


















#include <substrate.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

@class BDLogOpenUDID; @class HTSNHProjectInfo; @class TTInstallDeviceHelper; @class FABSettings; @class Crashlytics; @class TTInstallOpenUDID; @class BDLogDeviceHelper; @class BDASandBoxHelper; @class BDLogSandBoxHelper; @class NSKeyedUnarchiver; @class TTTrackerProxy; @class NSKeyedArchiver; @class IESAntiSpam; @class AdMobKit; @class ASIdentifierManager; @class Answers; @class UMANUtil; @class FABKit; @class UIApplication; @class TTHttpRequestChromium; @class CLSReportsController; @class SGMDataAcquisitionUnit; @class CLSCrashReportingController; @class TTNetworkManagerChromium; @class TTAdSplashStore; @class IESGurdPackagesConfigResponse; @class TTInstallIDManager; @class AWENetworkService; @class TTInstallSandBoxHelper; @class CLSBetaController; @class UIDevice; @class TTInstallKeychain; @class AWETrackerProjectInfo; @class UTDIDOpenUDID; @class TTExtensions; @class UMANProtocolData; @class TTInstallUtil; @class OpenUDID; @class BDADeviceHelper; @class UMANOpenUDID; @class IESLiveDeviceInfo; @class TTChannelRequestParam; @class BDUGGetMobileSandBoxHelper; @class TTAdSplashDeviceHelper; 
static id (*_logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$)(_LOGOS_SELF_TYPE_NORMAL TTNetworkManagerChromium* _LOGOS_SELF_CONST, SEL, id, id, id, _Bool, id, Class, Class, _Bool, _Bool, _Bool, id, void(^)(id,id), id); static id _logos_method$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(_LOGOS_SELF_TYPE_NORMAL TTNetworkManagerChromium* _LOGOS_SELF_CONST, SEL, id, id, id, _Bool, id, Class, Class, _Bool, _Bool, _Bool, id, void(^)(id,id), id); static void (*_logos_orig$_ungrouped$TTInstallIDManager$setDeviceID$)(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TTInstallIDManager$setDeviceID$(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$TTInstallIDManager$setInstallID$)(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TTInstallIDManager$setInstallID$(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$TTInstallIDManager$deviceID)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTInstallIDManager$deviceID(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, _Bool, id, Class, id, Class, Class, id, _Bool, id); static id _logos_meta_method$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id, id, _Bool, id, Class, id, Class, Class, id, _Bool, id); static void (*_logos_orig$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$)(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL, id); static void (*_logos_orig$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$)(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL, id, id); static void _logos_method$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL, id, id); static id (*_logos_orig$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields)(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$)(_LOGOS_SELF_TYPE_NORMAL IESAntiSpam* _LOGOS_SELF_CONST, SEL, id, id); static id _logos_method$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$(_LOGOS_SELF_TYPE_NORMAL IESAntiSpam* _LOGOS_SELF_CONST, SEL, id, id); static NSString* (*_logos_meta_orig$_ungrouped$BDLogOpenUDID$value)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSString* _logos_meta_method$_ungrouped$BDLogOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDLogOpenUDID$_getDictFromPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$BDLogOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$BDLogOpenUDID$_setDict$forPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$BDLogOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static NSString* (*_logos_meta_orig$_ungrouped$TTInstallOpenUDID$value)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSString* _logos_meta_method$_ungrouped$TTInstallOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTInstallOpenUDID$_getDictFromPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$TTInstallOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$TTInstallOpenUDID$_setDict$forPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$TTInstallOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static NSString* (*_logos_meta_orig$_ungrouped$UMANOpenUDID$value)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSString* _logos_meta_method$_ungrouped$UMANOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UMANOpenUDID$_getDictFromPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$UMANOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$UMANOpenUDID$_setDict$forPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$UMANOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static NSString* (*_logos_meta_orig$_ungrouped$UTDIDOpenUDID$value)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSString* _logos_meta_method$_ungrouped$UTDIDOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UTDIDOpenUDID$_getDictFromPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$UTDIDOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$UTDIDOpenUDID$_setDict$forPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$UTDIDOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static NSString* (*_logos_meta_orig$_ungrouped$OpenUDID$value)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSString* _logos_meta_method$_ungrouped$OpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$OpenUDID$_getDictFromPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$OpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static void (*_logos_meta_orig$_ungrouped$OpenUDID$_setDict$forPasteboard$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static void _logos_meta_method$_ungrouped$OpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, id); static NSUUID * (*_logos_orig$_ungrouped$ASIdentifierManager$advertisingIdentifier)(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST, SEL); static NSUUID * _logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$btd_idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$btd_idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSUUID * (*_logos_orig$_ungrouped$UIDevice$identifierForVendor)(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static NSUUID * _logos_method$_ungrouped$UIDevice$identifierForVendor(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static _Bool _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, _Bool); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, _Bool); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineName)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModel)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModel(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemName)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_advertising)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_advertising(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_vendorid)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_vendorid(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTInstallKeychain$loadValueForKey$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$TTInstallKeychain$loadValueForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id _logos_meta_method$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$TTInstallUtil$onTheFlyParameter)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTInstallUtil$onTheFlyParameter(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static NSData * (*_logos_meta_orig$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, BOOL, NSError **); static NSData * _logos_meta_method$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id, BOOL, NSError **); static id (*_logos_meta_orig$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *); static id _logos_meta_method$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, NSData *); static NSData * (*_logos_meta_orig$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static NSData * _logos_meta_method$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL, id); static id (*_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfvString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfvString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static _Bool (*_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$isJailBroken)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static _Bool _logos_meta_method$_ungrouped$TTInstallDeviceHelper$isJailBroken(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDADeviceHelper$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$BDADeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDLogDeviceHelper$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$BDLogDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$IESLiveDeviceInfo$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$IESLiveDeviceInfo$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTAdSplashDeviceHelper$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTAdSplashDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTExtensions$idfaString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTExtensions$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$TTExtensions$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$TTExtensions$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static void (*_logos_orig$_ungrouped$TTAdSplashStore$parseParams$)(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL, id); static void _logos_method$_ungrouped$TTAdSplashStore$parseParams$(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL, id); static id (*_logos_orig$_ungrouped$TTAdSplashStore$idfa)(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$TTAdSplashStore$idfa(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$TTAdSplashStore$idfv)(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$TTAdSplashStore$idfv(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UMANUtil$appPackageNameString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UMANUtil$appPackageNameString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UMANUtil$idfa)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UMANUtil$idfa(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UMANUtil$idfv)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UMANUtil$idfv(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$UMANProtocolData$appPackageNameString)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$UMANProtocolData$appPackageNameString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$TTChannelRequestParam$package)(_LOGOS_SELF_TYPE_NORMAL TTChannelRequestParam* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$TTChannelRequestParam$package(_LOGOS_SELF_TYPE_NORMAL TTChannelRequestParam* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary)(_LOGOS_SELF_TYPE_NORMAL IESGurdPackagesConfigResponse* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary(_LOGOS_SELF_TYPE_NORMAL IESGurdPackagesConfigResponse* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$UIApplication$btd_bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$UIApplication$btd_bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$FABSettings$appBundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$FABSettings$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$FABKit$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$FABKit$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$Crashlytics$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$Crashlytics$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$Crashlytics$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Crashlytics* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$Crashlytics$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Crashlytics* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$CLSReportsController$appBundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL CLSReportsController* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$CLSReportsController$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSReportsController* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$CLSCrashReportingController$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL CLSCrashReportingController* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$CLSCrashReportingController$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSCrashReportingController* _LOGOS_SELF_CONST, SEL); static id (*_logos_orig$_ungrouped$CLSBetaController$appBundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL CLSBetaController* _LOGOS_SELF_CONST, SEL); static id _logos_method$_ungrouped$CLSBetaController$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSBetaController* _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDLogSandBoxHelper$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$BDLogSandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$BDASandBoxHelper$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$BDASandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$AWETrackerProjectInfo$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$AWETrackerProjectInfo$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id (*_logos_meta_orig$_ungrouped$AdMobKit$bundleIdentifier)(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); static id _logos_meta_method$_ungrouped$AdMobKit$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST, SEL); 

#line 46 "/Users/apple/Desktop/dy接口测试/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"


static id _logos_method$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(_LOGOS_SELF_TYPE_NORMAL TTNetworkManagerChromium* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, _Bool arg4, id arg5, Class arg6, Class arg7, _Bool arg8, _Bool arg9, _Bool arg10, id arg11, void(^arg12)(id,id), id arg13){
    
    NSLog(@"GGGGGGGGGG %@ \n %@",arg1,arg2);
    NSString *url = arg1;
    
    id myCallBackzbb = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"10"};
        
    };
    
    id myCallBackUserInfo = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"1"};
        
    };
    
    id myCallBackUserPost = ^(id block_arg1,NSDictionary * block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        resu[@"param_array"] = @{@"allData":block_arg2,@"report_type":@"2"};
        
        
        
        
        
        
        
        
        
    };
    
    
    id myCallBackUserFavorite = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        
        
        
        
        
    };
    
    
    
    id myCallBackUserForward = ^(id block_arg1,id block_arg2){
        arg12(block_arg1,block_arg2);
        
        NSMutableDictionary *resu = [[NSMutableDictionary alloc]init];
        
        
        
        
        
    };
    
    
    
    
    
    if([url containsString :@"https://webcast.amemv.com/webcast/ranklist/hot/"]){
        return  _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackzbb,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/user/profile/other/"]){
        return  _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserInfo,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/forward/list/"]){
        return  _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserForward,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/aweme/post/"]){
        return  _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserPost,arg13);
    }else if([url containsString :@"https://aweme.snssdk.com/aweme/v1/aweme/favorite/"]){
        return  _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1,arg2,arg3,arg4,arg5,arg6,arg7,arg8,arg9,arg10,arg11,myCallBackUserFavorite,arg13);
    }else{
        return _logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }
    
}




static void _logos_method$_ungrouped$TTInstallIDManager$setDeviceID$(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id str){
    return _logos_orig$_ungrouped$TTInstallIDManager$setDeviceID$(self, _cmd, str);
}

static void _logos_method$_ungrouped$TTInstallIDManager$setInstallID$(_LOGOS_SELF_TYPE_NORMAL TTInstallIDManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id str){
    return _logos_orig$_ungrouped$TTInstallIDManager$setInstallID$(self, _cmd, str);
}





static id _logos_meta_method$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2, id arg3, _Bool arg4, id arg5, Class arg6, id arg7, Class arg8, Class arg9, id arg10, _Bool arg11, id arg12){
    HBLogDebug(@"+[<AWENetworkService: %p> _requestWithURLString:%@ params:%@ method:%@ needCommonParams:%d header:%@ modelClass:%@ targetAttributes:%@ requestSerializer:%@ responseSerializer:%@ responseBlock:%@ enableCache:%d completionBlock:%@]", self, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
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
    return _logos_meta_orig$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$(self, _cmd, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
    
}





static void _logos_method$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){ 
    
    
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
    
    HBLogDebug(@"-[<TTHttpRequestChromium: %p> setAllHTTPHeaderFields:%@]", self, arg1);
    return _logos_orig$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$(self, _cmd, arg1);
}

static void _logos_method$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"-[<TTHttpRequestChromium: %p> setValue:%@ forHTTPHeaderField:%@]", self, arg1, arg2);
    return _logos_orig$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$(self, _cmd, arg1, arg2);
    
}
static id _logos_method$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields(_LOGOS_SELF_TYPE_NORMAL TTHttpRequestChromium* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<TTHttpRequestChromium: %p> allHTTPHeaderFields]", self);
    NSLog(@"headerallHTTPHeaderFields = %@",_logos_orig$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields(self, _cmd));

    return _logos_orig$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields(self, _cmd);
}





static id _logos_method$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$(_LOGOS_SELF_TYPE_NORMAL IESAntiSpam* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1, id arg2){
    HBLogDebug(@"-[<IESAntiSpam: %p> sgm_encryptWithURL:%@ msg:%@]", self, arg1, arg2);
    
    NSLog(@"IESAntiSpam  encryResult agg1 = %@ arg2 = %@  result =%@ " ,arg1,arg2,_logos_orig$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$(self, _cmd, arg1, arg2));
    
    id result =_logos_orig$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$(self, _cmd, arg1, arg2);
    
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
    
    
    
    return result;
}





static NSString* _logos_meta_method$_ungrouped$BDLogOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"BDLogOpenUDID  cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        
        return _logos_meta_orig$_ungrouped$BDLogOpenUDID$value(self, _cmd);
    }
    
}
static id _logos_meta_method$_ungrouped$BDLogOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    return  [NSMutableDictionary dictionary];
}

static void _logos_meta_method$_ungrouped$BDLogOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id dict, id pboard) {
    return ;
}




static NSString* _logos_meta_method$_ungrouped$TTInstallOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"TTInstallOpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        
        return _logos_meta_orig$_ungrouped$TTInstallOpenUDID$value(self, _cmd);
    }
    
}
static id _logos_meta_method$_ungrouped$TTInstallOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    return  [NSMutableDictionary new];
}

static void _logos_meta_method$_ungrouped$TTInstallOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id dict, id pboard) {
    return ;
}



static NSString* _logos_meta_method$_ungrouped$UMANOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"UMANOpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];;
    }else{
        
        return _logos_meta_orig$_ungrouped$UMANOpenUDID$value(self, _cmd);
    }
    
}
static id _logos_meta_method$_ungrouped$UMANOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

static void _logos_meta_method$_ungrouped$UMANOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id dict, id pboard) {
    return ;
}



static NSString* _logos_meta_method$_ungrouped$UTDIDOpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UTDIDOpenUDID cccccopenudidi = %@" ,_logos_meta_orig$_ungrouped$UTDIDOpenUDID$value(self, _cmd));
    return _logos_meta_orig$_ungrouped$UTDIDOpenUDID$value(self, _cmd);
}

static id _logos_meta_method$_ungrouped$UTDIDOpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

static void _logos_meta_method$_ungrouped$UTDIDOpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id dict, id pboard) {
    return ;
}



static NSString* _logos_meta_method$_ungrouped$OpenUDID$value(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<OpenUDID: %p> value]", self);
    if([[DYCommeObj sharedQueue] openudid]){
        NSLog(@"OpenUDID cccccopenudidi = %@" ,[[DYCommeObj sharedQueue] openudid]);
        
        return [[DYCommeObj sharedQueue] openudid];
    }else{
        
        return _logos_meta_orig$_ungrouped$OpenUDID$value(self, _cmd);
    }
    
}








static id _logos_meta_method$_ungrouped$OpenUDID$_getDictFromPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    return  [NSMutableDictionary dictionaryWithDictionary: nil];
}

static void _logos_meta_method$_ungrouped$OpenUDID$_setDict$forPasteboard$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id dict, id pboard) {
    return ;
}




static NSUUID * _logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier(_LOGOS_SELF_TYPE_NORMAL ASIdentifierManager* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
    
    if([[DYCommeObj sharedQueue] idfa]){
        NSLog(@"CCCCCCCCC advertisingIdentifier = %@" ,[[DYCommeObj sharedQueue] idfa]);
        
        return [[DYCommeObj sharedQueue] idfa];
    }else{
        return _logos_orig$_ungrouped$ASIdentifierManager$advertisingIdentifier(self, _cmd);
    }
    
}



static id _logos_meta_method$_ungrouped$UIDevice$btd_idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    
    
    if([[DYCommeObj sharedQueue] idfa]){
        NSLog(@"CCCCCCCCC identifierForVendor = %@" ,[[DYCommeObj sharedQueue] idfa]);
        
        return [[DYCommeObj sharedQueue] idfa];
    }else{
        return _logos_meta_orig$_ungrouped$UIDevice$btd_idfaString(self, _cmd);
    }
}


static NSUUID * _logos_method$_ungrouped$UIDevice$identifierForVendor(_LOGOS_SELF_TYPE_NORMAL UIDevice* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    
    
    if([[DYCommeObj sharedQueue] idfv]){
        NSLog(@"CCCCCCCCC identifierForVendor = %@" ,[[DYCommeObj sharedQueue] idfv]);
        
        return [[DYCommeObj sharedQueue] idfv];
    }else{
        NSLog(@"idfv error  nil = %@" ,[[DYCommeObj sharedQueue] idfv]);
        
        return _logos_orig$_ungrouped$UIDevice$identifierForVendor(self, _cmd);
    }
}

static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_getIPAddress = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress(self, _cmd);
}

static _Bool _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_insertSIMCard = %d" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, _Bool arg1){
    NSLog(@"UIDevice sgm_data_acquisition_getIPAddress = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$(self, _cmd, arg1));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$(self, _cmd, arg1);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_wifiIPAddress = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_machineName = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineName(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineName(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_machineModelName = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModel(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_machineModel = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModel(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModel(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemName(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_systemName = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemName(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemName(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_systemVersion = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion(self, _cmd);
    
}
static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_advertising(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"UIDevice sgm_data_acquisition_advertising = %@" ,_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_advertising(self, _cmd));
    return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_advertising(self, _cmd);
    
}

static id _logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_vendorid(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_vendorid(self, _cmd);
    }
    
    
    
}







static id _logos_meta_method$_ungrouped$TTInstallKeychain$loadValueForKey$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    HBLogDebug(@"+[<TTInstallKeychain: %p> loadValueForKey:%@]", self, arg1);
    id result =  _logos_meta_orig$_ungrouped$TTInstallKeychain$loadValueForKey$(self, _cmd, arg1);
    if (result){
        NSLog(@"发哈哈哈哈 = %@  result = %@",arg1,_logos_meta_orig$_ungrouped$TTInstallKeychain$loadValueForKey$(self, _cmd, arg1));
    }
    return _logos_meta_orig$_ungrouped$TTInstallKeychain$loadValueForKey$(self, _cmd, arg1);
}





static id _logos_meta_method$_ungrouped$TTInstallIDManager$deviceID(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<TTInstallIDManager: %p> deviceID]", self);
    id result =  _logos_meta_orig$_ungrouped$TTInstallIDManager$deviceID(self, _cmd);
    if (result){
        NSLog(@"deviceID 哈哈哈 = %@ ",result);
    }
    
    return _logos_meta_orig$_ungrouped$TTInstallIDManager$deviceID(self, _cmd);
}





static id _logos_meta_method$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    
    HBLogDebug(@"+[<TTTrackerProxy: %p> generatedPostParamsWithTrack:%@]", self, arg1);
    NSLog(@"generatedPostParamsWithTrack = %@",_logos_meta_orig$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$(self, _cmd, arg1));
    
    return _logos_meta_orig$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$(self, _cmd, arg1);
    
}





static id _logos_meta_method$_ungrouped$TTInstallUtil$onTheFlyParameter(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    HBLogDebug(@"+[<TTInstallUtil: %p> onTheFlyParameter]", self);
    return _logos_meta_orig$_ungrouped$TTInstallUtil$onTheFlyParameter(self, _cmd);
    
}




static NSData * _logos_meta_method$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id object, BOOL requiresSecureCoding, NSError ** error){
    HBLogDebug(@"+[<NSKeyedUnarchiver: %p> archivedDataWithRootObject:%@ requiringSecureCoding:%d error:%p]", self, object, requiresSecureCoding, error);
    id  result = _logos_meta_orig$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$(self, _cmd, object, requiresSecureCoding, error);
    if(![result isKindOfClass:[NSData class]]){
        NSLog(@"archivedDataWithRootObject = %@  class = %@",[result  class] ,result);
    }else{
        NSLog(@"archivedDataWithRootObject = %@  class = %@",[result  class] ,@"NSKeyedUnarchiver");
    }
    return result;
    
}

static id _logos_meta_method$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSData * data){
    
    
    id result =_logos_meta_orig$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$(self, _cmd, data);
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




static NSData * _logos_meta_method$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id rootObject){
    HBLogDebug(@"+[<NSKeyedArchiver: %p> archivedDataWithRootObject:%@]", self, rootObject);
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
    
    
    return _logos_meta_orig$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$(self, _cmd, rootObject);
    
}




static id _logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfvString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfvString(self, _cmd);
    }
    
}
static id _logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    
    
    
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfaString(self, _cmd);
    }
    
}

static _Bool _logos_meta_method$_ungrouped$TTInstallDeviceHelper$isJailBroken(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    return NO;
}





static id _logos_meta_method$_ungrouped$BDADeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"BDADeviceHelper douyingbundleIdentifier idfaString    %@",_logos_meta_orig$_ungrouped$BDADeviceHelper$idfaString(self, _cmd));
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$BDADeviceHelper$idfaString(self, _cmd);
    }
    return  _logos_meta_orig$_ungrouped$BDADeviceHelper$idfaString(self, _cmd);
    
}



static id _logos_meta_method$_ungrouped$BDLogDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    NSLog(@"BDLogDeviceHelper douyingbundleIdentifier idfaString    %@",_logos_meta_orig$_ungrouped$BDLogDeviceHelper$idfaString(self, _cmd));
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$BDLogDeviceHelper$idfaString(self, _cmd);
    }
    return  _logos_meta_orig$_ungrouped$BDLogDeviceHelper$idfaString(self, _cmd);
    
}



static id _logos_meta_method$_ungrouped$IESLiveDeviceInfo$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$IESLiveDeviceInfo$idfaString(self, _cmd);
    }
    NSLog(@"IESLiveDeviceInfo douyingbundleIdentifier idfaString%@",_logos_meta_orig$_ungrouped$IESLiveDeviceInfo$idfaString(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$IESLiveDeviceInfo$idfaString(self, _cmd);
    
}



static id _logos_meta_method$_ungrouped$TTAdSplashDeviceHelper$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$TTAdSplashDeviceHelper$idfaString(self, _cmd);
    }
    NSLog(@"TTAdSplashDeviceHelper douyingbundleIdentifier idfaString    %@",_logos_meta_orig$_ungrouped$TTAdSplashDeviceHelper$idfaString(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$TTAdSplashDeviceHelper$idfaString(self, _cmd);
}




static id _logos_meta_method$_ungrouped$TTExtensions$idfaString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$TTExtensions$idfaString(self, _cmd);
    }
    NSLog(@"TTExtensions douyingbundleIdentifier idfaString    %@",_logos_meta_orig$_ungrouped$TTExtensions$idfaString(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$TTExtensions$idfaString(self, _cmd);
    
}









static void _logos_method$_ungrouped$TTAdSplashStore$parseParams$(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, id arg1){
    NSLog(@"TTAdSplashStore douyingbundleIdentifier parseParams CLSBetaController  appBundleIdentifier   %@",arg1);
    
    return  _logos_orig$_ungrouped$TTAdSplashStore$parseParams$(self, _cmd, arg1);
    
}

static id _logos_method$_ungrouped$TTAdSplashStore$idfa(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<TTAdSplashStore: %p> idfa]", self);
    NSLog(@"TTAdSplashStore douyingbundleIdentifier idfa CLSBetaController  appBundleIdentifier   %@",_logos_orig$_ungrouped$TTAdSplashStore$idfa(self, _cmd));
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_orig$_ungrouped$TTAdSplashStore$idfa(self, _cmd);
    }
    return  _logos_orig$_ungrouped$TTAdSplashStore$idfa(self, _cmd);
}

static id _logos_method$_ungrouped$TTAdSplashStore$idfv(_LOGOS_SELF_TYPE_NORMAL TTAdSplashStore* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<TTAdSplashStore: %p> idfv]", self);
    
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return _logos_orig$_ungrouped$TTAdSplashStore$idfv(self, _cmd);
    }
}





static id _logos_meta_method$_ungrouped$UMANUtil$appPackageNameString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<UMANUtil: %p> appPackageNameString]", self);
    
    
    
    return  @"com.ss.iphone.ugc.Aweme";
}
static id _logos_meta_method$_ungrouped$UMANUtil$idfa(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<UMANUtil: %p> idfa]", self);
    NSLog(@"idfa   UMANUtil  idfa   %@",_logos_meta_orig$_ungrouped$UMANUtil$idfa(self, _cmd));
    
    if([[DYCommeObj sharedQueue] idfa]){
        return [[[DYCommeObj sharedQueue] idfa] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$UMANUtil$idfa(self, _cmd);
    }
    
    
}
static id _logos_meta_method$_ungrouped$UMANUtil$idfv(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<UMANUtil: %p> idfv]", self);
    NSLog(@"idfv   UMANUtil  idfv   %@",_logos_meta_orig$_ungrouped$UMANUtil$idfv(self, _cmd));
    if([[DYCommeObj sharedQueue] idfv]){
        return [[[DYCommeObj sharedQueue] idfv] UUIDString];
    }else{
        return _logos_meta_orig$_ungrouped$UMANUtil$idfv(self, _cmd);
    }
}






static id _logos_meta_method$_ungrouped$UMANProtocolData$appPackageNameString(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<UMANProtocolData: %p> appPackageNameString]", self);
    
    
    return  @"com.ss.iphone.ugc.Aweme";
}




static id _logos_method$_ungrouped$TTChannelRequestParam$package(_LOGOS_SELF_TYPE_NORMAL TTChannelRequestParam* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<TTChannelRequestParam: %p> package]", self);
    
    
    return  @"com.ss.iphone.ugc.Aweme";
}






static id _logos_method$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary(_LOGOS_SELF_TYPE_NORMAL IESGurdPackagesConfigResponse* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<IESGurdPackagesConfigResponse: %p> packageConfigDictionary]", self);
    
    






    
    
    return  _logos_orig$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary(self, _cmd);
}









static id _logos_method$_ungrouped$UIApplication$btd_bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL UIApplication* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<UIApplication: %p> btd_bundleIdentifier]", self);
    
    return  _logos_orig$_ungrouped$UIApplication$btd_bundleIdentifier(self, _cmd);
}




static id _logos_meta_method$_ungrouped$TTExtensions$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<TTExtensions: %p> bundleIdentifier]", self);
    
    
    return  @"com.ss.iphone.ugc.Aweme";
}





static id _logos_meta_method$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<SGMDataAcquisitionUnit: %p> sgm_bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  SGMDataAcquisitionUnit  sgm_bundleIdentifier   %@",_logos_meta_orig$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier(self, _cmd);
}














static id _logos_meta_method$_ungrouped$FABSettings$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<FABSettings: %p> appBundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  FABSettings  appBundleIdentifier   %@",_logos_meta_orig$_ungrouped$FABSettings$appBundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$FABSettings$appBundleIdentifier(self, _cmd);
}




static id _logos_meta_method$_ungrouped$FABKit$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<FABKit: %p> bundleIdentifier]", self);
    
    return  _logos_meta_orig$_ungrouped$FABKit$bundleIdentifier(self, _cmd);
}





static id _logos_meta_method$_ungrouped$Crashlytics$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<Crashlytics: %p> bundleIdentifier]", self);
    
    return  _logos_meta_orig$_ungrouped$Crashlytics$bundleIdentifier(self, _cmd);
}

static id _logos_method$_ungrouped$Crashlytics$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Crashlytics* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<Crashlytics: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  Crashlytics  bundleIdentifier  - %@",_logos_orig$_ungrouped$Crashlytics$bundleIdentifier(self, _cmd));
    
    return  _logos_orig$_ungrouped$Crashlytics$bundleIdentifier(self, _cmd);
    
}





static id _logos_method$_ungrouped$CLSReportsController$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSReportsController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<CLSReportsController: %p> appBundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  CLSReportsController  appBundleIdentifier   %@",_logos_orig$_ungrouped$CLSReportsController$appBundleIdentifier(self, _cmd));
    
    return  _logos_orig$_ungrouped$CLSReportsController$appBundleIdentifier(self, _cmd);
}




static id _logos_method$_ungrouped$CLSCrashReportingController$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSCrashReportingController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<CLSCrashReportingController: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  CLSCrashReportingController  bundleIdentifier   %@",_logos_orig$_ungrouped$CLSCrashReportingController$bundleIdentifier(self, _cmd));
    
    
    return  @"com.ss.iphone.ugc.Aweme";
    
}





static id _logos_method$_ungrouped$CLSBetaController$appBundleIdentifier(_LOGOS_SELF_TYPE_NORMAL CLSBetaController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"-[<CLSBetaController: %p> appBundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  CLSBetaController  appBundleIdentifier   %@",_logos_orig$_ungrouped$CLSBetaController$appBundleIdentifier(self, _cmd));
    
    return  _logos_orig$_ungrouped$CLSBetaController$appBundleIdentifier(self, _cmd);
}





static id _logos_meta_method$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<BDUGGetMobileSandBoxHelper: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  BDUGGetMobileSandBoxHelper  bundleIdentifier   %@",_logos_meta_orig$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier(self, _cmd);
}





static id _logos_meta_method$_ungrouped$BDLogSandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<BDLogSandBoxHelper: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  BDLogSandBoxHelper  bundleIdentifier   %@",_logos_meta_orig$_ungrouped$BDLogSandBoxHelper$bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$BDLogSandBoxHelper$bundleIdentifier(self, _cmd);
}




static id _logos_meta_method$_ungrouped$BDASandBoxHelper$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<BDASandBoxHelper: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  BDASandBoxHelper  bundleIdentifier   %@",_logos_meta_orig$_ungrouped$BDASandBoxHelper$bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$BDASandBoxHelper$bundleIdentifier(self, _cmd);
}




static id _logos_meta_method$_ungrouped$AWETrackerProjectInfo$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<AWETrackerProjectInfo: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  AWETrackerProjectInfo  bundleIdentifier   %@",_logos_meta_orig$_ungrouped$AWETrackerProjectInfo$bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$AWETrackerProjectInfo$bundleIdentifier(self, _cmd);
}
















static id _logos_meta_method$_ungrouped$AdMobKit$bundleIdentifier(_LOGOS_SELF_TYPE_NORMAL Class _LOGOS_SELF_CONST __unused self, SEL __unused _cmd){
    HBLogDebug(@"+[<AdMobKit: %p> bundleIdentifier]", self);
    NSLog(@"douyingbundleIdentifier  AdMobKit  bundleIdentifier   %@",_logos_meta_orig$_ungrouped$AdMobKit$bundleIdentifier(self, _cmd));
    
    return  _logos_meta_orig$_ungrouped$AdMobKit$bundleIdentifier(self, _cmd);
}











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
        
        
        NSString *strProductVersion = [[DYCommeObj sharedQueue] version];
        return (__bridge CFStringRef)strProductVersion;
        
        
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
        
        
        
        
        
        uint8_t MGCopyAnswer_arm64_impl[8] = {0x01, 0x00, 0x80, 0xd2, 0x01, 0x00, 0x00, 0x14};
        
        uint8_t MGCopyAnswer_armv7_10_3_3_impl[5] = {0x21, 0x00, 0xf0, 0x00, 0xb8};
        
        
        if (memcmp(MGCopyAnswerFn, MGCopyAnswer_arm64_impl, 8) == 0) {
            
            MSHookFunction((void*)((uint8_t*)MGCopyAnswerFn + 8), (void*)new_MGCopyAnswer_internal,
                           (void**)&orig_MGCopyAnswer_internal);
        }
        
        else if(memcmp(MGCopyAnswerFn, MGCopyAnswer_armv7_10_3_3_impl, 5) == 0){
            
            MSHookFunction((void*)((uint8_t*)MGCopyAnswerFn + 6), (void*)new_MGCopyAnswer_internal,
                           (void**)&orig_MGCopyAnswer_internal);
            
        }
        else{
            
            MSHookFunction(MGCopyAnswerFn, (void *) new_MGCopyAnswer, (void **)&orig_MGCopyAnswer);
        }
    }
    
}


static __attribute__((constructor)) void _logosLocalCtor_ed2d8135(int __unused argc, char __unused **argv, char __unused **envp){
    if([[DYCommeObj sharedQueue] reFresh]){
        [[DYCommeObj sharedQueue] clearSandBox];
        [[DYCommeObj sharedQueue] clearCookies];
        [[DYCommeObj sharedQueue] clearKeyChain];
        [[DYCommeObj sharedQueue] clearUserDefaults];
    }
    hookMGCopyAnswer();
    hook_uname();
}
static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$TTNetworkManagerChromium = objc_getClass("TTNetworkManagerChromium"); MSHookMessageEx(_logos_class$_ungrouped$TTNetworkManagerChromium, @selector(requestForJSONWithURL_:params:method:needCommonParams:headerField:requestSerializer:responseSerializer:autoResume:verifyRequest:isCustomizedCookie:callback:callbackWithResponse:dispatch_queue:), (IMP)&_logos_method$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$, (IMP*)&_logos_orig$_ungrouped$TTNetworkManagerChromium$requestForJSONWithURL_$params$method$needCommonParams$headerField$requestSerializer$responseSerializer$autoResume$verifyRequest$isCustomizedCookie$callback$callbackWithResponse$dispatch_queue$);Class _logos_class$_ungrouped$TTInstallIDManager = objc_getClass("TTInstallIDManager"); Class _logos_metaclass$_ungrouped$TTInstallIDManager = object_getClass(_logos_class$_ungrouped$TTInstallIDManager); MSHookMessageEx(_logos_class$_ungrouped$TTInstallIDManager, @selector(setDeviceID:), (IMP)&_logos_method$_ungrouped$TTInstallIDManager$setDeviceID$, (IMP*)&_logos_orig$_ungrouped$TTInstallIDManager$setDeviceID$);MSHookMessageEx(_logos_class$_ungrouped$TTInstallIDManager, @selector(setInstallID:), (IMP)&_logos_method$_ungrouped$TTInstallIDManager$setInstallID$, (IMP*)&_logos_orig$_ungrouped$TTInstallIDManager$setInstallID$);MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallIDManager, @selector(deviceID), (IMP)&_logos_meta_method$_ungrouped$TTInstallIDManager$deviceID, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallIDManager$deviceID);Class _logos_class$_ungrouped$AWENetworkService = objc_getClass("AWENetworkService"); Class _logos_metaclass$_ungrouped$AWENetworkService = object_getClass(_logos_class$_ungrouped$AWENetworkService); MSHookMessageEx(_logos_metaclass$_ungrouped$AWENetworkService, @selector(_requestWithURLString:params:method:needCommonParams:header:modelClass:targetAttributes:requestSerializer:responseSerializer:responseBlock:enableCache:completionBlock:), (IMP)&_logos_meta_method$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$, (IMP*)&_logos_meta_orig$_ungrouped$AWENetworkService$_requestWithURLString$params$method$needCommonParams$header$modelClass$targetAttributes$requestSerializer$responseSerializer$responseBlock$enableCache$completionBlock$);Class _logos_class$_ungrouped$TTHttpRequestChromium = objc_getClass("TTHttpRequestChromium"); MSHookMessageEx(_logos_class$_ungrouped$TTHttpRequestChromium, @selector(setAllHTTPHeaderFields:), (IMP)&_logos_method$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$, (IMP*)&_logos_orig$_ungrouped$TTHttpRequestChromium$setAllHTTPHeaderFields$);MSHookMessageEx(_logos_class$_ungrouped$TTHttpRequestChromium, @selector(setValue:forHTTPHeaderField:), (IMP)&_logos_method$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$, (IMP*)&_logos_orig$_ungrouped$TTHttpRequestChromium$setValue$forHTTPHeaderField$);MSHookMessageEx(_logos_class$_ungrouped$TTHttpRequestChromium, @selector(allHTTPHeaderFields), (IMP)&_logos_method$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields, (IMP*)&_logos_orig$_ungrouped$TTHttpRequestChromium$allHTTPHeaderFields);Class _logos_class$_ungrouped$IESAntiSpam = objc_getClass("IESAntiSpam"); MSHookMessageEx(_logos_class$_ungrouped$IESAntiSpam, @selector(sgm_encryptWithURL:msg:), (IMP)&_logos_method$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$, (IMP*)&_logos_orig$_ungrouped$IESAntiSpam$sgm_encryptWithURL$msg$);Class _logos_class$_ungrouped$BDLogOpenUDID = objc_getClass("BDLogOpenUDID"); Class _logos_metaclass$_ungrouped$BDLogOpenUDID = object_getClass(_logos_class$_ungrouped$BDLogOpenUDID); MSHookMessageEx(_logos_metaclass$_ungrouped$BDLogOpenUDID, @selector(value), (IMP)&_logos_meta_method$_ungrouped$BDLogOpenUDID$value, (IMP*)&_logos_meta_orig$_ungrouped$BDLogOpenUDID$value);MSHookMessageEx(_logos_metaclass$_ungrouped$BDLogOpenUDID, @selector(_getDictFromPasteboard:), (IMP)&_logos_meta_method$_ungrouped$BDLogOpenUDID$_getDictFromPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$BDLogOpenUDID$_getDictFromPasteboard$);MSHookMessageEx(_logos_metaclass$_ungrouped$BDLogOpenUDID, @selector(_setDict:forPasteboard:), (IMP)&_logos_meta_method$_ungrouped$BDLogOpenUDID$_setDict$forPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$BDLogOpenUDID$_setDict$forPasteboard$);Class _logos_class$_ungrouped$TTInstallOpenUDID = objc_getClass("TTInstallOpenUDID"); Class _logos_metaclass$_ungrouped$TTInstallOpenUDID = object_getClass(_logos_class$_ungrouped$TTInstallOpenUDID); MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallOpenUDID, @selector(value), (IMP)&_logos_meta_method$_ungrouped$TTInstallOpenUDID$value, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallOpenUDID$value);MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallOpenUDID, @selector(_getDictFromPasteboard:), (IMP)&_logos_meta_method$_ungrouped$TTInstallOpenUDID$_getDictFromPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallOpenUDID$_getDictFromPasteboard$);MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallOpenUDID, @selector(_setDict:forPasteboard:), (IMP)&_logos_meta_method$_ungrouped$TTInstallOpenUDID$_setDict$forPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallOpenUDID$_setDict$forPasteboard$);Class _logos_class$_ungrouped$UMANOpenUDID = objc_getClass("UMANOpenUDID"); Class _logos_metaclass$_ungrouped$UMANOpenUDID = object_getClass(_logos_class$_ungrouped$UMANOpenUDID); MSHookMessageEx(_logos_metaclass$_ungrouped$UMANOpenUDID, @selector(value), (IMP)&_logos_meta_method$_ungrouped$UMANOpenUDID$value, (IMP*)&_logos_meta_orig$_ungrouped$UMANOpenUDID$value);MSHookMessageEx(_logos_metaclass$_ungrouped$UMANOpenUDID, @selector(_getDictFromPasteboard:), (IMP)&_logos_meta_method$_ungrouped$UMANOpenUDID$_getDictFromPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$UMANOpenUDID$_getDictFromPasteboard$);MSHookMessageEx(_logos_metaclass$_ungrouped$UMANOpenUDID, @selector(_setDict:forPasteboard:), (IMP)&_logos_meta_method$_ungrouped$UMANOpenUDID$_setDict$forPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$UMANOpenUDID$_setDict$forPasteboard$);Class _logos_class$_ungrouped$UTDIDOpenUDID = objc_getClass("UTDIDOpenUDID"); Class _logos_metaclass$_ungrouped$UTDIDOpenUDID = object_getClass(_logos_class$_ungrouped$UTDIDOpenUDID); MSHookMessageEx(_logos_metaclass$_ungrouped$UTDIDOpenUDID, @selector(value), (IMP)&_logos_meta_method$_ungrouped$UTDIDOpenUDID$value, (IMP*)&_logos_meta_orig$_ungrouped$UTDIDOpenUDID$value);MSHookMessageEx(_logos_metaclass$_ungrouped$UTDIDOpenUDID, @selector(_getDictFromPasteboard:), (IMP)&_logos_meta_method$_ungrouped$UTDIDOpenUDID$_getDictFromPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$UTDIDOpenUDID$_getDictFromPasteboard$);MSHookMessageEx(_logos_metaclass$_ungrouped$UTDIDOpenUDID, @selector(_setDict:forPasteboard:), (IMP)&_logos_meta_method$_ungrouped$UTDIDOpenUDID$_setDict$forPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$UTDIDOpenUDID$_setDict$forPasteboard$);Class _logos_class$_ungrouped$OpenUDID = objc_getClass("OpenUDID"); Class _logos_metaclass$_ungrouped$OpenUDID = object_getClass(_logos_class$_ungrouped$OpenUDID); MSHookMessageEx(_logos_metaclass$_ungrouped$OpenUDID, @selector(value), (IMP)&_logos_meta_method$_ungrouped$OpenUDID$value, (IMP*)&_logos_meta_orig$_ungrouped$OpenUDID$value);MSHookMessageEx(_logos_metaclass$_ungrouped$OpenUDID, @selector(_getDictFromPasteboard:), (IMP)&_logos_meta_method$_ungrouped$OpenUDID$_getDictFromPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$OpenUDID$_getDictFromPasteboard$);MSHookMessageEx(_logos_metaclass$_ungrouped$OpenUDID, @selector(_setDict:forPasteboard:), (IMP)&_logos_meta_method$_ungrouped$OpenUDID$_setDict$forPasteboard$, (IMP*)&_logos_meta_orig$_ungrouped$OpenUDID$_setDict$forPasteboard$);Class _logos_class$_ungrouped$ASIdentifierManager = objc_getClass("ASIdentifierManager"); MSHookMessageEx(_logos_class$_ungrouped$ASIdentifierManager, @selector(advertisingIdentifier), (IMP)&_logos_method$_ungrouped$ASIdentifierManager$advertisingIdentifier, (IMP*)&_logos_orig$_ungrouped$ASIdentifierManager$advertisingIdentifier);Class _logos_class$_ungrouped$UIDevice = objc_getClass("UIDevice"); Class _logos_metaclass$_ungrouped$UIDevice = object_getClass(_logos_class$_ungrouped$UIDevice); MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(btd_idfaString), (IMP)&_logos_meta_method$_ungrouped$UIDevice$btd_idfaString, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$btd_idfaString);MSHookMessageEx(_logos_class$_ungrouped$UIDevice, @selector(identifierForVendor), (IMP)&_logos_method$_ungrouped$UIDevice$identifierForVendor, (IMP*)&_logos_orig$_ungrouped$UIDevice$identifierForVendor);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_getIPAddress), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_insertSIMCard), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_insertSIMCard);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_getIPAddress:), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_getIPAddress$);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_wifiIPAddress), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_wifiIPAddress);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_machineName), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineName, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineName);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_machineModelName), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModelName);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_machineModel), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_machineModel, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_machineModel);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_systemName), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemName, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemName);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_systemVersion), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_systemVersion);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_advertising), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_advertising, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_advertising);MSHookMessageEx(_logos_metaclass$_ungrouped$UIDevice, @selector(sgm_data_acquisition_vendorid), (IMP)&_logos_meta_method$_ungrouped$UIDevice$sgm_data_acquisition_vendorid, (IMP*)&_logos_meta_orig$_ungrouped$UIDevice$sgm_data_acquisition_vendorid);Class _logos_class$_ungrouped$TTInstallKeychain = objc_getClass("TTInstallKeychain"); Class _logos_metaclass$_ungrouped$TTInstallKeychain = object_getClass(_logos_class$_ungrouped$TTInstallKeychain); MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallKeychain, @selector(loadValueForKey:), (IMP)&_logos_meta_method$_ungrouped$TTInstallKeychain$loadValueForKey$, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallKeychain$loadValueForKey$);Class _logos_class$_ungrouped$TTTrackerProxy = objc_getClass("TTTrackerProxy"); Class _logos_metaclass$_ungrouped$TTTrackerProxy = object_getClass(_logos_class$_ungrouped$TTTrackerProxy); MSHookMessageEx(_logos_metaclass$_ungrouped$TTTrackerProxy, @selector(generatedPostParamsWithTrack:), (IMP)&_logos_meta_method$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$, (IMP*)&_logos_meta_orig$_ungrouped$TTTrackerProxy$generatedPostParamsWithTrack$);Class _logos_class$_ungrouped$TTInstallUtil = objc_getClass("TTInstallUtil"); Class _logos_metaclass$_ungrouped$TTInstallUtil = object_getClass(_logos_class$_ungrouped$TTInstallUtil); MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallUtil, @selector(onTheFlyParameter), (IMP)&_logos_meta_method$_ungrouped$TTInstallUtil$onTheFlyParameter, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallUtil$onTheFlyParameter);Class _logos_class$_ungrouped$NSKeyedUnarchiver = objc_getClass("NSKeyedUnarchiver"); Class _logos_metaclass$_ungrouped$NSKeyedUnarchiver = object_getClass(_logos_class$_ungrouped$NSKeyedUnarchiver); MSHookMessageEx(_logos_metaclass$_ungrouped$NSKeyedUnarchiver, @selector(archivedDataWithRootObject:requiringSecureCoding:error:), (IMP)&_logos_meta_method$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$, (IMP*)&_logos_meta_orig$_ungrouped$NSKeyedUnarchiver$archivedDataWithRootObject$requiringSecureCoding$error$);MSHookMessageEx(_logos_metaclass$_ungrouped$NSKeyedUnarchiver, @selector(unarchiveObjectWithData:), (IMP)&_logos_meta_method$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$, (IMP*)&_logos_meta_orig$_ungrouped$NSKeyedUnarchiver$unarchiveObjectWithData$);Class _logos_class$_ungrouped$NSKeyedArchiver = objc_getClass("NSKeyedArchiver"); Class _logos_metaclass$_ungrouped$NSKeyedArchiver = object_getClass(_logos_class$_ungrouped$NSKeyedArchiver); MSHookMessageEx(_logos_metaclass$_ungrouped$NSKeyedArchiver, @selector(archivedDataWithRootObject:), (IMP)&_logos_meta_method$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$, (IMP*)&_logos_meta_orig$_ungrouped$NSKeyedArchiver$archivedDataWithRootObject$);Class _logos_class$_ungrouped$TTInstallDeviceHelper = objc_getClass("TTInstallDeviceHelper"); Class _logos_metaclass$_ungrouped$TTInstallDeviceHelper = object_getClass(_logos_class$_ungrouped$TTInstallDeviceHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallDeviceHelper, @selector(idfvString), (IMP)&_logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfvString, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfvString);MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallDeviceHelper, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$TTInstallDeviceHelper$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$idfaString);MSHookMessageEx(_logos_metaclass$_ungrouped$TTInstallDeviceHelper, @selector(isJailBroken), (IMP)&_logos_meta_method$_ungrouped$TTInstallDeviceHelper$isJailBroken, (IMP*)&_logos_meta_orig$_ungrouped$TTInstallDeviceHelper$isJailBroken);Class _logos_class$_ungrouped$BDADeviceHelper = objc_getClass("BDADeviceHelper"); Class _logos_metaclass$_ungrouped$BDADeviceHelper = object_getClass(_logos_class$_ungrouped$BDADeviceHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$BDADeviceHelper, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$BDADeviceHelper$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$BDADeviceHelper$idfaString);Class _logos_class$_ungrouped$BDLogDeviceHelper = objc_getClass("BDLogDeviceHelper"); Class _logos_metaclass$_ungrouped$BDLogDeviceHelper = object_getClass(_logos_class$_ungrouped$BDLogDeviceHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$BDLogDeviceHelper, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$BDLogDeviceHelper$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$BDLogDeviceHelper$idfaString);Class _logos_class$_ungrouped$IESLiveDeviceInfo = objc_getClass("IESLiveDeviceInfo"); Class _logos_metaclass$_ungrouped$IESLiveDeviceInfo = object_getClass(_logos_class$_ungrouped$IESLiveDeviceInfo); MSHookMessageEx(_logos_metaclass$_ungrouped$IESLiveDeviceInfo, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$IESLiveDeviceInfo$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$IESLiveDeviceInfo$idfaString);Class _logos_class$_ungrouped$TTAdSplashDeviceHelper = objc_getClass("TTAdSplashDeviceHelper"); Class _logos_metaclass$_ungrouped$TTAdSplashDeviceHelper = object_getClass(_logos_class$_ungrouped$TTAdSplashDeviceHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$TTAdSplashDeviceHelper, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$TTAdSplashDeviceHelper$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$TTAdSplashDeviceHelper$idfaString);Class _logos_class$_ungrouped$TTExtensions = objc_getClass("TTExtensions"); Class _logos_metaclass$_ungrouped$TTExtensions = object_getClass(_logos_class$_ungrouped$TTExtensions); MSHookMessageEx(_logos_metaclass$_ungrouped$TTExtensions, @selector(idfaString), (IMP)&_logos_meta_method$_ungrouped$TTExtensions$idfaString, (IMP*)&_logos_meta_orig$_ungrouped$TTExtensions$idfaString);MSHookMessageEx(_logos_metaclass$_ungrouped$TTExtensions, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$TTExtensions$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$TTExtensions$bundleIdentifier);Class _logos_class$_ungrouped$TTAdSplashStore = objc_getClass("TTAdSplashStore"); MSHookMessageEx(_logos_class$_ungrouped$TTAdSplashStore, @selector(parseParams:), (IMP)&_logos_method$_ungrouped$TTAdSplashStore$parseParams$, (IMP*)&_logos_orig$_ungrouped$TTAdSplashStore$parseParams$);MSHookMessageEx(_logos_class$_ungrouped$TTAdSplashStore, @selector(idfa), (IMP)&_logos_method$_ungrouped$TTAdSplashStore$idfa, (IMP*)&_logos_orig$_ungrouped$TTAdSplashStore$idfa);MSHookMessageEx(_logos_class$_ungrouped$TTAdSplashStore, @selector(idfv), (IMP)&_logos_method$_ungrouped$TTAdSplashStore$idfv, (IMP*)&_logos_orig$_ungrouped$TTAdSplashStore$idfv);Class _logos_class$_ungrouped$UMANUtil = objc_getClass("UMANUtil"); Class _logos_metaclass$_ungrouped$UMANUtil = object_getClass(_logos_class$_ungrouped$UMANUtil); MSHookMessageEx(_logos_metaclass$_ungrouped$UMANUtil, @selector(appPackageNameString), (IMP)&_logos_meta_method$_ungrouped$UMANUtil$appPackageNameString, (IMP*)&_logos_meta_orig$_ungrouped$UMANUtil$appPackageNameString);MSHookMessageEx(_logos_metaclass$_ungrouped$UMANUtil, @selector(idfa), (IMP)&_logos_meta_method$_ungrouped$UMANUtil$idfa, (IMP*)&_logos_meta_orig$_ungrouped$UMANUtil$idfa);MSHookMessageEx(_logos_metaclass$_ungrouped$UMANUtil, @selector(idfv), (IMP)&_logos_meta_method$_ungrouped$UMANUtil$idfv, (IMP*)&_logos_meta_orig$_ungrouped$UMANUtil$idfv);Class _logos_class$_ungrouped$UMANProtocolData = objc_getClass("UMANProtocolData"); Class _logos_metaclass$_ungrouped$UMANProtocolData = object_getClass(_logos_class$_ungrouped$UMANProtocolData); MSHookMessageEx(_logos_metaclass$_ungrouped$UMANProtocolData, @selector(appPackageNameString), (IMP)&_logos_meta_method$_ungrouped$UMANProtocolData$appPackageNameString, (IMP*)&_logos_meta_orig$_ungrouped$UMANProtocolData$appPackageNameString);Class _logos_class$_ungrouped$TTChannelRequestParam = objc_getClass("TTChannelRequestParam"); MSHookMessageEx(_logos_class$_ungrouped$TTChannelRequestParam, @selector(package), (IMP)&_logos_method$_ungrouped$TTChannelRequestParam$package, (IMP*)&_logos_orig$_ungrouped$TTChannelRequestParam$package);Class _logos_class$_ungrouped$IESGurdPackagesConfigResponse = objc_getClass("IESGurdPackagesConfigResponse"); MSHookMessageEx(_logos_class$_ungrouped$IESGurdPackagesConfigResponse, @selector(packageConfigDictionary), (IMP)&_logos_method$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary, (IMP*)&_logos_orig$_ungrouped$IESGurdPackagesConfigResponse$packageConfigDictionary);Class _logos_class$_ungrouped$UIApplication = objc_getClass("UIApplication"); MSHookMessageEx(_logos_class$_ungrouped$UIApplication, @selector(btd_bundleIdentifier), (IMP)&_logos_method$_ungrouped$UIApplication$btd_bundleIdentifier, (IMP*)&_logos_orig$_ungrouped$UIApplication$btd_bundleIdentifier);Class _logos_class$_ungrouped$SGMDataAcquisitionUnit = objc_getClass("SGMDataAcquisitionUnit"); Class _logos_metaclass$_ungrouped$SGMDataAcquisitionUnit = object_getClass(_logos_class$_ungrouped$SGMDataAcquisitionUnit); MSHookMessageEx(_logos_metaclass$_ungrouped$SGMDataAcquisitionUnit, @selector(sgm_bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$SGMDataAcquisitionUnit$sgm_bundleIdentifier);Class _logos_class$_ungrouped$FABSettings = objc_getClass("FABSettings"); Class _logos_metaclass$_ungrouped$FABSettings = object_getClass(_logos_class$_ungrouped$FABSettings); MSHookMessageEx(_logos_metaclass$_ungrouped$FABSettings, @selector(appBundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$FABSettings$appBundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$FABSettings$appBundleIdentifier);Class _logos_class$_ungrouped$FABKit = objc_getClass("FABKit"); Class _logos_metaclass$_ungrouped$FABKit = object_getClass(_logos_class$_ungrouped$FABKit); MSHookMessageEx(_logos_metaclass$_ungrouped$FABKit, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$FABKit$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$FABKit$bundleIdentifier);Class _logos_class$_ungrouped$Crashlytics = objc_getClass("Crashlytics"); Class _logos_metaclass$_ungrouped$Crashlytics = object_getClass(_logos_class$_ungrouped$Crashlytics); MSHookMessageEx(_logos_metaclass$_ungrouped$Crashlytics, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$Crashlytics$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$Crashlytics$bundleIdentifier);MSHookMessageEx(_logos_class$_ungrouped$Crashlytics, @selector(bundleIdentifier), (IMP)&_logos_method$_ungrouped$Crashlytics$bundleIdentifier, (IMP*)&_logos_orig$_ungrouped$Crashlytics$bundleIdentifier);Class _logos_class$_ungrouped$CLSReportsController = objc_getClass("CLSReportsController"); MSHookMessageEx(_logos_class$_ungrouped$CLSReportsController, @selector(appBundleIdentifier), (IMP)&_logos_method$_ungrouped$CLSReportsController$appBundleIdentifier, (IMP*)&_logos_orig$_ungrouped$CLSReportsController$appBundleIdentifier);Class _logos_class$_ungrouped$CLSCrashReportingController = objc_getClass("CLSCrashReportingController"); MSHookMessageEx(_logos_class$_ungrouped$CLSCrashReportingController, @selector(bundleIdentifier), (IMP)&_logos_method$_ungrouped$CLSCrashReportingController$bundleIdentifier, (IMP*)&_logos_orig$_ungrouped$CLSCrashReportingController$bundleIdentifier);Class _logos_class$_ungrouped$CLSBetaController = objc_getClass("CLSBetaController"); MSHookMessageEx(_logos_class$_ungrouped$CLSBetaController, @selector(appBundleIdentifier), (IMP)&_logos_method$_ungrouped$CLSBetaController$appBundleIdentifier, (IMP*)&_logos_orig$_ungrouped$CLSBetaController$appBundleIdentifier);Class _logos_class$_ungrouped$BDUGGetMobileSandBoxHelper = objc_getClass("BDUGGetMobileSandBoxHelper"); Class _logos_metaclass$_ungrouped$BDUGGetMobileSandBoxHelper = object_getClass(_logos_class$_ungrouped$BDUGGetMobileSandBoxHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$BDUGGetMobileSandBoxHelper, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$BDUGGetMobileSandBoxHelper$bundleIdentifier);Class _logos_class$_ungrouped$BDLogSandBoxHelper = objc_getClass("BDLogSandBoxHelper"); Class _logos_metaclass$_ungrouped$BDLogSandBoxHelper = object_getClass(_logos_class$_ungrouped$BDLogSandBoxHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$BDLogSandBoxHelper, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$BDLogSandBoxHelper$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$BDLogSandBoxHelper$bundleIdentifier);Class _logos_class$_ungrouped$BDASandBoxHelper = objc_getClass("BDASandBoxHelper"); Class _logos_metaclass$_ungrouped$BDASandBoxHelper = object_getClass(_logos_class$_ungrouped$BDASandBoxHelper); MSHookMessageEx(_logos_metaclass$_ungrouped$BDASandBoxHelper, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$BDASandBoxHelper$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$BDASandBoxHelper$bundleIdentifier);Class _logos_class$_ungrouped$AWETrackerProjectInfo = objc_getClass("AWETrackerProjectInfo"); Class _logos_metaclass$_ungrouped$AWETrackerProjectInfo = object_getClass(_logos_class$_ungrouped$AWETrackerProjectInfo); MSHookMessageEx(_logos_metaclass$_ungrouped$AWETrackerProjectInfo, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$AWETrackerProjectInfo$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$AWETrackerProjectInfo$bundleIdentifier);Class _logos_class$_ungrouped$AdMobKit = objc_getClass("AdMobKit"); Class _logos_metaclass$_ungrouped$AdMobKit = object_getClass(_logos_class$_ungrouped$AdMobKit); MSHookMessageEx(_logos_metaclass$_ungrouped$AdMobKit, @selector(bundleIdentifier), (IMP)&_logos_meta_method$_ungrouped$AdMobKit$bundleIdentifier, (IMP*)&_logos_meta_orig$_ungrouped$AdMobKit$bundleIdentifier);} }
#line 1188 "/Users/apple/Desktop/dy接口测试/WeChatDemoDylib/Logos/WeChatDemoDylib.xm"
