//
//  BaseMananger.h
//  yiyuangou
//
//  Created by roen on 15/9/27.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

//定义任意的single对象

#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
}


#define BaseServerURL @"http://192.168.1.119:8080/api/v1"
typedef void(^ManagerBlock)(id result, NSInteger statusCode , NSString *msg);

@interface BaseMananger : NSObject

@end
