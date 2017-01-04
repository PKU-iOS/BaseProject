//
//  StartInitialization.h
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface StartInitialization : NSObject

/**
 设置app启动类型

 @param startupMode 登录使用/可选登录使用
 */
+ (void)setStartupMode:(STARTUP_MODE)startupMode;

// 以下方法仅对启动类型为 STARTUP_MODE_LOGIN_MUST 的方式可使用，或使用通知的方式
//+ (void)showLoginVC;
//+ (void)showRootVC;

@end
