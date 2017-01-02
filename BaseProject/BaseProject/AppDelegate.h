//
//  AppDelegate.h
//  BaseProject
//
//  Created by Wmy on 2016/11/11.
//  Copyright © 2016年 Wmy. All rights reserved.
//

/************************************************************************
 *  项目 结构图
 *
 *                    --> PreviewVC                     --> LeftVC
 *                   |                                 |
 *  Nav : RootVC --> |--> LoginVC      --> SideVC  --> |
 *                   |                |                |
 *                    --> MainVC  --> |                 --> RightVC
 *                                    |
 *                                     --> HomeVC
 *
 ************************************************************************/


#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

