//
//  LocalNotifManager.h
//  GNT
//
//  Created by Wmy on 2016/10/10.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalNotifManager : NSObject


+ (LocalNotifManager *)sharedInstance;

/**
 发送本地通知

 @param alertTitle 通知标题
 @param alertBody  通知内容
 @param userInfo   通知内容体 不显示在通知栏
 */
- (void)presentLocalNotification:(NSString *)alertTitle body:(NSString *)alertBody userInfo:(NSDictionary *)userInfo;

@end
