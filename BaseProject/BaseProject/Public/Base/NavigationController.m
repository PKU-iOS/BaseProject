//
//  NavigationController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "NavigationController.h"
#import "BaseViewController.h"

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
    navBar.barTintColor = COLOR_Theme;
    // 隐藏shadowImage
//    navBar.translucent = NO;
//    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:[UIImage new]];
    
    NSDictionary *titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                          NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
    navBar.titleTextAttributes = titleTextAttributes;
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    item.tintColor = [UIColor whiteColor];
}

#pragma mark - 跳转

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"goBack"]
                                                                                           style:UIBarButtonItemStylePlain
                                                                                          target:self
                                                                                          action:@selector(goBack)];
    }
    [super pushViewController:viewController animated:animated];
}

@end


@implementation NavigationController (PushExt)

- (void)pushViewController:(NSString *)controllerName parameters:(id)parameters {
    Class class = NSClassFromString(controllerName);
    if (!class) {
        NSLog(@"没有该控制器 %@", controllerName);
    }
    else {
        UIViewController *toVC = [[class alloc] init];
        if (parameters) {
            if (![toVC isKindOfClass:[BaseViewController class]]) {
                NSLog(@"%@ 没有继承于 BaseViewController", controllerName);
                return;
            }
            
            ((BaseViewController *)toVC).params = [parameters copy];
        }
        [self pushViewController:toVC animated:YES];
    }
}

@end


@implementation NavigationController (GoBackExt)

- (void)goBack {
    [self goBackAnimated:YES];
}

- (void)goBackAnimated:(BOOL)animated {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:animated completion:nil];
    } else {
#if DEBUG
        NSAssert(self, @"self == nil");
#endif
        if (self) {
            [self popViewControllerAnimated:animated];
        }else {
            NSLog(@"没有导航控制器");
        }
    }
}

@end
