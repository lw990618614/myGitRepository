//
//  NSString+tmri.h
//  main
//
//  Created by Ch on 14/11/18.
//  Copyright (c) 2014年 ChinaTelecom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (tmri)

- (BOOL)isBlank;
-( BOOL)isValid;
- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidUrl;
-(BOOL) isValidCode;//判断是不是有效的邮政编码
- (BOOL)isValidPassword;//判断密码是否是6—16位
-(BOOL) isValidNickName;//判断是不是有效的用户名
-(BOOL) isValidAdress;//判断是不是有效的地址
- (NSString *)removeWhiteSpacesFromString;

- (NSUInteger)countNumberOfWords;
- (NSArray *)words;//获取字符串中的单个字符
- (BOOL)containsString:(NSString *)subString;
- (BOOL)isBeginsWith:(NSString *)string;
- (BOOL)isEndssWith:(NSString *)string;

- (NSString *)replaceCharcter:(NSString *)olderChar withCharcter:(NSString *)newerChar;
- (NSString*)getSubstringFrom:(NSInteger)begin to:(NSInteger)end;
- (NSString *)addString:(NSString *)string;
- (NSString *)removeSubString:(NSString *)subString;

- (BOOL)containsOnlyLetters;
- (BOOL)containsOnlyNumbers;
- (BOOL)containsOnlyNumbersAndLetters;
- (BOOL)isInThisarray:(NSArray*)array;

+ (NSString *)getStringFromArray:(NSArray *)array;
- (NSArray *)getArray;

+ (NSString *)getMyApplicationVersion;
+ (NSString *)getMyApplicationName;

- (NSData *)convertToData;
+ (NSString *)getStringFromData:(NSData *)data;

- (NSString *)lowercaseFirstCharacter;
- (NSString *)uppercaseFirstCharacter;

- (NSString *)escapeHTML;//替换HTML代码
- (NSString *)stringByDecodingXMLEntities;

- (NSString *)md5;//普通的MD5加密
- (NSString *)md5ForUTF16;//UTF16的MD5加密

- (NSString*)trimHtmlString;//过滤HTML（待测试）

- (NSString*)removeChineseStr;

-(NSString*)removeNullStr;//移除空字符串

- (UIColor *)hpFontColor;//返回号牌文字颜色
- (NSString *)hpColor;//返回号牌颜色

-(NSString *)changeStr;//返回去掉时分秒的时间
-(NSString *)uppercase;//字符转大写
-(BOOL)standardOfPwd;//验证密码是否合法
- (BOOL)isMobileNumber;//手机号码正则验证

/**
 * 功能:验证身份证是否合法
 */
-(BOOL)chk18PaperId;

//密码的强弱规则 1：弱  2：中  3：强
-(int)passwordStrength;

//去除首尾空格
-(NSString *)trim;

-(NSString *)stringByReplacin:(NSString *)text withbegin:(int)begin withchangdu:(int)changdu;
//用户名只能输入数字 字母 和中文
-(BOOL)isValidUserName;
-(BOOL)isValidQQ;
//android用户id隐藏截取规则
-(NSString *)subtringWithStart:(NSInteger)start End:(NSInteger)end;

//过滤业务须知等等，需要webview显示的数据
- (NSString *)filterWebString;

//lable中不同的字体的颜色
-(NSMutableAttributedString *)alllString:(NSString *)allstring andallcolor:(UIColor *)allcolor andallFont:(UIFont*)allfont subString:(NSString *)substring andColor:(UIColor*)subColor andsubFont:(UIFont *)subFont;
@end
