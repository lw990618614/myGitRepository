//
//  NSString+tmri.m
//  main
//
//  Created by Ch on 14/11/18.
//  Copyright (c) 2014年 ChinaTelecom. All rights reserved.
//

#import "NSString+tmri.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (tmri)

// Checking if String is Empty
-(BOOL)isBlank
{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}

//Checking if String is empty or nil
-(BOOL)isValid
{
    return (self == nil||[[self trim] isEqualToString:@""] || [self isEqualToString:@"(null)"]|| [self isEqualToString:@"null"]) ? NO :YES;
}

// remove white spaces from String
- (NSString *)removeWhiteSpacesFromString
{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

// Counts number of Words in String
- (NSUInteger)countNumberOfWords
{
    NSScanner *scanner = [NSScanner scannerWithString:self];
    NSCharacterSet *whiteSpace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    NSUInteger count = 0;
    while ([scanner scanUpToCharactersFromSet: whiteSpace  intoString: nil]) {
        count++;
    }
    
    return count;
}

// If string contains substring
- (BOOL)containsString:(NSString *)subString
{
    return ([self rangeOfString:subString].location == NSNotFound) ? NO : YES;
}

// If my string starts with given string
- (BOOL)isBeginsWith:(NSString *)string
{
    return ([self hasPrefix:string]) ? YES : NO;
}

// If my string ends with given string
- (BOOL)isEndssWith:(NSString *)string
{
    return ([self hasSuffix:string]) ? YES : NO;
}


// Replace particular characters in my string with new character
- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar
{
    return  [self stringByReplacingOccurrencesOfString:olderChar withString:newerChar];
}

// Get Substring from particular location to given lenght
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end
{
    NSRange r;
    r.location = begin;
    r.length = end - begin;
    return [self substringWithRange:r];
}

// Add substring to main String
- (NSString *)addString:(NSString *)string
{
    if(!string || string.length == 0)
        return self;
    
    return [self stringByAppendingString:string];
}

// Remove particular sub string from main string
-(NSString *)removeSubString:(NSString *)subString
{
    if ([self containsString:subString])
    {
        NSRange range = [self rangeOfString:subString];
        return  [self stringByReplacingCharactersInRange:range withString:@""];
    }
    return self;
}


// If my string contains ony letters
- (BOOL)containsOnlyLetters
{
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

// If my string contains only numbers
- (BOOL)containsOnlyNumbers
{
    NSCharacterSet *numbersCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numbersCharacterSet].location == NSNotFound);
}

// If my string contains letters and numbers
- (BOOL)containsOnlyNumbersAndLetters
{
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

// If my string is available in particular array
- (BOOL)isInThisarray:(NSArray*)array
{
    for(NSString *string in array) {
        if([self isEqualToString:string]) {
            return YES;
        }
    }
    return NO;
}

// Get String from array
+ (NSString *)getStringFromArray:(NSArray *)array
{
    return [array componentsJoinedByString:@" "];
}

// Convert Array from my String
- (NSArray *)getArray
{
    return [self componentsSeparatedByString:@" "];
}

// Get My Application Version number
+ (NSString *)getMyApplicationVersion
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleVersion"];
    return version;
}

// Get My Application name
+ (NSString *)getMyApplicationName
{
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *name = [info objectForKey:@"CFBundleDisplayName"];
    return name;
}


// Convert string to NSData
- (NSData *)convertToData
{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

// Get String from NSData
+ (NSString *)getStringFromData:(NSData *)data
{
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];
    
}

// Is Valid Email

