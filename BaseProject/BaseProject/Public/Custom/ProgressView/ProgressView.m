//
//  ProgressView.m
//  ZT
//
//  Created by Wmy on 15/8/27.
//  Copyright (c) 2015年 soshare. All rights reserved.
//

#import "ProgressView.h"

static const CGFloat progressH = 6.0;
static const CGFloat timeInterval = 1.0;

@interface ProgressView ()
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, assign) CGFloat selfW;
@property (nonatomic, assign) BOOL animated;
@end

@implementation ProgressView

#pragma mark - life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self UIConfig];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    [self setSelfW:self.bounds.size.width];
}

- (void)awakeFromNib {
    [self UIConfig];
}

- (void)UIConfig {
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.layer.cornerRadius = progressH / 2;
    [self addSubview:self.progressView];
}


#pragma mark - getter & setter
- (void)setSelfW:(CGFloat)selfW {
    _selfW = selfW;
    [self setProgress:_progress animated:_animated];
}

- (void)setProgress:(CGFloat)progress {
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    if (!progress || progress < 0.01) {
        _progress = 0.01;
    }
    
    _progress = progress;
    _animated = animated;
    
    if (progress > 1.0) {
        _progressView.backgroundColor = COLOR_Theme;
    }
    else
        _progressView.backgroundColor = RGB(48, 172, 54);
    
    CGRect rect = self.progressView.frame;
    
    rect.size.width = _selfW * (_progress>1.0 ? 1.0 : _progress);
    
    if (animated)
        [UIView animateWithDuration:timeInterval
                         animations:^{
                             _progressView.frame = rect;
                         } completion:^(BOOL finished) {
                             
                         }];
    else
        _progressView.frame = rect;
    

}

//- (void)setProgressColor:(UIColor *)progressColor {
//    self.progressView.backgroundColor = progressColor;
//}

//- (void)setTrackColor:(UIColor *)trackColor {
//    self.backgroundColor = trackColor;
//}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, progressH)];
        [_progressView.layer setCornerRadius:progressH/2.0];
    }
    return _progressView;
}

@end
