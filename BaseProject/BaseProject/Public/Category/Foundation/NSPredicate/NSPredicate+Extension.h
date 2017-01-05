//
//  NSPredicate+Extension.h
//  GNT
//
//  Created by Wmy on 2016/10/21.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

// 数字
UIKIT_EXTERN NSString *const kRegexNumber;
// 6-12位数字
UIKIT_EXTERN NSString *const kRegexNumber_6_12;
// 字母
UIKIT_EXTERN NSString *const kRegexAlpha;
// 数字字母
UIKIT_EXTERN NSString *const kRegexAlphaNumber;
// 数字字母下划线
UIKIT_EXTERN NSString *const kRegexAlpha_Number;
// 中文
UIKIT_EXTERN NSString *const kRegexChinese;

/**
 密码 数字字母组合8-10位/数字大小字母组合8-10位
 */
UIKIT_EXTERN NSString *const kRegexPassword;

/**
 身份证 15位/18位
 */
UIKIT_EXTERN NSString *const kRegexIDCard_15;
UIKIT_EXTERN NSString *const kRegexIDCard_18;

/**
 校验日期 “yyyy-mm-dd“格式的日期校验，已考虑平闰年
 */
UIKIT_EXTERN NSString *const kRegexDate;

/**
 校验金额 小数则精确到2位小数
 */
UIKIT_EXTERN NSString *const kRegexMoney;

/**
 校验IP地址 IP-v4地址/IP-v6地址
 */
UIKIT_EXTERN NSString *const kRegexIP_v4;
UIKIT_EXTERN NSString *const kRegexIP_v6;



@interface NSPredicate (Extension)

/**
 正则验证
 
 @param regex  正则表达式
 @param string 校验内容
 
 @return 校验结果
 */
+ (BOOL)predicateWithRegex:(NSString *)regex content:(NSString *)string;

@end