- (BOOL)isValidEmail
{
    NSString *regex = @"^([a-zA-Z0-9_\\-\\.]+)@((\\[[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\\]?)$";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

// Is Valid Phone

- (BOOL)isValidPhoneNumber
{
    NSString *regex = @"^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    BOOL isValid = [phoneTest evaluateWithObject:self];
    return isValid;
}

//用户名只能输入数字 字母 和中文
-(BOOL)isValidUserName
{
    NSString *phoneRegex = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isValid = [phoneTest evaluateWithObject:self];
    return isValid;
}
-(BOOL)isValidQQ
{
    NSString *Regex = @"\\w{5,12}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [passwordTest evaluateWithObject:self];
}

// Is Valid URL

- (BOOL)isValidUrl
{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

// Is Valid PassWord
-(BOOL)isValidCode
{
    NSString *Regex = @"[1-9]\\d{5}(?!\\d)";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [codeTest evaluateWithObject:self];
}
-(BOOL)isValidPassword
{
    NSString *Regex = @"\\w{6,16}";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [passwordTest evaluateWithObject:self];
}
-(BOOL)isValidNickName
{
    NSString *Regex = @"\\w{1,12}";
    NSPredicate *userName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [userName evaluateWithObject:self];
}
-(BOOL)isValidAdress
{
    NSString *Regex = @"\\w{2,40}";
    NSPredicate *userName = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [userName evaluateWithObject:self];
}
- (NSArray *)words
{
#if ! __has_feature(objc_arc)
    NSMutableArray *words = [[[NSMutableArray alloc] init] autorelease];
#else
    NSMutableArray *words = [[NSMutableArray alloc] init];
#endif
    
    const char *str = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}

- (NSString *)lowercaseFirstCharacter
{
    NSRange range = NSMakeRange(0,1);
    NSString *lowerFirstCharacter = [[self substringToIndex:1] lowercaseString];
    return [self stringByReplacingCharactersInRange:range withString:lowerFirstCharacter];
}

- (NSString *)uppercaseFirstCharacter
{
    NSRange range = NSMakeRange(0,1);
    NSString *upperFirstCharacter = [[self substringToIndex:1] uppercaseString];
    return [self stringByReplacingCharactersInRange:range withString:upperFirstCharacter];
}

- (NSString *)escapeHTML
{
    NSMutableString *result = [[NSMutableString alloc] initWithString:self];
    [result replaceOccurrencesOfString:@"&" withString:@"&amp;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"<" withString:@"&lt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@">" withString:@"&gt;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"\"" withString:@"&quot;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    [result replaceOccurrencesOfString:@"'" withString:@"&#39;" options:NSLiteralSearch range:NSMakeRange(0, [result length])];
    return result;
}

- (NSString *)stringByDecodingXMLEntities
{
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            goto finish;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            
            if (gotNumber) {
                [result appendFormat:@"%C", (unichar)charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        }
        else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    
finish:
    return result;
}

- (NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)md5ForUTF16{
    NSData *temp = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    
    UInt8 *cStr = (UInt8 *)[temp bytes];
    
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)[temp length], result);
    return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

-(NSString*)trimHtmlString
{
    NSString*string=self;
    NSRegularExpression *expr = [NSRegularExpression regularExpressionWithPattern:@"\\<([\\w*])\\>([^\\<]*)\\<\\/([\\w*])\\>" options:NSRegularExpressionCaseInsensitive error:nil];
    
    string = [expr stringByReplacingMatchesInString:string options:0 range:NSMakeRange(0, [string length]) withTemplate:@"$2"];
    return string;
}

//字符转大写
-(NSString *)uppercase{
    return [self uppercaseString];
}
//移除中文字符
- (NSString*)removeChineseStr
{
    NSString*string=self;
    for (int i=0; i<[self length]; i++) {
        int a=[self characterAtIndex:i];
        if (a>0x4e00 && a<0x9fff) {
            
            NSRange range=NSMakeRange(i, 1);
            if (range.location!=NSNotFound) {
                string=[string stringByReplacingCharactersInRange:range withString:@"汉"];
            }
            
        }
        
    }
    string=[string stringByReplacingOccurrencesOfString:@"汉" withString:@""];
    return string;
}
//移除空字符串
-(NSString*)removeNullStr{
    if ([self isValid]) {
        return self;
    }
    return @"0";
}

-(UIColor *)hpFontColor{
    
    NSInteger index = [self integerValue];
    if (index==1||index==7||index==13||index==14||index==15||index==16||index==17) {
        return [UIColor blackColor];
    }else if (index==3||index==4||index==5||index==6||index==9||index==10||index==11||index==12){
        return [UIColor whiteColor];
    }else if (index==20||index==21){
        return [UIColor redColor];
    }else if (index==22){
        return [UIColor blackColor];
    }else if (index==2||index==8){
        return [UIColor whiteColor];
    }else{
        return [UIColor whiteColor];
    }
}
/*
 *根据返回号牌类型返回号牌底色
 */
-(NSString*)hpColor{
    
    NSInteger index = [self integerValue];
    if (index==1||index==7||index==13||index==14||index==15||index==16||index==17) {
        return @"yellow";
    }else if (index==3||index==4||index==5||index==6||index==9||index==10||index==11||index==12){
        return @"black";
    }else if (index==20||index==21||index==22){
        return @"white";
    }else if (index==2||index==8){
        return @"blue";
    }else{
        return @"blue";
    }
}

/*
 *字符串替换
 *str 将要被替换的字符串
 *toStr 目标字符串
 */
-(NSString *)changeStr{

    if ([self length]>12) {
        return  [self substringToIndex:11];
    }
    return self;
}
/*
 * 判断是否符合密码规范
 */
-(BOOL)standardOfPwd{
    //判断是否包含数字
    int pwdLength = 0;
    NSString *regex1 = @".*[0-9]+.*";
    
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex1];
    
    if ([pred1 evaluateWithObject:self]) {
        pwdLength ++;
    }
    
    //判断是否包含小写字母
    NSString *regex2 = @".*[a-z]+.*";
    
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex2];
    
    if ([pred2 evaluateWithObject:self]) {
        pwdLength ++;
    }
    
    //判断是否包含大写字母
    NSString *regex3 = @".*[A-Z]+.*";
    
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex3];
    
    if ([pred3 evaluateWithObject:self]) {
        pwdLength ++;
    }
    
    //判断是否包含符号
    
    NSString * regex4 = @".*[\\W\\_]+.*";
    
    NSPredicate *pred4 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex4];
    
    if ([pred4 evaluateWithObject:self]) {
        pwdLength++;
    }
    if (pwdLength>=3&&[self length]>=8&&[self length]<=16) {
        return YES;
    }
    return NO;
}
/*
 *手机号码正则表达式验证
 */
