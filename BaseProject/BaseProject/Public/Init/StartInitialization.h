//
//  StartInitialization.h
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSInteger kRootWindowTag  = 88;  // window的tag值
static NSInteger kGuideWindowTag = 99;  // 引导视图window的tag值

/**
 app启动类型
 
 - STARTUP_MODE_LOGIN_MUST : 登录后才可使用
 - STARTUP_MODE_LOGIN_OPTIONAL : 可选登录
 */
typedef enum _STARTUP_MODE_ {
    STARTUP_MODE_LOGIN_MUST = 0,
    STARTUP_MODE_LOGIN_OPTIONAL = 1,
}STARTUP_MODE;

@interface StartInitialization : NSObject

// 设置app启动类型
+ (void)setStartupMode:(STARTUP_MODE)startupMode;
// 移除引导界面
+ (void)removeGuideVC;
/* 以下方法仅对启动类型为 STARTUP_MODE_LOGIN_MUST 的方式可使用 */
// 显示登录界面
+ (void)showLoginVC;
// 显示跟视图界面
+ (void)showRootVC;

@end
