//
//  NSDate+tmri.h
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kBADayHour 12

@interface NSDate (tmri)

+ (void)initializeStatics;

+ (NSCalendar *)sharedCalendar;
+ (NSDateFormatter *)sharedDateFormatter;

//获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay;
//该日期是该年的第几周
- (int )getWeekOfYear;
//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day;
//month个月后的日期
- (NSDate *)dateafterMonth:(int)month;


//获取日
- (NSUInteger)getDay;
//获取月
- (NSUInteger)getMonth;
//获取年
- (NSUInteger)getYear;
//获取小时
- (int )getHour;
//获取分钟
- (int)getMinute;
//获取秒
- (int)getSecond;


- (int)getHour:(NSDate *)date;
- (int)getMinute:(NSDate *)date;


//在当前日期前几天
- (NSUInteger)daysAgo;
//午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight;

- (NSString *)stringDaysAgo;
- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag;


//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday;
//返回星期几字符串
- (NSString *)weekdayString;

//转为NSString类型的
+ (NSDate *)dateFromString:(NSString *)string;
/**
 * 格式是yyyy-mm-dd
 */
+ (NSDate *)dateSimpleFromString:(NSString *)string;
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed;
+ (NSString *)stringForDisplayFromDate:(NSDate *)date;
- (NSString *)stringWithFormat:(NSString *)format;

- (NSString *)string;
- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle;

//返回周日的的开始时间
- (NSDate *)beginningOfWeek;
//返回当前天的年月日.
- (NSDate *)beginningOfDay;
//返回该月的第一天
- (NSDate *)beginningOfMonth;
//该月的最后一天
- (NSDate *)endOfMonth;
//返回当前周的周末
- (NSDate *)endOfWeek;

+ (NSString *)dateFormatString;
+ (NSString *)timeFormatString;
+ (NSString *)timestampFormatString;
+ (NSString *)dbFormatString;


- (NSDate *)nextDay;
- (NSDate *)nextDayInCalendar:(NSCalendar *)calendar;
- (NSDate *)prevDay;
- (NSDate *)prevDayInCalendar:(NSCalendar *)calendar;
- (NSDate *)currDay;
- (NSDate *)currDayInCalendar:(NSCalendar *)calendar;
- (BOOL)sameDay:(NSDate *)anotherDate;
- (BOOL)sameDay:(NSDate *)anotherDate inCalendar:(NSCalendar *)calendar;
- (NSInteger)daysSinceNow;
- (NSInteger)daysSinceNowInCalendar:(NSCalendar *)calendar;
- (NSInteger)currHour;
- (NSInteger)currHourInCalendar:(NSCalendar *)calendar;

+(NSDate*)dateWithSeconds:(NSTimeInterval)second;
+(NSString*)dateStringWithSeconds:(float)second andFormat:(NSString*)format;
+(NSString*)dateStringWithSeconds:(float)second;

//获取date日期对应当月的天数
+(NSInteger)dateMonthNum:(NSDate *)date;

//返回指定YYYY-MM-dd格式的nsstring
-(NSString *)dateToDefaultStr;

//返回指定格式的nsstring
-(NSString *)dateToStrByFormat:(NSString *)formate;

+ (NSString *)convertToWeekday:(NSString *)dateString;

//返回两个时间的时间差
-(NSString *)dateToDate:(NSDate *)date;

/* 返回两个date的时间差 的NSDateComponents*/
+(NSDateComponents *) dateDiff:(NSDate *) fromDate toDate:(NSDate *) toDate;

@end
