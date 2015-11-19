//
//  YMOrder.m
//  yiyuangou
//
//  Created by roen on 15/11/3.
//  Copyright © 2015年 atobo. All rights reserved.
//

#import "YMOrder.h"

@implementation YMOrder
-(NSString *)qurey
{
    NSMutableString *strM = [[NSMutableString alloc] init];
    [strM appendFormat:@"transid=%@&",self.transid];
    [strM appendFormat:@"redirecturl=%@&",self.redirecturl];
    [strM appendFormat:@"cpurl=%@",self.cpurl];
    return [strM copy];
}
@end

@implementation YMTransid
-(NSString *)qurey
{
    NSMutableString *strM = [[NSMutableString alloc] init];
    [strM appendFormat:@"transid=%@&",self.transid];
    [strM appendFormat:@"redirecturl=%@&",self.redirecturl];
    [strM appendFormat:@"cpurl=%@",self.cpurl];
    return [strM copy];
}
@end