//
//  NSDate+tmri.m
//  tmri
//
//  Created by Ch on 14/11/8.
//  Copyright (c) 2014年 Ch. All rights reserved.
//

#import "NSDate+tmri.h"

@implementation NSDate (tmri)

static NSCalendar *_calendar = nil;
static NSDateFormatter *_displayFormatter = nil;

+ (void)initializeStatics {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        @autoreleasepool {
            if (_calendar == nil) {
#if __has_feature(objc_arc)
                _calendar = [NSCalendar currentCalendar];
#else
                _calendar = [[NSCalendar currentCalendar] retain];
#endif
            }
            if (_displayFormatter == nil) {
                _displayFormatter = [[NSDateFormatter alloc] init];
            }
        }
    });
}

+ (NSCalendar *)sharedCalendar {
    [self initializeStatics];
    return _calendar;
}

+ (NSDateFormatter *)sharedDateFormatter {
    [self initializeStatics];
    return _displayFormatter;
}


//获取年月日如:19871127.
- (NSString *)getFormatYearMonthDay
{
    NSString *string = [NSString stringWithFormat:@"%lu%02lu%02lu",(unsigned long)[self getYear],(unsigned long)[self getMonth],(unsigned long)[self getDay]];
    return string;
}

//该日期是该年的第几周
- (int )getWeekOfYear
{
    int i;
    int year = (int)[self getYear];
    NSDate *date = [self endOfWeek];
    for (i = 1;[[date dateAfterDay:-7 * i] getYear] == year;i++)
    {
    }
    return i;
}

//返回day天后的日期(若day为负数,则为|day|天前的日期)
- (NSDate *)dateAfterDay:(int)day
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
    // NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:day];
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterDay;
}

//month个月后的日期
- (NSDate *)dateafterMonth:(int)month
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    return dateAfterMonth;
}

//获取日
- (NSUInteger)getDay
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:self];
    return [dayComponents day];
}

//获取月
- (NSUInteger)getMonth
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:self];
    return [dayComponents month];
}

//获取年
- (NSUInteger)getYear
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:self];
    return [dayComponents year];
}

//获取小时
- (int )getHour
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger hour = [components hour];
    return (int)hour;
}

//获取分钟
- (int)getMinute
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components minute];
    return (int)minute;
}
//获取秒
- (int)getSecond
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:self];
    NSInteger minute = [components second];
    return (int)minute;
}

- (int )getHour:(NSDate *)date
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger hour = [components hour];
    return (int)hour;
}

- (int)getMinute:(NSDate *)date
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSUInteger unitFlags =NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    NSInteger minute = [components minute];
    return (int)minute;
}
//在当前日期前几天
- (NSUInteger)daysAgo
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components day];
}

//返回指定YYYY-MM-dd格式的nsstring
-(NSString *)dateToDefaultStr
{
    return [self dateToStrByFormat:@"yyyy-MM-dd"];
}

//返回指定格式的nsstring
-(NSString *)dateToStrByFormat:(NSString *)formate
{
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:formate];
    return [mdf stringFromDate:self];
}

//午夜时间距今几天
- (NSUInteger)daysAgoAgainstMidnight
{
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    
    return (int)[midnight timeIntervalSinceNow] / (60*60*24) *-1;
}

- (NSString *)stringDaysAgo
{
    return [self stringDaysAgoAgainstMidnight:YES];
}

- (NSString *)stringDaysAgoAgainstMidnight:(BOOL)flag
{
    NSUInteger daysAgo = (flag) ? [self daysAgoAgainstMidnight] : [self daysAgo];
    NSString *text = nil;
    switch (daysAgo) {
        case 0:
            text = @"Today";
            break;
        case 1:
            text = @"Yesterday";
            break;
        default:
            text = [NSString stringWithFormat:@"%lu days ago", (unsigned long)daysAgo];
    }
    return text;
}

//返回一周的第几天(周末为第一天)
- (NSUInteger)weekday
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *weekdayComponents = [calendar components:(NSWeekdayCalendarUnit) fromDate:self];
    return [weekdayComponents weekday];
}

-(NSString *)weekdayString
{
    //这是当前的时间，其实这里可以是任意时间
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *comps;
    comps = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:self];
    int nowWeek = [comps weekday];
    NSString *weekStr = [[NSString alloc] init];
    switch (nowWeek) {
        case 1:
            weekStr = @"星期天";
            break;
        case 2:
            weekStr = @"星期一";
            break;
        case 3:
            weekStr = @"星期二";
            break;
        case 4:
            weekStr = @"星期三";
            break;
        case 5:
            weekStr = @"星期四";
            break;
        case 6:
            weekStr = @"星期五";
            break;
        case 7:
            weekStr = @"星期六";
            break;
        default:
            break;
    }
    return weekStr;
}

