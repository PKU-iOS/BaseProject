//
//  ProgressHUD.m
//  Workspace
//
//  Created by Wmy on 16/2/24.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ProgressHUD.h"
#import "SVProgressHUD.h"

@implementation ProgressHUD

+ (ProgressHUD *)sharedInstance {
    static ProgressHUD *_instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[ProgressHUD alloc] init];
        
//        [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
//        [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    });
    return _instance;
}

#pragma mark -
+ (void)svp_showLoading {
    [self sharedInstance];
    [SVProgressHUD showWithStatus:@"请稍后..."];
}

+ (void)svp_showLoadingWithStatus:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showWithStatus:status];
}

#pragma mark -
+ (void)svp_showStatus:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showImage:nil status:status];
    [self performSelector:@selector(svp_dismiss) withObject:nil afterDelay:1.0f];
}

+ (void)svp_showStatus:(NSString *)status afterDelayDismiss:(NSTimeInterval)delay {
    [self sharedInstance];
    [SVProgressHUD showImage:nil status:status];
    [self performSelector:@selector(svp_dismiss) withObject:nil afterDelay:delay];
}

#pragma mark -
+ (void)svp_showSuccess:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showSuccessWithStatus:status];
}

+ (void)svp_showError:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)svp_showInfo:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showInfoWithStatus:status];
}

#pragma mark -
+ (void)svp_showImage:(UIImage *)image status:(NSString *)status {
    [self sharedInstance];
    [SVProgressHUD showImage:image status:status];
}

#pragma mark -
+ (void)svp_setStatus:(NSString *)status {
    [SVProgressHUD setStatus:status];
}

#pragma mark -

+ (BOOL)svp_isVisible {
    return [SVProgressHUD isVisible];
}

+ (void)svp_popActivity {
    [SVProgressHUD popActivity];
}

+ (void)svp_dismiss {
    [SVProgressHUD dismiss];
}

@end
