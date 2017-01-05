//
//  UIImage+Extension.h
//  GNT
//
//  Created by Wmy on 16/8/28.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  根据颜色值返回UIImage
 *
 *  @param color 颜色值
 *
 *  @return 创建好的纯色image
 */
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  拉伸
 */
+ (UIImage *)resizableImage:(NSString *)imageName;
+ (UIImage *)resizableImage_auto:(NSString *)imageName;

/**
 *  拉伸至新尺寸
 */
- (UIImage *)resizedImage:(CGSize)newSize interpolationQuality:(CGInterpolationQuality)quality;

@end