/**
 * 格式是yyyy-mm-dd hh:mm:ss
 */
+ (NSDate *)dateFromString:(NSString *)string
{
    return [NSDate dateFromString:string withFormat:[NSDate dbFormatString]];
}
/**
 * 格式是yyyy-mm-dd
 */
+ (NSDate *)dateSimpleFromString:(NSString *)string
{
    return [NSDate dateFromString:string withFormat:[NSDate dateFormatString]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format
{
    NSDateFormatter *inputFormatter = [[self class] sharedDateFormatter];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

+ (NSString *)stringFromDate:(NSDate *)date withFormat:(NSString *)format
{
    return [date stringWithFormat:format];
}

+ (NSString *)stringFromDate:(NSDate *)date
{
    return [date string];
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed
{
    /*
     * if the date is in today, display 12-hour time with meridian,
     * if it is within the last 7 days, display weekday name (Friday)
     * if within the calendar year, display as Jan 23
     * else display as Nov 11, 2008
     */
    
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                     fromDate:today];
    
    NSDate *midnight = [calendar dateFromComponents:offsetComponents];
    
    NSDateFormatter *displayFormatter = [[self class] sharedDateFormatter];
    NSString *displayString = nil;
    
    // comparing against midnight
    if ([date compare:midnight] == NSOrderedDescending) {
        if (prefixed) {
            [displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
        } else {
            [displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
        }
    } else {
        // check if date is within last 7 days
        NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
        [componentsToSubtract setDay:-7];
        NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        
        if ([date compare:lastweek] == NSOrderedDescending) {
            [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
        } else {
            // check if same calendar year
            NSInteger thisYear = [offsetComponents year];
            
            NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                                           fromDate:date];
            NSInteger thatYear = [dateComponents year];
            if (thatYear >= thisYear) {
                [displayFormatter setDateFormat:@"MMM d"];
            } else {
                [displayFormatter setDateFormat:@"MMM d, yyyy"];
            }
        }
        if (prefixed) {
            NSString *dateFormat = [displayFormatter dateFormat];
            NSString *prefix = @"'on' ";
            [displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
        }
    }
    
    // use display formatter to return formatted date string
    displayString = [displayFormatter stringFromDate:date];
    
    return displayString;
}

+ (NSString *)stringForDisplayFromDate:(NSDate *)date
{
    return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format
{
    NSDateFormatter *outputFormatter = [[self class] sharedDateFormatter];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

- (NSString *)string
{
    return [self stringWithFormat:[NSDate dateFormatString]];
}

- (NSString *)stringWithDateStyle:(NSDateFormatterStyle)dateStyle timeStyle:(NSDateFormatterStyle)timeStyle
{
    NSDateFormatter *outputFormatter = [[self class] sharedDateFormatter];
    [outputFormatter setDateStyle:dateStyle];
    [outputFormatter setTimeStyle:timeStyle];
    NSString *outputString = [outputFormatter stringFromDate:self];
    return outputString;
}
//返回周日的的开始时间
- (NSDate *)beginningOfWeek
{
    // largely borrowed from "Date and Time Programming Guide for Cocoa"
    // we'll use the default calendar and hope for the best
    
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDate *beginningOfWeek = nil;
    BOOL ok = [calendar rangeOfUnit:NSWeekCalendarUnit startDate:&beginningOfWeek
                           interval:NULL forDate:self];
    if (ok) {
        return beginningOfWeek;
    }
    
    // couldn't calc via range, so try to grab Sunday, assuming gregorian style
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
    /*
     Create a date components to represent the number of days to subtract from the current date.
     The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
     */
    NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
    [componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
    beginningOfWeek = nil;
    beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
    
    //normalize to midnight, extract the year, month, and day components and create a new date from those components.
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:beginningOfWeek];
    return [calendar dateFromComponents:components];
}
//返回当前天的年月日.
- (NSDate *)beginningOfDay
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                                               fromDate:self];
    return [calendar dateFromComponents:components];
}
//返回该月的第一天
- (NSDate *)beginningOfMonth
{
    return [self dateAfterDay:-(int)[self getDay] + 1];
}
//该月的最后一天
- (NSDate *)endOfMonth
{
    return [[[self beginningOfMonth] dateafterMonth:1] dateAfterDay:-1];
}
//返回当前周的周末
- (NSDate *)endOfWeek
{
    NSCalendar *calendar = [[self class] sharedCalendar];
    // Get the weekday component of the current date
    NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    // to get the end of week for a particular date, add (7 - weekday) days
    [componentsToAdd setDay:(7 - [weekdayComponents weekday])];
    NSDate *endOfWeek = [calendar dateByAddingComponents:componentsToAdd toDate:self options:0];
    
    return endOfWeek;
}

+ (NSString *)dateFormatString
{
    return @"yyyy-MM-dd";
}

+ (NSString *)timeFormatString
{
    return @"HH:mm:ss";
}

+ (NSString *)timestampFormatString
{
    return @"yyyy-MM-dd HH:mm:ss";
}

// preserving for compatibility
+ (NSString *)dbFormatString
{
    return [NSDate timestampFormatString];
}

- (NSDate *)nextDay {
    return [self nextDayInCalendar:[[self class] sharedCalendar]];
}

- (NSDate *)nextDayInCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)prevDay
{
    return [self prevDayInCalendar:[[self class] sharedCalendar]];
}

- (NSDate *)prevDayInCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:-1];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)currDay
{
    return [self currDayInCalendar:[[self class] sharedCalendar]];
}

- (NSDate *)currDayInCalendar:(NSCalendar *)calendar
{
    const unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:unitFlags fromDate:self];
    if (!components) {
        return self;
    }
    [components setHour:kBADayHour];
    NSDate *day = [calendar dateFromComponents:components];
    if (!day) {
        return self;
    }
    return day;
}

- (BOOL)sameDay:(NSDate *)anotherDate
{
    return [self sameDay:anotherDate inCalendar:[[self class] sharedCalendar]];
}

- (BOOL)sameDay:(NSDate *)anotherDate inCalendar:(NSCalendar *)calendar
{
    if (!anotherDate) {
        return NO;
    }
    const unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *c1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents *c2 = [calendar components:unitFlags fromDate:anotherDate];
    if (!c1 || !c2) {
        return NO;
    }
    return [c1 year] == [c2 year] && [c1 month] == [c2 month] && [c1 day] == [c2 day];
}

- (NSInteger)daysSinceNow
{
    return [self daysSinceNowInCalendar:[[self class] sharedCalendar]];
}

- (NSInteger)daysSinceNowInCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [calendar components:NSDayCalendarUnit fromDate:[NSDate date] toDate:self options:0];
    return [components day];
}

- (NSInteger)currHour
{
    return [self currHourInCalendar:[[self class] sharedCalendar]];
}

- (NSInteger)currHourInCalendar:(NSCalendar *)calendar
{
    NSDateComponents *components = [calendar components:NSHourCalendarUnit fromDate:self];
    return [components hour];
}

+(NSDate*)dateWithSeconds:(NSTimeInterval)second
{
    return   [NSDate dateWithTimeIntervalSince1970:second];
}

+(NSString*)dateStringWithSeconds:(float)second andFormat:(NSString*)format
{
    NSDate*date=[NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *dateFormatter = [[self class] sharedDateFormatter];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:date];
}

+(NSString*)dateStringWithSeconds:(float)second
{
    NSDate*date=[[NSDate alloc]initWithTimeIntervalSince1970:second];
    return [date string];
}

//获取date日期对应当月的天数
+(NSInteger)dateMonthNum:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger numberOfDaysInMonth = range.length;
    return numberOfDaysInMonth;
}

