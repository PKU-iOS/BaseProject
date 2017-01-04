//
//  StartInitialization.m
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "StartInitialization.h"
#import "GuideViewController.h"
#import "LoginViewController.h"
#import "RootViewController.h"

@implementation StartInitialization

- (void)dealloc {
    debugMethod();
}

+ (StartInitialization *)sharedInstance {
    static StartInitialization *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

#pragma mark - 

+ (void)setStartupMode:(STARTUP_MODE)startupMode {
    [[StartInitialization sharedInstance] startup:startupMode];
}

+ (void)removeGuideVC {
    [[StartInitialization sharedInstance] removeGuideVC];
}

+ (void)showLoginVC {
    [[StartInitialization sharedInstance] showLoginVC];
}

+ (void)showRootVC {
    [[StartInitialization sharedInstance] showRootVC];
}

#pragma mark -

- (void)startup:(STARTUP_MODE)mode {
    
#warning ======== 跳过引导页和登录页
//    [self showRootVC];
//    return;
    
    switch (mode) {
        case STARTUP_MODE_LOGIN_MUST:
        {
            if (![kUserDefaults boolForKey:kUD_USER_ONLINE]) {
                [self showLoginVC];
            }else {
                [self showRootVC];
            }
        }
            break;
        case STARTUP_MODE_LOGIN_OPTIONAL:
        {
            [self showRootVC];
        }
            break;
            
        default:
            break;
    }

    if (![kUserDefaults boolForKey:kUD_GUIDEPAGE_ISSKIP]) {
        // 显示引导视图
        [self showGuideVC];
    }
    
}

#pragma mark - 通知响应

- (void)removeGuideVC {
    UIWindow *window;
    UIWindow *guideWindow;
    for (UIWindow *view in [kApplication windows]) {
        if (kGuideWindowTag == view.tag) {
            guideWindow = view;
        }
        if (kRootWindowTag == view.tag) {
            window = view;
        }
    }
    if (guideWindow) {
        guideWindow.rootViewController = nil;
        guideWindow.windowLevel = UIWindowLevelNormal;
        [guideWindow resignKeyWindow];
        guideWindow = nil;
    }
    
    [window makeKeyAndVisible];

}


#pragma mark - 界面

- (void)showGuideVC {
    UIWindow *guideWindow;
    for (UIWindow *view in [kApplication windows]) {
        if (kGuideWindowTag == view.tag) {
            guideWindow = view;
        }
    }
    if (!guideWindow) {
        return;
    }
    guideWindow.windowLevel = UIWindowLevelAlert;
    
    GuideViewController *guideVC = [[GuideViewController alloc] init];
    guideWindow.rootViewController = guideVC;
    [guideWindow makeKeyAndVisible];
}

- (void)showLoginVC {
    LoginViewController *loginVC = [[LoginViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:loginVC];
    UIWindow *window;
    for (UIWindow *view in [kApplication windows]) {
        if (kRootWindowTag == view.tag) {
            window = view;
            break;
        }
    }
    if (!window) {
        return;
    }
    [window setRootViewController:nav];
    [window makeKeyAndVisible];
}

- (void)showRootVC {
    RootViewController *rootVC = [[RootViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:rootVC];
    UIWindow *window;
    for (UIWindow *view in [kApplication windows]) {
        if (kRootWindowTag == view.tag) {
            window = view;
            break;
        }
    }
    if (!window) {
        return;
    }
    [window setRootViewController:nav];
    [window makeKeyAndVisible];
}

@end
