//
//  SideViewController.h
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "BaseViewController.h"

static const CGFloat kAnimationDuration     = 0.26f;  // 动画时长
static const CGFloat kRightVCShowPercentMax = 0.7f;   // 右边栏显示百分比
static const CGFloat kCoverBtnAlphaMax = 0.5;   // 遮盖透明度
static const BOOL kShowBoundsShadow    = YES;   // 是否显示边框阴影

// 可在此block中重做动画效果
typedef void(^RootViewMoveBlock)(UIView *rootView, CGRect orginFrame, CGFloat xoffset);

@interface SideViewController : BaseViewController

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIViewController *rightViewController;
@property (nonatomic, assign) BOOL needSwipeShowMenu;               // default is YES.
@property (nonatomic, copy) RootViewMoveBlock rootViewMoveBlock;    // 使用外部自定义动画

- (void)setRootViewMoveBlock:(RootViewMoveBlock)rootViewMoveBlock;
- (void)showRightViewController:(BOOL)animated;     // 展示右边栏
- (void)hideSideViewController:(BOOL)animated;      // 恢复正常位置

@end
