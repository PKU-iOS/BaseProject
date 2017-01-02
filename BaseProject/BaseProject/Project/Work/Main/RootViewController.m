//
//  RootViewController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "RootViewController.h"
#import "PreviewViewController.h"
#import "LoginViewController.h"
#import "MainViewController.h"

/**
 启动加载方式
 
 - StartLoadTypeLoginMust:     必须登录才可使用
 - StartLoadTypeLoginOptional: 可选登录
 */
typedef NS_ENUM(NSInteger, StartLoadType) {
    StartLoadTypeLoginMust = 0,
    StartLoadTypeLoginOptional
};


@interface RootViewController ()
@property (nonatomic) StartLoadType loadType;
@property (nonatomic, strong) PreviewViewController *previewVC;
@property (nonatomic, strong) LoginViewController *loginVC;
@property (nonatomic, strong) MainViewController *mainVC;
@end

@implementation RootViewController

- (void)dealloc {
    debugMethod();
    [self removeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addObserver];
    
    self.loadType = StartLoadTypeLoginOptional;
    [self _start];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - addObserver

- (void)addObserver {
    
    [kNotifCenter addObserver:self
                     selector:@selector(showPreviewVC)
                         name:kNC_GuideVC_ShowNotification
                       object:nil];
    [kNotifCenter addObserver:self
                     selector:@selector(removePreviewVC)
                         name:kNC_GuideVC_RemoveNotification
                       object:nil];
    
    [kNotifCenter addObserver:self
                     selector:@selector(showLoginVC)
                         name:kNC_LoginVC_ShowNotification
                       object:nil];
    [kNotifCenter addObserver:self
                     selector:@selector(removeLoginVC)
                         name:kNC_LoginVC_RemoveNotification
                       object:nil];
    
    [kNotifCenter addObserver:self
                     selector:@selector(showMainVC)
                         name:kNC_MainVC_ShowNotification
                       object:nil];
    [kNotifCenter addObserver:self
                     selector:@selector(removeMainVC)
                         name:kNC_MainVC_RemoveNotification
                       object:nil];
    
    
}

- (void)removeObserver {
    [kNotifCenter removeObserver:self name:kNC_GuideVC_ShowNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_GuideVC_RemoveNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_LoginVC_ShowNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_LoginVC_RemoveNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_MainVC_ShowNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_MainVC_RemoveNotification object:nil];
}


#pragma mark - 启动展示内容

- (void)_start {
    
    switch (_loadType) {
        case StartLoadTypeLoginMust:
        {
            if (![kUserDefaults boolForKey:kUD_USER_ONLINE]) {
                // 显示登录视图 登录成功后 先显示main视图 然后移除login视图
                [self showLoginVC];
            }else {
                [self showMainVC];
            }
            
        }
            break;
            
        case StartLoadTypeLoginOptional:
        {
            // 显示主视图
            [self showMainVC];
        }
            break;
            
        default:
            break;
    }
    
    
    if (![kUserDefaults boolForKey:kUD_GUIDEPAGE_ISSKIP]) {
        // 显示引导视图
        [self showPreviewVC];
    }
    
}


#pragma mark - 引导视图

- (void)showPreviewVC {
    if (_previewVC && _previewVC.view.superview) {
        return;
    }
    [self addChildViewController:self.previewVC];
    [self.view insertSubview:_previewVC.view atIndex:99];
    [_previewVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

- (void)removePreviewVC {
    if (!_previewVC || !_previewVC.view.superview) {
        return;
    }
    
    [UIView animateWithDuration:0.6 animations:^{
        _previewVC.view.alpha = 0.01;
    } completion:^(BOOL finished) {
        [_previewVC.view removeFromSuperview];
        [_previewVC removeFromParentViewController];
        _previewVC = nil;
    }];
}

#pragma mark - 登录视图

- (void)showLoginVC {
    if (_loginVC && _loginVC.view.superview) {
        return;
    }
    [self addChildViewController:self.loginVC];
    [self.view insertSubview:_loginVC.view atIndex:2];
    [_loginVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

- (void)removeLoginVC {
    if (!_loginVC || !_loginVC.view.superview) {
        return;
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        _loginVC.view.alpha = 0.01;
    } completion:^(BOOL finished) {
        [_loginVC.view removeFromSuperview];
        [_loginVC removeFromParentViewController];
        _loginVC = nil;
    }];
}


#pragma mark - 主视图

- (void)showMainVC {
    if (_mainVC && _mainVC.view.superview) {
        return;
    }
    
    [self addChildViewController:self.mainVC];
    [self.view insertSubview:_mainVC.view atIndex:0];
    [_mainVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

- (void)removeMainVC {
    if (!_mainVC || !_mainVC.view.superview) {
        return;
    }
    
    [_mainVC.view removeFromSuperview];
    [_mainVC removeFromParentViewController];
    _mainVC = nil;
}



#pragma mark - getter

- (MainViewController *)mainVC {
    if (_mainVC == nil) {
        _mainVC = [[MainViewController alloc] init];
    }
    return _mainVC;
}

- (LoginViewController *)loginVC {
    if (_loginVC == nil) {
        _loginVC = [[LoginViewController alloc] init];
    }
    return _loginVC;
}

- (PreviewViewController *)previewVC {
    if (_previewVC == nil) {
        _previewVC = [[PreviewViewController alloc] init];
    }
    return _previewVC;
}


@end
