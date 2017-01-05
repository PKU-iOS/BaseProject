//
//  NavigationController.h
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "RTRootNavigationController.h"

@interface NavigationController : RTRootNavigationController

@end


@interface NavigationController (PushExt)
- (void)pushViewController:(NSString *)controllerName parameters:(id)parameters;
@end


@interface NavigationController (GoBackExt)
- (void)goBack;
- (void)goBackAnimated:(BOOL)animated;
@end
