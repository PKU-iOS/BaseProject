//
//  NSString+Extension.h
//  GNT
//
//  Created by Wmy on 16/8/28.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  MD5编码
 */
- (NSString *)MD5;

/**
 *  根据文字多少、格式大小绘制所需显示区域的CGSize
 */
- (CGSize)stringCGSizeWithTextSize:(CGSize)textSize andFont:(UIFont *)font;

@end
