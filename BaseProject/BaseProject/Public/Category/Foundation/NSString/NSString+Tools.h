//
//  NSString+Tools.h
//  AssemProduct
//
//  Created by Wmy on 16/6/9.
//  Copyright © 2016年 分享通信. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Tools)

/**
 *  根据字典打印属性和取值
 */
+ (void)log:(NSDictionary *)dict;

/**
 *  设置行间距
 *
 *  @param space 行间距
 *  @param text  内容
 */
+ (NSAttributedString *)setLabelLineSpacing:(CGFloat)space andText:(NSString *)text;

@end