- (BOOL)isMobileNumber
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[3278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    //    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSString  * PT = @"^((13[0-9])|(15[0-9])|(17[0-9])|(14[0-9])|(18[0-9]))\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextextpt = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PT];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    //    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:self] == YES)
        || ([regextestcm evaluateWithObject:self] == YES)
        || ([regextestcu evaluateWithObject:self] == YES)
        || ([regextextpt evaluateWithObject:self] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
/**
 * 功能:验证身份证是否合法
*/

-(BOOL)chk18PaperId{
    //判断位数
    if ([self length] != 15 && [self length] != 18) {
        return NO;
    }
    NSString *carid = self;
    long lSumQT =0;
    int R[] ={7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 };//加权因子
    unsigned char sChecker[11]={'1','0','X', '9', '8', '7', '6', '5', '4', '3', '2'};//校验码
    NSMutableString *mString = [NSMutableString stringWithString:self];    //将15位身份证号转换成18位
    if ([self length] == 15) {
        [mString insertString:@"19" atIndex:6];
        long p = 0;
        const char *pid = [mString UTF8String];
        for (int i=0; i<=16; i++){
            p += (pid[i]-48) * R[i];
        }
        int o = p%11;
        NSString *string_content = [NSString stringWithFormat:@"%c",sChecker[o]];
        [mString insertString:string_content atIndex:[mString length]];
        carid = mString;
    }
    
    //判断地区码
    NSString * sProvince = [carid substringToIndex:2];
    if (![self areaCode:sProvince]) {
        return NO;
    }
    
    //判断年月日是否有效
    
    //年份
    int strYear = [[self getStringWithRange:carid Value1:6 Value2:4] intValue];
    
    //月份
    int strMonth = [[self getStringWithRange:carid Value1:10 Value2:2] intValue];
    
    //日
    int strDay = [[self getStringWithRange:carid Value1:12 Value2:2] intValue];
    
    NSTimeZone *localZone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setTimeZone:localZone];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date=[dateFormatter dateFromString:[NSString stringWithFormat:@"%d-%d-%d 12:01:01",strYear,strMonth,strDay]];
    if (date == nil) {
        return NO;
    }
    const char *PaperId  = [carid UTF8String];
    
    //检验长度
    if( 18 != strlen(PaperId)) return -1;
    
    //校验数字
    for (int i=0; i<18; i++){
        if ( !isdigit(PaperId[i]) && !(('X' == PaperId[i] || 'x' == PaperId[i]) && 17 == i) )
        {
            return NO;
        }
    }
    
    
    //验证最末的校验码
    for (int i=0; i<=16; i++){
        lSumQT += (PaperId[i]-48) * R[i];
    }
    if (sChecker[lSumQT%11] != PaperId[17]){
        return NO;
        
    }
    
    return YES;
}
/**
 
 * 功能:获取指定范围的字符串
 
 * 参数:字符串的开始小标
 
 * 参数:字符串的结束下标
 
 */



-(NSString *)getStringWithRange:(NSString *)str Value1:(NSInteger)value1 Value2:(NSInteger )value2;{
    return [str substringWithRange:NSMakeRange(value1,value2)];
    
}



/**
 
 * 功能:判断是否在地区码内
 
 * 参数:地区码
 
 */

-(BOOL)areaCode:(NSString *)code

{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    if ([dic objectForKey:code] == nil) {
        return NO;
    }
    return YES;
    
}

-(int)passwordStrength
{

    int result = 0;
    if(self.length == 0){
        result +=0;
    }else if(self.length<8 && self.length>0){
        result +=5;
    }else if(self.length>10){
        result += 15;
    }else{
        result += 10;
    }
    BOOL bHave = NO;
    BOOL bAll = NO;
    NSString *capitalRegex = @".*[A-Z]+.*";
    NSString *smallRegex = @".*[a-z]+.*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", capitalRegex];
    BOOL capital = [pred evaluateWithObject:self];
    pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", smallRegex];
    BOOL small = [pred evaluateWithObject:self];
    if (!capital&&!small) {
        result +=0;
        bHave = NO;
    }else if(capital&&small)
    {
        result +=20;
        bAll = YES;
    }else
    {
        bAll = YES;
        result +=10;
    }
    
    //检测数字
    //NSString *numRegex = @".*[0-9]+.*";
    //pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    int digitalLen = [self countNum];
    BOOL bDigi = NO;
    if (digitalLen<=0) {
        result += 0;
        bDigi = NO;
    }else if (digitalLen>2)
    {
        result += 20;
        bDigi = YES;
    }
    //检查非单词字符
    BOOL bOther = NO;
    
    int otherLen = self.length - [self countNum] - [self countABC];
    
    if (otherLen == 0){ //没有非单词字符
        result += 0;
        bOther = NO;
    } else if (otherLen > 1){ //1个以上非单词字符
        result += 25;
        bOther = YES;
    } else {
        result += 10;
        bOther = YES;
    }
    
    if (bAll && bDigi && bOther){
        result += 5;
    }else if (bHave && bDigi && bOther){
        result += 3;
    }else if (bHave && bDigi){
        result += 2;
    }
    
    if(result<=33){
        result = 1;
    }else if(result<=50){
        result = 2;
    }else{
        result = 3;
    }
    return  result;
}

