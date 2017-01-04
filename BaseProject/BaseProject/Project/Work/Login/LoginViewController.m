//
//  LoginViewController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "LoginViewController.h"
#import "StartInitialization.h"

@interface LoginViewController ()

- (IBAction)login:(id)sender;
@end

@implementation LoginViewController

- (void)dealloc {
    debugMethod();
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Login";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)login:(id)sender {
//    [kNotifCenter postNotificationName:kNC_RootVC_ShowNotification object:nil];
    [StartInitialization showRootVC];
}

@end
