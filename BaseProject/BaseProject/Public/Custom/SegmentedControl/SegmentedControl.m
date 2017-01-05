//
//  SegmentedControl.m
//  GJT
//
//  Created by Wmy on 2016/11/1.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "SegmentedControl.h"
#import "BadgeButton.h"

static NSInteger kSeparationLineTagMin = 200;

@interface SegmentedControl ()
@property (nonatomic, strong) UIView *bottomLine;
@property (nonatomic, strong) UIView *bottomSelectedLine;
@property (nonatomic, strong) NSArray *segBtnArr;
@end

@implementation SegmentedControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.separationLineHidden = YES;
        self.bottomLineHidden = YES;
        self.bottomSelectedLineHidden = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat selfW = self.bounds.size.width;
    CGFloat selfH = self.bounds.size.height;

    
    CGFloat btnW = selfW / _segments.count;
    CGFloat btnH = selfH - 1;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            CGFloat btnX = btn.tag * btnW;
            btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        }
        
        if (!_separationLineHidden) {
            // 重置按钮间分割线坐标
            if ([subView isKindOfClass:[UIView class]]) {
                UIView *line = (UIView *)subView;
                if (line.tag >= kSeparationLineTagMin) {
                    line.frame = CGRectMake((line.tag - kSeparationLineTagMin + 1) * btnW, 10, 0.5, btnH - 20);
                }
            }
        }
    }
    
    if (!_bottomLineHidden && _bottomLine) {
        _bottomLine.frame = CGRectMake(0, selfH - 0.5, selfW, 0.5);
    }
    
    if (!_bottomSelectedLineHidden && _bottomSelectedLine) {
        [UIView animateWithDuration:0.2 animations:^{
            _bottomSelectedLine.frame = CGRectMake(_selectedSegment * btnW, btnH - 2, btnW, 2);
        }];
    }
    
}


#pragma mark - 事件

- (void)actionWithSegCtrl:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    [self setSelectedSegment:button.tag];
    
    // 响应事件
    if (_delegate && [_delegate respondsToSelector:@selector(segmentControl:clickedButtonAtIndex:)]) {
        [_delegate segmentControl:self clickedButtonAtIndex:button.tag];
    }else
        NSLog(@"you need add 'delegate' and responds selector (segmentControl:clickedButtonAtIndex:)");
}



/**
 设置分类按钮badge 为0时不显示
 */
- (void)setBadgeNumber:(NSInteger)number atIndex:(NSInteger)index {
    if (index >= _segments.count) {
        return;
    }
    
    BadgeButton *btn = self.segBtnArr[index];
    if (btn) {
        btn.badgeValue = number;
    }
}

/**
 设置选中标记滚动线滚动滚动比 0.0~1.0
 */
- (void)setSelectedLineScrollPercent:(CGFloat)percent {
    if (_bottomSelectedLineHidden || !_bottomSelectedLine) {
        return;
    }
    
    CGRect rect = _bottomSelectedLine.frame;
    rect.origin.x = (self.bounds.size.width - rect.size.width) * percent;
    _bottomSelectedLine.frame = rect;
    
    NSInteger index = ((rect.origin.x / rect.size.width) + 0.5);
    [self updateSegmentSelectedIndex:index];

}

- (void)updateSegmentSelectedIndex:(NSInteger)index {
    if (index >= _segments.count) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            if (index == btn.tag) {
                btn.selected = YES;
                btn.userInteractionEnabled = NO;
            }else {
                btn.selected = NO;
                btn.userInteractionEnabled = YES;
            }
        }
    }
}

#pragma mark - setter

- (void)setSelectedSegment:(NSInteger)selectedSegment {
    _selectedSegment = selectedSegment;
    [self updateSegmentSelectedIndex:selectedSegment];
}

- (void)setBottomLineHidden:(BOOL)bottomLineHidden {
    _bottomLineHidden = bottomLineHidden;
    if (bottomLineHidden) {
        [self removeBottomLine];
    }else {
        [self addBottomLine];
    }
}

