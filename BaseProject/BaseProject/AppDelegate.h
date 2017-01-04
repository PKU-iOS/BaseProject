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
 *
 *              --> LoginVC --> PreviewVC                          --> LeftVC
 *             |                                                  |
 *  window --> |                                  --> SideVC  --> |
 *             |                                 |                |
 *              --> Nav : RootVC --> MainVC  --> |                 --> RightVC
 *                                               |
 *                                                --> TabbarVC/HomeVC
 *
 *
 *                    --> LoginVC --> PreviewVC         --> LeftVC
 *                   |                                 |
 *  Nav : RootVC --> |                 --> SideVC  --> |
 *                   |                |                |
 *                    --> MainVC  --> |                 --> RightVC
 *                                    |
 *                                     --> TabbarVC/HomeVC
 *
 *
 *  - 非登录也可使用
 *                               --> PreviewVC                     --> LeftVC
 *                              |                                 |
 *  window --> Nav : RootVC --> |                 --> SideVC  --> |
 *                              |                |                |
 *                               --> MainVC  --> |                 --> RightVC
 *                                               |
 *                                                --> TabbarVC/HomeVC
 *
 
 
 *                    --> PreviewVC                     --> LeftVC
 *                   |                                 |
 *  Nav : RootVC --> |--> LoginVC      --> SideVC  --> |
 *                   |                |                |
 *                    --> MainVC  --> |                 --> RightVC
 *                                    |
 *                                     --> TabbarVC/HomeVC
 ************************************************************************/


#import <UIKit/UIKit.h>

typedef enum _STARTUP_MODE_ {
    STARTUP_MODE_LOGIN_MUST = 0,
    STARTUP_MODE_LOGIN_OPTIONAL = 1,
}STARTUP_MODE;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIWindow *guideWindow;

@end

