//
//  DateFormatter.h
//  GNT
//
//  Created by Wmy on 16/8/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateFormatter : NSObject

/**
 *  按yyyy-MM-dd HH:mm:ss格式输出字符串格式输出字符串
 */
+ (NSString *)timestampStrFromDate:(NSDate *)date;

/**
 *  将dateStr字符串 按formatStr格式输出
 */
+ (NSString *)displayDateFormatWithDateStr:(NSString *)dateStr formatStr:(NSString *)formatStr;

/**
 *  通话列表显示时间格式化
 */
+ (NSString *)callListShowDateStr:(NSString *)dateStr;

/**
 *  otherDate是否是指定日期baseDate附近nearlyDays天内的日期
 */
+ (BOOL)isNearlyDays:(NSInteger)nearlyDays baseMonth:(NSDate *)baseDate otherDate:(NSDate *)otherDate;

/**
 *  秒 转成 时分秒 "00:00:00"
 */
+ (NSString *)timeformatFromSeconds:(NSInteger)seconds;
/**
 *  秒 转成 时分秒  "1时6分8秒" "6分8秒" "8秒"
 */
+ (NSString *)timeformatFromSeconds1:(NSInteger)seconds;


/**
 *  按yyyyMMddHHmmss格式输出日期
 */
+ (NSDate *)datetimeFromString:(NSString *)dateStr;

/**
 *  按yyyy-MM-dd HH:mm:ss格式输出字符串格式输出日期
 */
+ (NSDate *)datetimeFromTimestampStr:(NSString *)dateStr;



@end



#pragma mark - 当前项目日期格式化相关
@interface DateFormatter (AppTimeFormat)

/**
 短信首页显示日期格式化
 
 @param dateStr 完整日期字符串
 
 @return 格式后的显示日期字符串
 */
+ (NSString *)smsTimeFormatWithDateStr:(NSString *)dateStr;

/**
 短信详情显示日期格式化
 
 @param dateStr 完整日期字符串
 
 @return 格式后的显示日期字符串
 */
+ (NSString *)smsDetailTimeFormatWithDateStr:(NSString *)dateStr;

@end



#pragma mark - 时间间隔相关
@interface DateFormatter (TimeInterval)

/**
 与当天时间的时间间隔（e.g. 2016-06-08 12:00:00 与 2016-06-09 08:00:00 间隔为 0天20小时）
 
 @param formDateStr 起始时间
 
 @return NSDateComponents.day 得到间隔天数（一小时算 不足24小时则为0天）
 */
+ (NSDateComponents *)timeIntervalFromDate:(NSString *)formDateStr;

/**
 与当前时间的间隔天数 （忽略了小时 e.g. 2016-06-08 12:00:00 与 2016-06-09 08:00:00 的时间间隔为 1天）
 
 @param formDateStr 起始时间
 
 @return 得到间隔天数
 */
+ (NSInteger)timeDaysIntervalFromDate:(NSString *)formDateStr;

@end



#pragma mark - 时间星期相关
@interface DateFormatter (TimeWeek)

/**
 计算星期

 @param dateStr 日期

 @return 返回星期
 */
+ (NSString *)weekStringFromDateStr:(NSString *)dateStr;

@end

