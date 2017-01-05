//
//  TabBarController.m
//  BaseProject
//
//  Created by Wmy on 2017/1/4.
//  Copyright © 2017年 Wmy. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)dealloc {
    debugMethod();
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addAllChildViewController];
    [self setTabBarCtrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


/**
 第一次初始化时调用 设置TabBar样式
 */
//+ (void)initialize {
//    // 隐藏shadowImage
//    [[UITabBar appearance] setBackgroundImage:[UIImage new]];
//    [[UITabBar appearance] setShadowImage:[UIImage new]];
//
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}
//                                             forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]}
//                                             forState:UIControlStateSelected];
//}

/**
 添加子控制器
 */
- (void)addAllChildViewController {
    
    NSArray *controllersName = @[
                                 @"AlbumViewController",
                                 @"LoadViewController",
                                 @"FileManagerViewController",
                                 @"CloudViewController"
                                 ];
    NSMutableArray *controllers = [NSMutableArray array];
    for (NSString *name in controllersName) {
        Class class = NSClassFromString(name);
        if (class)
        {
            UIViewController *vc = [[class alloc] init];
            NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
            [controllers addObject:nav];
        }
    }
    self.viewControllers = controllers;
}

/**
 *  初始化tabbar
 */
- (void)setTabBarCtrl {
    
    NSArray *itemArr = @[@"相册", @"传输", @"管理", @"云设备"];
    int i = 0;
    for (UITabBarItem *item in self.tabBar.items) {
        
        NSString *normalImgName = [NSString stringWithFormat:@"tabbar_normal_%d", i];
        UIImage *normalImg = [[UIImage imageNamed:normalImgName]
                              imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        NSString *selectedImgName = [NSString stringWithFormat:@"tabbar_selected_%d", i];
        UIImage *selectedImg = [[UIImage imageNamed:selectedImgName]
                                imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]}
                            forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : COLOR_Theme}
                            forState:UIControlStateSelected];
        
        self.tabBarItem = [item initWithTitle:itemArr[i] image:normalImg selectedImage:selectedImg];
        
        i++;
    }
}


@end
