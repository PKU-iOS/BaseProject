//
//  UIViewController+runtime.m
//  WaveView
//
//  Created by Wmy on 2016/11/10.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "UIViewController+runtime.h"
#import <objc/runtime.h>

@implementation UIViewController (runtime)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        swizzleMethod(class, @selector(viewDidLoad), @selector(swizzling_viewDidLoad));
        swizzleMethod(class, @selector(viewWillAppear:), @selector(swizzling_viewWillAppear:));
        swizzleMethod(class, @selector(viewWillDisappear:), @selector(swizzling_viewWillDisappear:));
    });
}

void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)swizzling_viewDidLoad {
    [self inject_viewDidLoad];
    [self swizzling_viewDidLoad];
}

- (void)swizzling_viewWillAppear:(BOOL)animated {
    [self inject_viewWillAppear:animated];
    [self swizzling_viewWillAppear:animated];
}

- (void)swizzling_viewWillDisappear:(BOOL)animated {
    [self inject_viewWillDisappear:animated];
    [self swizzling_viewWillDisappear:animated];
}

- (void)inject_viewDidLoad {
    NSLog(@"%s", __func__);
    
}

- (void)inject_viewWillAppear:(BOOL)animated {
    NSLog(@"%s", __func__);
    
}

- (void)inject_viewWillDisappear:(BOOL)animated {
    NSLog(@"%s", __func__);
    
}


@end