+ (NSString *)convertToWeekday:(NSString *)dateString
{
    NSDateFormatter *inputFormat = [[self class] sharedDateFormatter];
    [inputFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSDateFormatter *outputFormat = [[self class] sharedDateFormatter];
    [outputFormat setDateFormat:@"EEE"];
    outputFormat.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    
    NSDate *date = [inputFormat dateFromString:dateString];
    
    NSString *weekday = [outputFormat stringFromDate:date];
    
    return weekday;
}

//返回两个时间的时间差
-(NSString *)dateToDate:(NSDate *)date
{
    NSDateComponents *diff =[NSDate dateDiff:date toDate:self];
    if (diff.day > 0) {
        return [NSString stringWithFormat:@"%ld天%ld时",(long)diff.day,diff.hour];
    }else if(diff.hour >0 )
    {
        return [NSString stringWithFormat:@"%ld时%ld分",(long)diff.hour,diff.minute];
    }else if(diff.minute >0)
    {
        return [NSString stringWithFormat:@"%ld分%ld秒",(long)diff.minute,diff.second];
    }else
    {
        return [NSString stringWithFormat:@"%ld秒",(long)diff.second];
    }
}
/* 返回两个date的时间差 的NSDateComponents*/
+(NSDateComponents *) dateDiff:(NSDate *) fromDate toDate:(NSDate *) toDate
{
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |
    NSDayCalendarUnit | NSHourCalendarUnit |
    NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *compInfo = [sysCalendar components:unitFlags
                                                fromDate:fromDate
                                                  toDate:toDate
                                                 options:0];
    return compInfo;
}

@end
