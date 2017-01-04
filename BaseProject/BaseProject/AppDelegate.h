//
//  AppDelegate.h
//  BaseProject
//
//  Created by Wmy on 2016/11/11.
//  Copyright © 2016年 Wmy. All rights reserved.
//

/************************************************************************
 *  # 项目 结构图
 *  
 *  - 登录使用
 *
 *              --> Nav : LoginVC --> PreviewVC
 *             |
 *  window --> |                                 --> LeftVC
 *             |                                |
 *              --> Nav : RootVC --> SideVC --> |--> RightVC
 *                                              |
 *                                               --> TabbarVC/HomeVC
 *
 *
 *  - 非登录也可使用 需要登录时候单独push登录界面
 *
 *                               --> PreviewVC
 *                              |
 *  window --> Nav : RootVC --> |                 --> LeftVC
 *                              |                |
 *                               --> SideVC  --> |--> RightVC
 *                                               |
 *                                                --> TabbarVC/HomeVC
 *
 ************************************************************************/


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *guideWindow;

@end

