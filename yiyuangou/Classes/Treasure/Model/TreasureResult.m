//
//  TreasureResult.m
//  yiyuangou
//
//  Created by roen on 15/10/22.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "TreasureResult.h"

@implementation TreasureResult
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"shareList" : @"ShareProduction",
             };
}
@end
@implementation ShareProduction
+ (NSDictionary *)objectClassInArray
{
    return @{
             @"imageList" : @"SharePicture",
             };
}


@end
@implementation SharePicture

@end