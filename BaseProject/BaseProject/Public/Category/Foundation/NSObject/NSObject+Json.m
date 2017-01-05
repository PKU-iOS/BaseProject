//
//  NSObject+Json.m
//  BaseProject
//
//  Created by Wmy on 2017/1/2.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "NSObject+Json.h"

@implementation NSObject (Json)

/**
 @brief 字典或数组格式化成json串

 @param object 字典或数组对象
 @return json串
 */
+ (NSString *)jsonObjectToJson:(id)object {
    NSError *err = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&err];
    if (err) {
        NSLog(@"====== json格式化失败: %@", err);
        return @"";
    }else {
        return [[NSString alloc] initWithData:jsonData
                                     encoding:NSUTF8StringEncoding];
    }
}

/**
 @brief 把JSON格式的字符串转换成字典
 
 @param jsonString JSON格式的字符串
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"====== json解析失败：%@",err);
        return nil;
    }
    return dic;
}

@end
