//
//  SideViewController.m
//  BaseProject
//
//  Created by Wmy on 2016/12/30.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "SideViewController.h"

typedef NS_ENUM(NSUInteger, SideType) {
    SideTypeNone = 0,
    SideTypeRightShow,
    SideTypeRightHide
};

@interface SideViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) SideType sideType;                // side当前状态
@property (nonatomic, strong) UIView *rootView;         // rootViewController.view
@property (nonatomic, strong) UIView *rightView;        // rightViewController.view
@property (nonatomic, strong) UIButton *coverButton;    // 展开后rootView上的覆盖层
@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation SideViewController

#pragma mark -
#pragma mark - lile cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.needSwipeShowMenu = NO;
    }
    return self;
}

- (id)init{
    return [self initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!self.rootViewController) {
        NSAssert(NO, @"you must set rootViewController!!");
    }
    
    if (_rootView != _rootViewController.view) {
        [_rootView removeFromSuperview];
        _rootView = _rootViewController.view;
        [self.view addSubview:_rootView];
        _rootView.frame = self.view.bounds;
    }
}

#pragma mark -
#pragma mark - ShowOrHideTheView

- (void)willShowRightViewController {
    if (!_rightViewController || _rightView.superview) return;
    
    [_rootView addSubview:self.coverButton];
    _coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
    
    _rightView = _rightViewController.view;
    _rightView.frame = (CGRect){{kSCREEN_WIDTH, 0}, {kSCREEN_WIDTH, kSCREEN_HEIGHT}};
    [self.view insertSubview:_rightView aboveSubview:_rootView];
    
    [self showShadow:kShowBoundsShadow];
    
}

- (void)showRightViewController:(BOOL)animated {
    if (!_rightViewController) return;
    
    if (!_rightView || !_coverButton) {
        [self willShowRightViewController];
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        _rightView.transform = CGAffineTransformMakeTranslation(-kSCREEN_WIDTH * kRightVCShowPercentMax, 0);
        if (_coverButton) {
            _coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kCoverBtnAlphaMax];
        }
    } completion:^(BOOL finished) {
        _sideType = SideTypeRightHide;
    }];
    
}

- (void)hideSideViewController:(BOOL)animated {
    [UIView animateWithDuration:kAnimationDuration animations:^{
        _rightView.transform = CGAffineTransformIdentity;
        if (_coverButton) {
            _coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.01];
        }
    } completion:^(BOOL finished) {
        [self showShadow:NO];
        [_coverButton removeFromSuperview];
        _coverButton = nil;
        [_rightView removeFromSuperview];
        _rightView = nil;
        _sideType = SideTypeNone;
    }];
}

- (void)hideSideViewController {
    [self hideSideViewController:YES];
}

#pragma mark -
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)panGesture {
    
    if (panGesture != _panGestureRecognizer) return YES;
    
    CGPoint translation = [panGesture translationInView:self.view];
    if (ABS(translation.x)/ABS(translation.y) <= 1) return NO;
    
    if (_sideType == SideTypeNone || (_sideType == SideTypeRightHide && translation.x > 0)) {
        return YES;
    }
    
    return NO;
}

#pragma mark -
#pragma mark - UIGestureRecognizer

- (void)panGesture:(UIPanGestureRecognizer *)pan {
    
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGFloat vx = [pan velocityInView:self.view].x;
            if (vx < 0 && !_rightView) {
                _sideType = SideTypeRightShow;
                [self willShowRightViewController];
            }
            
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            CGFloat tx = [pan translationInView:self.view].x;
            CGFloat percent = tx / (kSCREEN_WIDTH * kRightVCShowPercentMax);
            
            switch (_sideType) {
                case SideTypeRightShow:
                    percent = ABS(fmaxf(-1.0, fminf(percent, 0.0)));
                    break;
                case SideTypeRightHide:
                    percent = fminf(fmaxf(0, 1 - percent), 1.0);
                    break;
                    
                default:
                    break;
            }
            [self updateInteractiveTransitionWithPercent:percent];
        }
            break;
            
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
        {
            CGFloat vx = [pan velocityInView:pan.view].x;
            
            if (_sideType == SideTypeRightShow &&
                (pan.state == UIGestureRecognizerStateCancelled || vx > 0)) {
                _sideType = SideTypeRightHide;
            }
            else if (_sideType == SideTypeRightHide &&
                     (pan.state == UIGestureRecognizerStateCancelled || vx < 0)) {
                _sideType = SideTypeRightShow;
            }
            [self sideAnimationEnded];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)updateInteractiveTransitionWithPercent:(CGFloat)percent {
    
    CGFloat tx = 0;
    
    switch (_sideType) {
            
        case SideTypeRightShow:
        case SideTypeRightHide:
        {
            tx = -(kSCREEN_WIDTH * percent * kRightVCShowPercentMax);
            _rightView.transform = CGAffineTransformMakeTranslation(tx, 0);
            if (_coverButton) {
                _coverButton.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:kCoverBtnAlphaMax * percent];
            }
        }
            break;
            
        default:
            break;
    }
    
}

- (void)sideAnimationEnded {
    
    switch (_sideType) {
        case SideTypeRightShow:
            [self showRightViewController:YES];
            break;
            
        case SideTypeRightHide:
            [self hideSideViewController];
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark - setter

- (void)setRootViewController:(UIViewController *)rootViewController {
    if (_rootViewController == rootViewController) return;
    
    if (_rootViewController)
        [_rootViewController removeFromParentViewController];
    
    _rootViewController = rootViewController;
    if (_rootViewController)
        [self addChildViewController:_rootViewController];
}

- (void)setRightViewController:(UIViewController *)rightViewController {
    if (_rightViewController == rightViewController) return;
    
    if (_rightViewController)
        [_rightViewController removeFromParentViewController];
    
    _rightViewController = rightViewController;
    if (_rightViewController)
        [self addChildViewController:_rightViewController];
}

- (void)setNeedSwipeShowMenu:(BOOL)needSwipeShowMenu {
    _needSwipeShowMenu = needSwipeShowMenu;
    if (needSwipeShowMenu) {
        if (!_panGestureRecognizer) {
            [self.view addGestureRecognizer:self.panGestureRecognizer];
        }
    }else{
        [self.view removeGestureRecognizer:_panGestureRecognizer];
        _panGestureRecognizer = nil;
    }
}

- (void)showShadow:(BOOL)show {
    _rightView.layer.shadowOpacity    = show ? 0.8f : 0.0f;
    if (show) {
        _rightView.layer.cornerRadius = 4.0f;
        _rightView.layer.shadowOffset = CGSizeZero;
        _rightView.layer.shadowRadius = 4.0f;
        _rightView.layer.shadowPath   = [UIBezierPath bezierPathWithRect:_rightView.bounds].CGPath;
    }
}

#pragma mark -
#pragma mark - getter

- (UIPanGestureRecognizer *)panGestureRecognizer {
    if (!_panGestureRecognizer) {
        _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(panGesture:)];
        _panGestureRecognizer.delegate = self;
    }
    return _panGestureRecognizer;
}

- (UIButton *)coverButton {
    if (!_coverButton) {
        _coverButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _coverButton.frame = _rootView.bounds;
        _coverButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [_coverButton addTarget:self action:@selector(hideSideViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _coverButton;
}


@end