- (void)setSeparationLineHidden:(BOOL)separationLineHidden {
    _separationLineHidden = separationLineHidden;
    if (separationLineHidden) {
        [self removeSeparationLine];
    }else {
        [self addSeparationLine];
    }
}

- (void)setBottomSelectedLineHidden:(BOOL)bottomSelectedLineHidden {
    _bottomSelectedLineHidden = bottomSelectedLineHidden;
    if (bottomSelectedLineHidden) {
        [self removeBottomSelectedLine];
    }else {
        [self addBottomSelectedLine];
    }
}

- (void)setSegments:(NSArray *)segments {
    _segments = segments;
    
    if (segments.count) {
        
        // 添加btn
        NSMutableArray *btnArrM = [NSMutableArray array];
        for (int i = 0; i<segments.count; i++) {
            NSString *title = segments[i];
            BadgeButton *segmentBtn = [self segmentedBtnWithTitle:title tag:i];
            [self addSubview:segmentBtn];
            [btnArrM addObject:segmentBtn];
        }
        [self setNeedsLayout];
        self.segBtnArr = [NSArray arrayWithArray:btnArrM];
        
        [self setSeparationLineHidden:_separationLineHidden];
        
    }
}


#pragma mark - UI

/**
 按钮间的分割线
 */
- (void)removeSeparationLine {
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIView class]]) {
            UIView *line = (UIView *)subView;
            if (line.tag >= kSeparationLineTagMin) {
                [line removeFromSuperview];
                line = nil;
            }
        }
    }
}

- (void)addSeparationLine {
    [self removeSeparationLine];
    if (_segments.count < 1) {
        return;
    }
    
    for (int i = 0; i<_segments.count - 1; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        [line setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3]];
        [line setTag:kSeparationLineTagMin + i];
        [self addSubview:line];
    }
    [self setNeedsLayout];
}

/**
 底部线
 */
- (void)removeBottomLine {
    if (_bottomLine) {
        [_bottomLine removeFromSuperview];
        _bottomLine = nil;
    }
}

- (void)addBottomLine {
    [self removeBottomLine];
    [self addSubview:self.bottomLine];
    [self setNeedsLayout];
}


/**
 底部选中标识线
 */
- (void)removeBottomSelectedLine {
    if (_bottomSelectedLine) {
        [_bottomSelectedLine removeFromSuperview];
        _bottomSelectedLine = nil;
    }
}

- (void)addBottomSelectedLine {
    [self removeBottomSelectedLine];
    [self addSubview:self.bottomSelectedLine];
    [self setNeedsDisplay];
}

#pragma mark - getter

- (BadgeButton *)segmentedBtnWithTitle:(NSString *)title tag:(NSInteger)tag {
    
    BadgeButton *btn = [BadgeButton buttonWithType:UIButtonTypeCustom];
    
    NSMutableAttributedString *normalTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [normalTitle addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:[UIColor blackColor]}
                         range:NSMakeRange(0, title.length)];
    NSMutableAttributedString *selectedTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [selectedTitle addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15],
                                   NSForegroundColorAttributeName:COLOR_Theme}
                           range:NSMakeRange(0, title.length)];
    
    [btn setAttributedTitle:normalTitle forState:UIControlStateNormal];
    [btn setAttributedTitle:selectedTitle forState:UIControlStateSelected];
    
    [btn setTag:tag];
    [btn addTarget:self action:@selector(actionWithSegCtrl:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIView *)bottomSelectedLine {
    if (!_bottomSelectedLine) {
        _bottomSelectedLine = [[UIView alloc] initWithFrame:CGRectZero];
        _bottomSelectedLine.backgroundColor = COLOR_Theme;
    }
    return _bottomSelectedLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] initWithFrame:CGRectZero];
        [_bottomLine setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _bottomLine;
}


@end
