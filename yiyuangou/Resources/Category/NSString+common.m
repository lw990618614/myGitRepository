//
//  NSString+common.m
//  Common
//
//  Created by dodohua on 15-3-4.
//  Copyright (c) 2015年 ChinaTelecom. All rights reserved.
//

#import "NSString+common.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (common)
- (NSString *) MD5Hash_16{
    
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (int)[self length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (digest, &md5);
    NSString *s = [NSString stringWithFormat: @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                   digest[0],  digest[1],
                   digest[2],  digest[3],
                   digest[4],  digest[5],
                   digest[6],  digest[7],
                   digest[8],  digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    
    return s;
    
}
//md5 32位 加密 （大写）
- (NSString *)MD5Hash_32{
    
    
    
    CC_MD5_CTX md5;
    CC_MD5_Init (&md5);
    CC_MD5_Update (&md5, [self UTF8String], (int)[self length]);
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final (result, &md5);
    
    
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
    
}

-(NSMutableArray *)substringByRegular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        while (r.length != NSNotFound &&r.length != 0) {
            
            NSString* substr = [self substringWithRange:r];
            //NSLog(@"xxxx%@",substr);
            
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            
            r=[self rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}

-(NSString *)subFirstStringByRegular:(NSString *)regular
{
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    if (r.length != NSNotFound &&r.length != 0) {
        NSString* substr = [self substringWithRange:r];
        return substr;
    }
    return nil;
}

-(NSString*) urlstring_gb{
    //    NSString *strurl = (NSString *)self;
    //    strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSURL *url = [NSURL URLWithString:strurl];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //
    //    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //    NSString *retStr = [[[NSString alloc] initWithData:data encoding:enc] autorelease];
    //
    
    
    /*NSString *strurl = [self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
     ASIHTTPRequest *request = [[ASIHTTPRequest requestWithURL:[NSURL URLWithString:strurl]] autorelease];
     
     
     // Start the request
     [request startSynchronous];
     return [request responseString];
     */
    
    
    NSString *strurl = (NSString *)self;
    
    NSStringEncoding chineseEnc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    strurl = [strurl stringByAddingPercentEscapesUsingEncoding:chineseEnc];
    NSURL *url = [NSURL URLWithString:strurl];
    
    return [NSString stringWithContentsOfURL:url encoding:chineseEnc error:nil];
    
}

-(NSString*) urlstring_utf{
    //    NSString *strurl = (NSString *)self;
    //    strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //    NSURL *url = [NSURL URLWithString:strurl];
    //    NSData *data = [NSData dataWithContentsOfURL:url];
    //    NSString *retStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    
    NSString *strurl = (NSString *)self;
    strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strurl];
    NSString *webString=[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    return webString;
}

-(NSString *) urlstring
{
    NSString *strurl = (NSString *)self;
    strurl = [strurl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:strurl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *retStr = [[NSString alloc] initWithData:data encoding:enc];
    if (retStr==nil||[retStr isEqualToString:@""]) {
        retStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return retStr;
}

- (BOOL)isExistSpaceString{
    NSString *string = (NSString *)self;
//    if ([string hasSuffix:@" "]||[string hasPrefix:@" "]) {
    if ([string containsString:@" "]) {
        return YES;
    }else{
        return NO;
    }
}

-(NSString *)getDateStringByFormat:(NSString *)formatStr ToFormat:(NSString *)toFormatStr{
    NSString *string = (NSString *)self;
    NSDate *tempDate = [NSDate dateFromString:string withFormat:formatStr];
    NSString *result = [tempDate stringWithFormat:toFormatStr];
    return result;
}

@end
