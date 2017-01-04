//
//  RootViewController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "RootViewController.h"
#import "NavigationController.h"
#import "SideViewController.h"
#import "RightViewController.h"
#import "MainViewController.h"


@interface RootViewController ()
@property (nonatomic, strong) SideViewController *sideVC;
@property (nonatomic, strong) RightViewController *rightVC;
@property (nonatomic, strong) MainViewController *mainVC;
@end

@implementation RootViewController

- (void)dealloc {
    debugMethod();
    [self removeObserver];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Root";
    
    [self addObserver];
    [self addSideVC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - observer

- (void)addObserver {
    [kNotifCenter addObserver:self selector:@selector(showRightVC:) name:kNC_SideVC_ShowRightNotification object:nil];
    [kNotifCenter addObserver:self selector:@selector(hideSide:) name:kNC_SideVC_HideRightNotification object:nil];
}

- (void)removeObserver {
    [kNotifCenter removeObserver:self name:kNC_SideVC_ShowRightNotification object:nil];
    [kNotifCenter removeObserver:self name:kNC_SideVC_HideRightNotification object:nil];
}


#pragma mark - common init

- (void)addSideVC {
    if (_sideVC && _sideVC.view.superview) {
        return;
    }
    [self addChildViewController:self.sideVC];
    [self.view insertSubview:_sideVC.view atIndex:99];
    [_sideVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(0);
    }];
}

#pragma mark - side event

- (void)showRightVC:(__unused NSNotification *)notification {
    [_sideVC showRightViewController:YES];
}

- (void)hideSide:(__unused NSNotification *)notification {
    [_sideVC hideSideViewController:YES];
}


#pragma mark - getter

- (SideViewController *)sideVC {
    if (_sideVC == nil) {
        _sideVC = [[SideViewController alloc] init];
        _sideVC.rootViewController  = self.mainVC;
        _sideVC.rightViewController = self.rightVC;
    }
    return _sideVC;
}

- (RightViewController *)rightVC {
    if (_rightVC == nil) {
        _rightVC = [[RightViewController alloc] init];
    }
    return _rightVC;
}

- (MainViewController *)mainVC {
    if (_mainVC == nil) {
        _mainVC = [[MainViewController alloc] init];
    }
    return _mainVC;
}


@end
