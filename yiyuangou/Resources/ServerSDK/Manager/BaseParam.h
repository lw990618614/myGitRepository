//
//  BaseParam.h
//  yiyuangou
//
//  Created by roen on 15/10/16.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseParam : NSObject
@property (assign, nonatomic) NSNumber *Uid;
@property (copy, nonatomic) NSString* IMEI;
@property (copy, nonatomic) NSString* packName;
@property (copy, nonatomic) NSString* appkey;
@property (copy, nonatomic) NSString* channel;
@property (copy, nonatomic) NSString* net_t;
@property (copy, nonatomic) NSString* Lu;
@property (copy, nonatomic) NSString* appVer;
@property (copy, nonatomic) NSString* mac;
@property (copy, nonatomic) NSString* idfa;
@property (copy, nonatomic) NSString* os;
@property (assign, nonatomic) NSNumber *platform;


@end
