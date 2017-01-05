//
//  WMYNotifHUD.h
//  GNT
//
//  Created by Wmy on 2016/10/11.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>


/** 弹窗点击事件通知 */
UIKIT_EXTERN NSString *const kHUD_ClickCallBackNotification;
/** 弹窗点击事件回调 */
typedef void(^block_clickCallBack)(id anObject);

@class WMYNotifHUDModel;
@interface WMYNotifHUD : UIView

/**
 正在显示时 点击出发的回调
 */
@property (nonatomic, copy) block_clickCallBack clickCallBack;


/**
 显示弹窗

 @param model 弹窗内容模型
 */
+ (void)showInfo:(WMYNotifHUDModel *)model;

/**
 显示弹窗

 @param model         弹窗内容模型
 @param clickCallBack 弹窗点击事件回调
 */
+ (void)showInfo:(WMYNotifHUDModel *)model block:(block_clickCallBack)clickCallBack;

@end


#pragma mark -
#pragma mark - WMYNotifHUDModel

@interface WMYNotifHUDModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic) id object;
@end
