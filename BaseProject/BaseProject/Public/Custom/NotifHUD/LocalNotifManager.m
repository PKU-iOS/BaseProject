//
//  LocalNotifManager.m
//  GNT
//
//  Created by Wmy on 2016/10/10.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "LocalNotifManager.h"
#import "WMYNotifHUD.h"
#import "MsgPlaySound.h"
#import <UserNotifications/UserNotifications.h>

@interface LocalNotifManager ()
@property (nonatomic, strong) NSTimer *currentTimer;
@end

@implementation LocalNotifManager

+ (LocalNotifManager *)sharedInstance {
    static LocalNotifManager *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

- (void)presentLocalNotification:(NSString *)alertTitle body:(NSString *)alertBody userInfo:(NSDictionary *)userInfo {
    
    NSLog(@"presentLocalNotification：%@, %@, %@", alertTitle, alertBody, userInfo);
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateBackground) {
        //后台运行中，通过本地通知显示消息

        UILocalNotification *currentNotification = [[UILocalNotification alloc] init];
        if (currentNotification) {
            _currentTimer = nil;
            if([[UIDevice currentDevice].systemVersion floatValue] >= 8){
                currentNotification.soundName = @"sms-received1.caf";
            }
            else{
                currentNotification.soundName = @"shortring.caf";
                _currentTimer = [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(localNotifContinue:) userInfo:currentNotification repeats:TRUE];
            }
            
            if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.2) {
                currentNotification.alertTitle = alertTitle;
            }
            currentNotification.alertBody = alertBody;
            
            //设置重复间隔
            currentNotification.repeatInterval = 0;
            currentNotification.alertAction = NSLocalizedString(@"查看", nil);
            currentNotification.userInfo = userInfo;
            //notification.applicationIconBadgeNumber = 1;
            
            //添加推送到uiapplication
            [[UIApplication sharedApplication] presentLocalNotificationNow:currentNotification];
            
            if(_currentTimer){
                [[NSRunLoop currentRunLoop] addTimer:_currentTimer forMode:NSRunLoopCommonModes];
            }
            
//            [MsgPlaySound msgPlaySystemSound];
//            [MsgPlaySound msgPlaySystemVibrate];
        }
    }
    else {
        // 前台运行中，用自定义通知条显示消息
        WMYNotifHUDModel *model = [[WMYNotifHUDModel alloc] init];
        model.title = alertTitle;
        model.body = alertBody;
        model.object = userInfo;
        [WMYNotifHUD showInfo:model];
    }
}

- (void)localNotifContinue:(NSTimer*)timer {
    UILocalNotification* notif = [timer userInfo];
    if (notif){
        NSLog(@"cancelling/presenting local notif");
        [[UIApplication sharedApplication] cancelLocalNotification:notif];
        [[UIApplication sharedApplication] presentLocalNotificationNow:notif];
    }
}


@end
