//
//  YMUser.m
//  mobi
//
//  Created by Simon on 9/11/15.
//  Copyright (c) 2015 mobi. All rights reserved.
//

#import "YMUser.h"
#import "YMAddress.h"
@implementation YMUser


-(id)init{
    self=[super init];
    if (self) {
     }
    return self;
}
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"addressArray" : @"YMAddress",
             };
}
@end
