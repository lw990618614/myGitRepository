//
//  DYCommeObj.h
//  DouyinDylib
//
//  Created by apple on 2020/9/17.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
#import "DeviceModel.h"
#import "MJExtension.h"

NS_ASSUME_NONNULL_BEGIN

@interface DYCommeObj : NSObject
@property (nonatomic, assign) BOOL reFresh;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *openudid;
@property (nonatomic, strong) NSUUID *idfa;
@property (nonatomic, strong) NSUUID *idfv;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSMutableArray *queue;

+(instancetype)sharedQueue;
-(void)enqueue:(NSMutableDictionary *)param;
-(NSMutableDictionary *)dequeue;

-(void)clearCookies;
-(void)clearBoudleContainer:(NSString *)stringPath;
- (void)clearUserDefaults;
-(void)clearSandBox;
-(void)clearKeyChain;
-(void)clearPastBoard;
-(void)getQueaAndTask;
-(void)upTheCookie;
-(void)delayUpCookieToSevers;


@end

NS_ASSUME_NONNULL_END
