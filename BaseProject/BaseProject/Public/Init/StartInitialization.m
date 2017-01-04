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

+ (void)showLoginVC {
    [[StartInitialization sharedInstance] showLoginVC];
}

+ (void)showRootVC {
    [[StartInitialization sharedInstance] showRootVC];
}

#pragma mark -

- (void)startup:(STARTUP_MODE)mode {
    switch (mode) {
        case STARTUP_MODE_LOGIN_MUST:
        {
            [self addLoginVCNotification];
            [self addRootVCNotification];
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
        [self addGuideNotification];
        [self showGuideVC];
    }
    
}

#pragma mark - 通知
- (void)addGuideNotification {
    [kNotifCenter addObserver:self selector:@selector(nc_removeGuideVC)
                         name:kNC_GuideVC_RemoveNotification object:nil];
}

- (void)removeGuideNotification {
    [kNotifCenter removeObserver:self name:kNC_GuideVC_RemoveNotification object:nil];
}

- (void)addLoginVCNotification {
    [kNotifCenter addObserver:self selector:@selector(showLoginVC)
                         name:kNC_LoginVC_ShowNotification object:nil];
}

- (void)addRootVCNotification {
    [kNotifCenter addObserver:self selector:@selector(showRootVC)
                         name:kNC_RootVC_ShowNotification object:nil];
}


#pragma mark - 通知响应

- (void)nc_removeGuideVC {
    [self removeGuideNotification];
    UIWindow *window;
    UIWindow *guideWindow;
    for (UIWindow *view in [kApplication windows]) {
        if (100 == view.tag) {
            guideWindow = view;
        }
        if (88 == view.tag) {
            window = view;
        }
    }
    if (guideWindow) {
        guideWindow.rootViewController = nil;
        guideWindow.windowLevel = UIWindowLevelNormal;
        [guideWindow resignKeyWindow];
        guideWindow = nil;
        NSLog(@"%@", guideWindow);
    }
    
    [window makeKeyAndVisible];

}


#pragma mark - 界面

- (void)showGuideVC {
    UIWindow *guideWindow;
    for (UIWindow *view in [kApplication windows]) {
        if (100 == view.tag) {
            guideWindow = view;
        }
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
        if (88 == view.tag) {
            window = view;
            break;
        }
    }
    [window setRootViewController:nav];
    [window makeKeyAndVisible];
}

- (void)showRootVC {
    RootViewController *rootVC = [[RootViewController alloc] init];
    NavigationController *nav = [[NavigationController alloc] initWithRootViewController:rootVC];
    UIWindow *window;
    for (UIWindow *view in [kApplication windows]) {
        if (88 == view.tag) {
            window = view;
            break;
        }
    }
    [window setRootViewController:nav];
    [window makeKeyAndVisible];
}

@end
