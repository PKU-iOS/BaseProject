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
#define kAPP_VERSION_STR        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/**
 系统版本相关
 */
#define kSYSTEM_VERSION         ([[UIDevice currentDevice].systemVersion floatValue])

#define iOS7Later               (kSYSTEM_VERSION >= 7.0)
#define iOS8Later               (kSYSTEM_VERSION >= 8.0)
#define iOS9Later               (kSYSTEM_VERSION >= 9.0)
#define iOS10Later              (kSYSTEM_VERSION >= 10.0)

/**
 区分版本号执行对应代码
 
 #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    // 系统版本号大于等于8.0
 #else
    // 系统版本号小于8.0
 #endif
 
 */


/**
 真机/模拟器
 
 #if TARGET_OS_IPHONE
    //真机
 #endif
 #if TARGET_IPHONE_SIMULATOR
    //模拟器
 #endif
 */


/**
 沙盒路径
 */
#define kFOLDER_PATH_CACHES     [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]


/**
 常用单利
 */
#define kApplication            [UIApplication sharedApplication]
#define kKeyWindow              [UIApplication sharedApplication].keyWindow
#define kAppDelegate            [UIApplication sharedApplication].delegate
#define kUserDefaults           [NSUserDefaults standardUserDefaults]
#define kNotifCenter            [NSNotificationCenter defaultCenter]

/**
 屏幕尺寸
 */
#define kSCREEN_WIDTH           ([[UIScreen mainScreen] bounds].size.width)
#define kSCREEN_HEIGHT          ([[UIScreen mainScreen] bounds].size.height)
#define kSCREEN_MAX_LENGTH      (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define kSCREEN_MIN_LENGTH      (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define kIS_IPAD                (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIS_IPHONE              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIS_RETINA              ([[UIScreen mainScreen] scale] >= 2.0)

#define kIS_IPHONE_4_OR_LESS    (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define kIS_IPHONE_5            (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define kIS_IPHONE_6            (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define kIS_IPHONE_6P           (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)


/**
 颜色相关
 */
#define COLOR_RANDOM            RGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define RGB(_r, _g, _b)              RGBA(_r, _g, _b, 1.0)
#define RGBA(_r, _g, _b, _a)    [UIColor colorWithRed:(_r)/255.0 green:(_g)/255.0 blue:(_b)/255.0 alpha:(_a)]
#define COLOR_HEX(_hex)         [UIColor colorWithRed:((float)((_hex & 0xFF0000) >> 16)) / 255.0 \
                                    green:((float)((_hex & 0xFF00)>> 8)) / 255.0 \
                                    blue:((float) (_hex & 0xFF)) / 255.0 alpha:1.0f]
#define COLOR_HEX0(_hex, _a)    [UIColor colorWithRed:((float)((_hex & 0xFF0000) >> 16)) / 255.0 \
                                    green:((float)((_hex & 0xFF00)>> 8)) / 255.0 \
                                    blue:((float) (_hex & 0xFF)) / 255.0 alpha:(_a)]

#define COLOR_BG                RGB(246, 246, 246)
#define COLOR_Theme             RGB(73, 200, 164)
#define COLOR_NavBar            COLOR_Theme
#define COLOR_Line              RGB(200, 200, 200)

#define COLOR_BtnNormal         COLOR_Theme
#define COLOR_BtnDisabled       [COLOR_Theme colorWithAlphaComponent:0.6]


/**
 字符串排空
 */
#define kStringNonnull(_str)    (([_str isKindOfClass:[NSNull class]] \
                                    || [_str isEqualToString:@"(null)"] \
                                    || _str == nil) \
                                    ? @"" : _str)
/**
 字符串是否为空
 */
#define kStringIsEmpty(_str)    (([_str isKindOfClass:[NSNull class]] \
                                    || [_str isEqualToString:@"(null)"] \
                                    || _str == nil \
                                    || [_str length] < 1) \
                                    ? YES : NO )
/**
 数组是否为空
 */
#define kArrayIsEmpty(_array)   (([_array isKindOfClass:[NSNull class]] \
                                    || _array == nil \
                                    || _array.count == 0) \
                                    ? YES : NO)
/**
 字典是否为空
 */
#define kDictionaryIsEmpty(_dict)   (([_dict isKindOfClass:[NSNull class]] \
                                        || _dict == nil \
                                        || _dict.allKeys == 0) \
                                        ? YES : NO)
/**
 空对象
 */
#define kObjectIsEmpty(_object) ((_object == nil \
                                    || [_object isKindOfClass:[NSNull class]] \
                                    || ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
                                    || ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0)) \
                                    ? YES : NO)


/**
 DEBUG
 */
#ifdef DEBUG
    #define NSLog(...) NSLog(@"=== log:\n%s 第%d行 \n%@\n\n", \
                        __func__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
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
#define BLOCK_EXEC(block, ...)      if (block) { block(__VA_ARGS__); }


/**
 强/若引用
 */
#define kWeakSelf(_type)            __weak typeof(_type) weak##type = _type;
#define kStrongSelf(_type)          __strong typeof(_type) type = weak##_type;


/**
 通过 数据总条数 和 单页显示条数 计算出 共需显示多少页
 
 @param _totalNum 数据总条数
 @param _pageSize 单页显示条数
 
 @return 共需显示多少页
 */
#define kTotalPage(_totalNum, _pageSize)    ((_totalNum + _pageSize - 1) / _pageSize)


/**
 由角度转换弧度
 */
#define kDegreesToRadian(_x)        (M_PI * (_x) / 180.0)

/**
 由弧度转换角度
 */
#define kRadianToDegrees(_radian)   (_radian * 180.0) / (M_PI)


//-----------------------系统权限设置路径(iOS8以后适用)---------------------
// 设置url
#define kSEETING_URL        [NSURL URLWithString:UIApplicationOpenSettingsURLString]
// 调到设置
#define kGOTO_SETTING       if([[UIApplication sharedApplication] canOpenURL:SettingURL]) { \
                                [[UIApplication sharedApplication] openURL:SettingURL];}}


#endif /* AppDefine_h */
