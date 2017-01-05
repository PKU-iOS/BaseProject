//
//  ProgressHUD.h
//  Workspace
//
//  Created by Wmy on 16/2/24.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHUD : NSObject

/** 加载中... */
+ (void)svp_showLoading;
/** 加载中 并自定义文字 */
+ (void)svp_showLoadingWithStatus:(NSString *)status;

/** 只显示文字1.2秒后消失 */
+ (void)svp_showStatus:(NSString *)status;
/** 显示文字delay秒后消失 */
+ (void)svp_showStatus:(NSString *)status afterDelayDismiss:(NSTimeInterval)delay;

/** 文字加图片 */
+ (void)svp_showSuccess:(NSString *)status;
+ (void)svp_showError:(NSString *)status;
+ (void)svp_showInfo:(NSString *)status;

/** use 28x28 white pngs */
+ (void)svp_showImage:(UIImage *)image status:(NSString*)status;

/** 更改显示文字 */
+ (void)svp_setStatus:(NSString *)status;

/** 显示状态控制 */
+ (BOOL)svp_isVisible;
+ (void)svp_popActivity;
+ (void)svp_dismiss;

@end
