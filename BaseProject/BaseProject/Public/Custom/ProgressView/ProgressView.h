//
//  ProgressView.h
//  ZT
//
//  Created by Wmy on 15/8/27.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

//@property(nonatomic, strong) UIColor* progressColor;
//@property(nonatomic, strong) UIColor* trackColor;
@property(nonatomic, assign) CGFloat progress;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
