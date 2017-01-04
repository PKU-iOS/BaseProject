//
//  NotificationKey.h
//  BaseProject
//
//  Created by Wmy on 2017/1/2.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 视图显示控制
// 显示引导页
UIKIT_EXTERN NSString *const kNC_GuideVC_ShowNotification;
// 销毁引导页
UIKIT_EXTERN NSString *const kNC_GuideVC_RemoveNotification;

// 显示登录页
UIKIT_EXTERN NSString *const kNC_LoginVC_ShowNotification;
// 销毁登录页
UIKIT_EXTERN NSString *const kNC_LoginVC_RemoveNotification;

// 显示主视图
UIKIT_EXTERN NSString *const kNC_RootVC_ShowNotification;
// 隐藏主视图
UIKIT_EXTERN NSString *const kNC_RootVC_RemoveNotification;

// 显示右抽屉视图
UIKIT_EXTERN NSString *const kNC_SideVC_ShowRightNotification;
// 隐藏抽屉视图
UIKIT_EXTERN NSString *const kNC_SideVC_HideRightNotification;

// 登录成功
UIKIT_EXTERN NSString *const kNC_Login_SuccessNotification;