//查找单个数字出现的次数
- (NSInteger)countNum {
    int nLength = [self length];
    int numbercount = 0;
    for (int number = 0; number < nLength; number++)
    {
        unichar c = [self characterAtIndex:number];
        if (c >= '0'  &&  c <= '9')
        {
            numbercount++;
        }
    }
    
    return numbercount;
}

//查找单个字母的出现次数  包括大小写
- (NSInteger)countABC
{
    int nLength = [self length];
    int ABCcount = 0;
    for (int number = 0; number < nLength; number++)
    {
        unichar c = [self characterAtIndex:number];
        if (c >= 'A'  &&  c <= 'Z')
        {
            ABCcount++;
        }
        if (c >= 'a'  &&  c <= 'z')
        {
            ABCcount++;
        }
    }
    
    return ABCcount;
}

//去掉空格
-(NSString *)trim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}
-(NSString *)stringByReplacin:(NSString *)text withbegin:(int)begin withchangdu:(int)changdu{
    NSRange range=NSMakeRange(begin, changdu);
    NSString *idNumber=[text stringByReplacingCharactersInRange:range withString:@"******"];
    return idNumber;
}


-(NSString *)subtringWithStart:(NSInteger)start End:(NSInteger)end{
    
    if ([self length]<=0) {
        return self;
    }
    
    if (end > [self length]) {
        end = [self length];
    }
    if ([self length] - start <= 0)
        start = ([self length]-1) / 2 + 1;
    
    if (start > end) {
        end = [self length];
    }
    
    NSString *result = [self substringWithRange:NSMakeRange(0, start)];
    
    for (int i = start; i < end; i++) {
        result = [result stringByAppendingString:@"*"];
        
    }
    result = [result stringByAppendingString:[self substringFromIndex:end]];
    
    return result;
}

