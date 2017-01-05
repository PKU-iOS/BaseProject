//
//  NSPredicate+Extension.m
//  GNT
//
//  Created by Wmy on 2016/10/21.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "NSPredicate+Extension.h"

// 数字
NSString *const kRegexNumber = @"^\\d*$";
// 6-12位数字
NSString *const kRegexNumber_6_12 = @"^\\d{6,12}$";
// 字母
NSString *const kRegexAlpha = @"^[a-zA-Z]*$";
// 数字字母
NSString *const kRegexAlphaNumber = @"^[0-9a-zA-Z]*$";
// 数字字母下划线
NSString *const kRegexAlpha_Number = @"^\\w+$";
// 中文
NSString *const kRegexChinese = @"^[\u4e00-\u9fa5]{0,}$";


/**
 密码
    必须是包含字母和数字的组合，不能使用特殊字符，长度在8-10之间
        ^(?=.*\\d)(?=.*[a-zA-Z]).{8,10}$
    必须是包含大小写字母和数字的组合，不能使用特殊字符，长度在8-10之间
        ^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$"
 */
NSString *const kRegexPassword = @"^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{8,10}$";

/**
 身份证 15位/18位
 */
NSString *const kRegexIDCard_15 = @"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
NSString *const kRegexIDCard_18 = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";

/**
 校验日期 “yyyy-mm-dd“格式的日期校验，已考虑平闰年
 */
NSString *const kRegexDate = @"^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$";

/**
 校验金额 小数则精确到2位小数
 */
NSString *const kRegexMoney = @"^[0-9]+(.[0-9]{2})?$";

/**
 校验IP地址 IP-v4地址/IP-v6地址
 */
NSString *const kRegexIP_v4 = @"\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b";
NSString *const kRegexIP_v6 = @"(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))";



@implementation NSPredicate (Extension)

/**
 正则验证

 @param regex  正则表达式
 @param string 校验内容

 @return 校验结果
 */
+ (BOOL)predicateWithRegex:(NSString *)regex content:(NSString *)string {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:string];
}

@end
