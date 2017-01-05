//
//  DateFormatter.m
//  GNT
//
//  Created by Wmy on 16/8/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "DateFormatter.h"

@implementation DateFormatter

+ (NSString *)timestampStrFromDate:(NSDate *)date
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}


+ (NSString *)displayDateFormatWithDateStr:(NSString *)dateStr formatStr:(NSString *)formatStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formatter dateFromString:dateStr];
    
    NSCalendar *calendar    = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags     = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:date];
    NSInteger year  = [comps year];
    NSInteger month = [comps month];
    NSInteger day   = [comps day];
    
    if ([formatStr isEqualToString:@"%lu-%lu"]) {
        return [NSString stringWithFormat:@"%lu-%lu", year, month];
    }else {
        return [NSString stringWithFormat:@"%lu-%lu-%lu", year, month, day];
    }
}

/**
 *  通话列表显示时间格式化
 */
+ (NSString *)callListShowDateStr:(NSString *)dateStr {
    
    if (!dateStr || dateStr.length != 19) return @"";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *showDate = [formatter dateFromString:dateStr];
    NSDate *currentDate = [NSDate date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit;
    
    NSDateComponents *comps1 = [[NSDateComponents alloc] init];
    NSDateComponents *comps2 = [[NSDateComponents alloc] init];
    comps1 = [calendar components:unitFlags fromDate:showDate];
    comps2 = [calendar components:unitFlags fromDate:currentDate];
    
    NSInteger year1  = [comps1 year];
    NSInteger month1 = [comps1 month];
    NSInteger day1   = [comps1 day];
    
    NSInteger year2  = [comps2 year];
    NSInteger month2 = [comps2 month];
    NSInteger day2   = [comps2 day];
    
    if (year1 != year2) {
        // 间隔跨年
        return [NSString stringWithFormat:@"%ld/%ld/%ld", year1, month1, day1];
    }
    if (month1 == month2 && day1 == day2) {
        // 当天
        return [dateStr substringWithRange:NSMakeRange(11, 5)];
    }
    if ([self isNearlyDays:1 baseMonth:[NSDate date] otherDate:showDate]) {
        // 昨天
        return @"昨天";
    }
    
    // 间隔1天以上
    return [NSString stringWithFormat:@"%ld/%ld", month1, day1];

}

/**
 *  otherDate是否是指定日期baseDate附近nearlyDays天内的日期
 */
+ (BOOL)isNearlyDays:(NSInteger)nearlyDays baseMonth:(NSDate *)baseDate otherDate:(NSDate *)otherDate {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *baseDateComponents = [calendar components:unitFlags
                                                       fromDate:baseDate];
    NSDateComponents *otherDateComponents = [calendar components:unitFlags
                                                        fromDate:otherDate];
    
    
    return [baseDateComponents year] == [otherDateComponents year] &&
    [baseDateComponents month] == [otherDateComponents month] &&
    labs([baseDateComponents day] - [otherDateComponents day]) <= nearlyDays;
}

/**
 *  秒 转成 时分秒 "00:00:00"
 */
+ (NSString *)timeformatFromSeconds:(NSInteger)seconds {
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", seconds / 3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (seconds % 3600) / 60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds % 60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    
    return format_time;
}

/**
 *  秒 转成 时分秒  "1时6分8秒" "6分8秒" "8秒"
 */
+ (NSString *)timeformatFromSeconds1:(NSInteger)seconds {
    if (seconds <= 0) {
        return @"0秒";
    }
    NSInteger hour = seconds / 3600;
    NSInteger minute = (seconds % 3600) / 60;
    NSInteger second = seconds % 60;
    
    if (hour > 0) {
        return [NSString stringWithFormat:@"%lu时%lu分%lu秒", hour, minute, second];
    }
    if (minute > 0) {
        return [NSString stringWithFormat:@"%lu分%lu秒", minute, second];
    }
    return [NSString stringWithFormat:@"%lu秒", second];
}


+ (NSDate *)datetimeFromString:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    return [formatter dateFromString:dateStr];
}

+ (NSDate *)datetimeFromTimestampStr:(NSString *)dateStr
{
    if (!dateStr) return nil;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Harbin"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter dateFromString:dateStr];
}



@end



#pragma mark - 当前项目日期格式化相关
@implementation DateFormatter (AppTimeFormat)