- (NSString *)filterWebString{

    if (![self isValid]) {
        return @"";
    }else{
        NSString *temp = self;
        temp = [temp replaceStringByRegular:@"<a[\\s\\S]*?>[\\s\\S]*?</a>" replaceStr:@""];
//        temp = [temp replaceStringByRegular:@"<span[\\s\\S]*?>[\\s\\S]*?>" replaceStr:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
        temp = [temp stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
        temp = [temp stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
        temp = [temp stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        temp = [temp stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"&quot;" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"&ldquo;" withString:@""];
        temp = [temp stringByReplacingOccurrencesOfString:@"&rdquo;" withString:@""];
        return temp;
    }
}

-(NSString *)replaceStringByRegular:(NSString *)regular replaceStr:(NSString *)rep
{
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:regular
                                                                           options:0
                                                                             error:&error];
    
    NSString* result = [regex stringByReplacingMatchesInString:self
                                                       options:0
                                                         range:NSMakeRange(0, self.length)
                                                  withTemplate:rep];
    
    return  result;
}

-(NSMutableAttributedString *)alllString:(NSString *)allstring andallcolor:(UIColor *)allcolor andallFont:(UIFont*)allfont subString:(NSString *)substring andColor:(UIColor*)subColor andsubFont:(UIFont *)subFont;
{
    NSDictionary *allDic = @{
                              NSFontAttributeName:allfont,
                              NSForegroundColorAttributeName:allcolor,
                              };
    NSDictionary *subDic = @{
                             NSFontAttributeName:subFont,
                             NSForegroundColorAttributeName:subColor,
                             };
    return [self genAttibuteStr:allstring newhandleStr:substring commonAttDic:allDic handleDic:subDic];

}
-(NSMutableAttributedString *) genAttibuteStr:(NSString *)str newhandleStr:(NSString *) subStr commonAttDic:(NSDictionary *)commonDic handleDic:(NSDictionary *)handleDic
{
//    if (<#condition#>) {
//        <#statements#>
//    }
    if (subStr == nil) {
        return nil;
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
    NSRange range = [str rangeOfString:subStr];
    NSString *str1 = [str substringToIndex:range.location];
    NSString *str2 = subStr;
    NSString *str3 = [str substringFromIndex:range.location + range.length];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str1 attributes: commonDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",str2] attributes: handleDic]];
    [attStr appendAttributedString:[[NSAttributedString alloc] initWithString:str3 attributes: commonDic]];
    return attStr;
}

@end
