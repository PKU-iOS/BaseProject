//
//  AppDefine.h
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h

/**
 应用版本号
 */
#define kVersionStr             [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 系统版本相关
 */
#define kSYSTEM_VERSION         ([[UIDevice currentDevice].systemVersion floatValue])

#define iOS7Later               (kSYSTEM_VERSION >= 7.0)
#define iOS8Later               (kSYSTEM_VERSION >= 8.0)
#define iOS9Later               (kSYSTEM_VERSION >= 9.0)

/**
 区分版本号执行对应代码
 
 #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
 // 系统版本号大于等于8.0
 
 #else
 // 系统版本号小于8.0
 
 #endif
 */


/**
 屏幕尺寸
 */
#define IS_IPAD                 (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE               (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA               ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH            ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT           ([[UIScreen mainScreen] bounds].size.height)

#define SCREEN_MAX_LENGTH       (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH       (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS     (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5             (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6             (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P            (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


/**
 颜色相关
 */
#define COLOR_RANDOM        RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define RGB(r,g,b)          RGBA(r, g, b, 1.0)
#define RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define COLOR_HEX(_hex)     [UIColor colorWithRed:((float)((_hex & 0xFF0000) >> 16)) / 255.0 \
                                green:((float)((_hex & 0xFF00)>> 8)) / 255.0 \
                                blue:((float) (_hex & 0xFF)) / 255.0 alpha:1.0f]
#define COLOR_HEX0(_hex, a) [UIColor colorWithRed:((float)((_hex & 0xFF0000) >> 16)) / 255.0 \
                                green:((float)((_hex & 0xFF00)>> 8)) / 255.0 \
                                blue:((float) (_hex & 0xFF)) / 255.0 alpha:(a)]

#define COLOR_BG            RGB(246, 246, 246)
#define COLOR_Theme         RGB(73, 200, 164)
#define COLOR_NavBar        COLOR_Theme
#define COLOR_Line          RGB(200, 200, 200)

#define COLOR_BtnNormal     COLOR_Theme
#define COLOR_BtnDisabled   [COLOR_Theme colorWithAlphaComponent:0.6]


/**
 *  字体
 */
#define AutoSize(_float)        (IS_IPHONE_6P?(_float * 1.26):(IS_IPHONE_6?(_float * 1.12):(_float)))
#define Font_Auto(_float)       ([UIFont systemFontOfSize:AutoSize(_float)])
#define BoldFont_Auto(_float)   ([UIFont boldSystemFontOfSize:AutoSize(_float)])


/**
 字符串非空异常处理
 
 @param _str String
 
 @return 非空字符串
 */
#define kNullString(_str)       (((_str == nil) || [_str isEqual:[NSNull null]] || [_str isEqualToString:@"(null)"]) ? @"" : _str)
/**
 字符串是否为空
 
 @param _str String
 
 @return bool YES-空串 NO-非空
 */
#define kIsNullString(_str)     (((_str == nil) || [_str isEqual:[NSNull null]] || [_str isEqual:@""] || [_str isEqualToString:@"(null)"]) ? YES : NO)


/**
 DEBUG
 */
#ifdef DEBUG
    #define NSLog(...) NSLog(__VA_ARGS__)
    #define debugMethod() NSLog(@"%s", __func__)
#else
    #define NSLog(...)
    #define debugMethod()
#endif


/**
 block
 
 @param block block
 @param ...   参数
 */
#define BLOCK_EXEC(block, ...)  if (block) { block(__VA_ARGS__); }


/**
 强/若引用
 */
#define WeakSelf(type)          __weak typeof(type) weak##type = type;
#define StrongSelf(type)        __strong typeof(type) type = weak##type;


/**
 通过 数据总条数 和 单页显示条数 计算出 共需显示多少页
 
 @param _totalNum 数据总条数
 @param _pageSize 单页显示条数
 
 @return 共需显示多少页
 */
#define TotalPage(_totalNum, _pageSize) ((_totalNum + _pageSize - 1) / _pageSize)


//-----------------------系统权限设置路径(iOS8以后适用)---------------------
// url
#define SettingURL      [NSURL URLWithString:UIApplicationOpenSettingsURLString]
// 调到设置
#define GoToSetting     if([[UIApplication sharedApplication] canOpenURL:SettingURL]) { \
                            [[UIApplication sharedApplication] openURL:SettingURL];}}


#endif /* AppDefine_h */
