//
//  NSString+Extension.m
//  GNT
//
//  Created by Wmy on 16/8/28.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extension)

- (NSString *)MD5 {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

#pragma mark - 根据文字多少、格式大小绘制所需显示区域的CGSize
- (CGSize)stringCGSizeWithTextSize:(CGSize)textSize andFont:(UIFont *)font {
    
    CGSize tempSize = CGSizeZero;
    
    NSDictionary *contentDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                 font, NSFontAttributeName,
                                 [UIColor blackColor], NSForegroundColorAttributeName,
                                 nil];
    CGRect rect = [self boundingRectWithSize:textSize
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:contentDict
                                     context:nil];
    tempSize = rect.size;
    
    return tempSize;
}

@end
