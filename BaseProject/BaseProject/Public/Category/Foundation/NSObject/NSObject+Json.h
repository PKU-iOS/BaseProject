//
//  NSObject+Json.h
//  BaseProject
//
//  Created by Wmy on 2017/1/2.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Json)

/**
 @brief 字典或数组格式化成json串
 
 @param object 字典或数组对象
 @return json串
 */
+ (NSString *)jsonObjectToJson:(id)object;

/**
 @brief 把JSON格式的字符串转换成字典
 
 @param jsonString JSON格式的字符串
 @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