+ (NSString *)smsTimeFormatWithDateStr:(NSString *)dateStr {
    if (dateStr.length != [@"yyyy-MM-dd HH:mm:ss" length]) {
        return @"";
    }
    
    // 间隔的天数
    NSInteger days = [DateFormatter timeDaysIntervalFromDate:dateStr];
    // 星期
    NSString *week = [DateFormatter weekStringFromDateStr:dateStr];
    
    // 得到年月日时分秒
    NSDate *date = [DateFormatter datetimeFromTimestampStr:dateStr];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger year   = [comps year];
    NSInteger month  = [comps month];
    NSInteger day    = [comps day];
    NSInteger hour   = [comps hour];
    NSInteger minute = [comps minute];
    
    if (days == 0) {
        return [NSString stringWithFormat:@"%02lu:%02lu", hour, minute];
    }
    else if (days == 1) {
        return @"昨天";
    }
    else if (days < 7) {
        return [NSString stringWithFormat:@"星期%@", week];
    }
    else {
        return [NSString stringWithFormat:@"%lu/%lu/%lu", year, month, day];
    }
    
}

+ (NSString *)smsDetailTimeFormatWithDateStr:(NSString *)dateStr {
    if (dateStr.length != [@"yyyy-MM-dd HH:mm:ss" length]) {
        return @"";
    }
    
    // 间隔的天数
    NSInteger days = [DateFormatter timeDaysIntervalFromDate:dateStr];
    // 星期
    NSString *week = [DateFormatter weekStringFromDateStr:dateStr];
    
    // 得到年月日时分秒
    NSDate *date = [DateFormatter datetimeFromTimestampStr:dateStr];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:date];
    
    NSInteger year   = [comps year];
    NSInteger month  = [comps month];
    NSInteger day    = [comps day];
    NSInteger hour   = [comps hour];
    NSInteger minute = [comps minute];
    
    if (days == 0) {
        return [NSString stringWithFormat:@"今天 %02lu:%02lu", hour, minute];
    }
    else if (days == 1) {
        return [NSString stringWithFormat:@"昨天 %02lu:%02lu", hour, minute];
    }
    else if (days < 7) {
        return [NSString stringWithFormat:@"星期%@ %02lu:%02lu", week, hour, minute];
    }
    else {
        return [NSString stringWithFormat:@"%lu/%lu/%lu 星期%@ %02lu:%02lu", year, month, day, week, hour, minute];
    }
    
}


@end



#pragma mark - 时间间隔相关
@implementation DateFormatter (TimeInterval)

/**
 与当天时间的时间间隔（e.g. 2016-06-08 12:00:00 与 2016-06-09 08:00:00 间隔为 0天20小时）
 
 @param formDateStr 起始时间
 
 @return NSDateComponents.day 得到间隔天数（一小时算 不足24小时则为0天）
 */
+ (NSDateComponents *)timeIntervalFromDate:(NSString *)formDateStr {
    
    NSDate *fromDate = [DateFormatter datetimeFromTimestampStr:formDateStr];
    NSDate *toDate = [NSDate date];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit
                                                   fromDate:fromDate
                                                     toDate:toDate
                                                    options:0];
    
    return dayComponents;
}

/**
 与当前时间的间隔天数 （忽略了小时 e.g. 2016-06-08 12:00:00 与 2016-06-09 08:00:00 的时间间隔为 1天）
 
 @param formDateStr 起始时间
 
 @return 得到间隔天数
 */
+ (NSInteger)timeDaysIntervalFromDate:(NSString *)formDateStr {
    
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:2];
    [gregorian rangeOfUnit:NSDayCalendarUnit
                 startDate:&fromDate
                  interval:NULL
                   forDate:[DateFormatter datetimeFromTimestampStr:formDateStr]];
    [gregorian rangeOfUnit:NSDayCalendarUnit
                 startDate:&toDate
                  interval:NULL
                   forDate:[NSDate date]];
    NSDateComponents *dayComponents = [gregorian components:NSDayCalendarUnit
                                                   fromDate:fromDate
                                                     toDate:toDate
                                                    options:0];
    
    return dayComponents.day;
}

@end


#pragma mark - 时间星期相关
@implementation DateFormatter (TimeWeek)

+ (NSString *)weekStringFromDateStr:(NSString *)dateStr {
    
    NSArray *weekdays = [NSArray arrayWithObjects:[NSNull null], @"日", @"一", @"二", @"三", @"四", @"五", @"六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit
                                                  fromDate:[DateFormatter datetimeFromTimestampStr:dateStr]];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

@end

