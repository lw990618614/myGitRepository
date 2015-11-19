//
//  NSString+common.h
//  Common
//
//  Created by dodohua on 15-3-4.
//  Copyright (c) 2015年 ChinaTelecom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+tmri.h"
@interface NSString (common)
- (NSString *) MD5Hash_16;


- (NSString *) MD5Hash_32;

-(NSMutableArray *)substringByRegular:(NSString *)regular;
-(NSString *)subFirstStringByRegular:(NSString *)regular;

-(NSString*) urlstring_gb;
-(NSString*) urlstring_utf;
-(NSString *) urlstring;


- (BOOL)isExistSpaceString;

-(NSString *)getDateStringByFormat:(NSString *)formatStr ToFormat:(NSString *)toFormatStr;


@end
