//
//  NavigationController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


+ (void)initialize {
    UINavigationBar *navBar = [UINavigationBar appearance];
//    navBar.barTintColor = [UIColor colorWithRed:73 green:200 blue:164 alpha:1.];
    navBar.barTintColor = [UIColor redColor];
    navBar.translucent = NO;
    
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                          NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    navBar.titleTextAttributes = titleTextAttributes;
}

#pragma mark - 跳转

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"go_back"]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(goBack)];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 通过控制器名称跳转

- (void)pushViewControllerWithName:(NSString *)controllerName {
    Class class = NSClassFromString(controllerName);
    if (class) {
        UIViewController *vc = [[class alloc] init];
        [self pushViewController:vc animated:YES];
    }else {
        NSLog(@"没有该控制器 %@", controllerName);
    }
}

#pragma mark - 返回

- (void)goBack {
    [self goBackAnimated:YES];
}

- (void)goBackAnimated:(BOOL)animated {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    } else {
        NSAssert(self, @"self.navigationController == nil");
        if (self) {
            [self popViewControllerAnimated:animated];
        }
    }
}

@end
