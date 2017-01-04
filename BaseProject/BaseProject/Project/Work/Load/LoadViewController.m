//
//  LoadViewController.m
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "LoadViewController.h"

@interface LoadViewController ()

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"LoadVC";
    self.view.backgroundColor = [UIColor brownColor];
    
    // 隐藏导航条
    [self.navigationController setNavigationBarHidden:YES];
    
    // 关闭侧滑返回 下载需要关闭侧滑的类里
    // self.rt_disableInteractivePop = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
